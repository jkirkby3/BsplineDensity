function normSqr = estimateNormSquare_kde( data,n,MIN,MAX )
% Function to estimate the squared norm of density (roughness) using
% the KDE estimator approach of Botev et al.

data=data(:); %make data a column vector
if nargin<2 % if n is not supplied switch to the default
    n=2^14;
end
n=2^ceil(log2(n)); % round up n to the next power of 2;
if nargin<4 %define the default  interval [MIN,MAX]
    minimum=min(data); maximum=max(data);
    Range=maximum-minimum;
    MIN=minimum-Range/2; MAX=maximum+Range/2;
end
% set up the grid over which the density estimate is computed;
R=MAX-MIN; dx=R/(n-1); xmesh=MIN+[0:dx:R]; N=length(unique(data));
%bin the data uniformly using the grid defined above;
initial_data=histc(data,xmesh)/N;  initial_data=initial_data/sum(initial_data);
a=dct1d(initial_data); % discrete cosine transform of initial data
% now compute the optimal bandwidth^2 using the referenced method
I=[1:n-1]'.^2; a2=(a(2:end)/2).^2;
% use  fzero to solve the equation t=zeta*gamma^[5](t)
t_star=root(@(t)fixed_point(t,N,I,a2),N);  %%% THIS GIVES t_1 ?????

%%%t_star = 0.90*t_star;  %%% This is on pg. 18... but is it necessary????

bandwidth=sqrt(t_star)*R;

%%%%%%%%%%%%%%%%%%%
%%% OR: From equation (27)
%%%%%%%%%%%%%%%%
% C = (1 + 1/2^(3/2))/3;
% normSqr = t_star^(-5/2) * C / (N*sqrt(pi/2));

%%%%%%%%%%%%%%%%%%%
%%% OR: From equation (38)
%%%%%%%%%%%%%%%%
%normSqr = t_star^(-5/1) / (2*N*sqrt(pi)) ;

normSqr = bandwidth^(-5/1) / (2*N*sqrt(pi)) ;


end


%################################################################
function  out=fixed_point(t,N,I,a2)
% this implements the function t-zeta*gamma^[l](t)
l=7;
f=2*pi^(2*l)*sum(I.^l.*a2.*exp(-I*pi^2*t));
for s=l-1:-1:2
    K0=prod([1:2:2*s-1])/sqrt(2*pi);  const=(1+(1/2)^(s+1/2))/3;
    time=(2*const*K0/N/f)^(2/(3+2*s));
    f=2*pi^(2*s)*sum(I.^s.*a2.*exp(-I*pi^2*time));
end
out=t-(2*N*sqrt(pi)*f)^(-2/5);
% ie solution is t = (2*N*sqrt(pi)*f)^(-2/5)
% so f = t^(-5/2) / (2*N*sqrt(pi))

end



%##############################################################
function out = idct1d(data)

% computes the inverse discrete cosine transform
[nrows,ncols]=size(data);
% Compute weights
weights = nrows*exp(i*(0:nrows-1)*pi/(2*nrows)).';
% Compute x tilde using equation (5.93) in Jain
data = real(ifft(weights.*data));
% Re-order elements of each column according to equations (5.93) and
% (5.94) in Jain
out = zeros(nrows,1);
out(1:2:nrows) = data(1:nrows/2);
out(2:2:nrows) = data(nrows:-1:nrows/2+1);
%   Reference:
%      A. K. Jain, "Fundamentals of Digital Image
%      Processing", pp. 150-153.
end
%##############################################################

function data=dct1d(data)
% computes the discrete cosine transform of the column vector data
[nrows,ncols]= size(data);
% Compute weights to multiply DFT coefficients
weight = [1;2*(exp(-i*(1:nrows-1)*pi/(2*nrows))).'];
% Re-order the elements of the columns of x
data = [ data(1:2:end,:); data(end:-2:2,:) ];
% Multiply FFT by weights:
data= real(weight.* fft(data));
end

function t=root(f,N)
% try to find smallest root whenever there is more than one
N=50*(N<=50)+1050*(N>=1050)+N*((N<1050)&(N>50));
tol=10^-12+0.01*(N-50)/1000;
flag=0;
while flag==0
    try
        t=fzero(f,[0,tol]);
        flag=1;
    catch
        tol=min(tol*2,.1); % double search interval
    end
    if tol==.1 % if all else fails
        t=fminbnd(@(x)abs(f(x)),0,.1); flag=1;
    end
end
end





