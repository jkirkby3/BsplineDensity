function beta = BSplines_coefficients_ECF(X, order, N, a, xmin, enforce_positive, filter_type, filter_order)

if order ~= 1
    error("Only linear order=1 currently supported");
end

if nargin < 7
    filter_type = 0;
end

dw    = 2*pi*a/N;
omega = dw*(1:N-1);  

CF = ones(1,N-1);
for j=1:N-1
    CF(j) = mean(cos(omega(j)*X))+ 1i*mean(sin(omega(j)*X));
end 

%%%% Linear PROJ
Cons = a^0.5*(24*a^2/N);
grand = CF.*(sin(omega/(2*a))./omega).^2./(2+cos(omega/a));

if filter_type == 1 % EXPONENTIAL FILTER
    %order of the filter, must be even: 4~8 is good, depends on application
    epsM = 1.2204e-16;   %matlabs machine epsilon
    alphaeps = -log(epsM);
    filter = exp(-alphaeps*(omega/(2*pi*a)).^filter_order);
    grand = filter.*grand;
end

%%%% Linear PROJ
beta = Cons*real(fft([1/(24*a^2) exp(-1i*xmin*omega).*grand]));

%%% Make Adjustments
if enforce_positive
    beta = make_beta_positive(beta);
    beta = beta * (a^0.5/sum(beta));
end

end

function beta = make_beta_positive( beta, eps)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    eps = 1e-18;
end
N = length(beta);
beta(1) = max(eps,beta(1));
beta(end) = max(eps,beta(end));

for k=2:N-1
    if beta(k)<eps   
        diff = (eps-beta(k))/2;
        beta(k) = eps;
        beta(k-1) = max(eps, beta(k-1) - diff);
        beta(k+1) = max(eps, beta(k+1) - diff);
    end
end

end

