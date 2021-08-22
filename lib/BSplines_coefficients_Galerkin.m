function beta = BSplines_coefficients_Galerkin(X, order, N, a, xmin, enforce_positive)

if nargin < 6
    enforce_positive = 1;
end

switch(order)
    case 0
        G = eye(N);
    case 1
        p = 1/6;
        G = (4/6)*eye(N) + diag(p*ones(N-1,1), 1) + diag(p*ones(N-1,1), -1);
        G(1,1)=1/3; G(N,N)=1/3;

    otherwise
        error('Order not implmented yet!!')
end

theta = zeros(N+1,1); % We add an extra one at the end for convenience in loop below (to avoid if statement at right boundary)

K = floor((X - xmin)*a + 1);
XK = xmin + (K-1)./a;
Lam = (X - XK)*a;
for k = 1:N
    Lamk = Lam(k == K);
    theta(k) = theta(k) + sum(1 - Lamk);
    theta(k+1) = theta(k+1) + sum(Lamk);
end

n = length(X);
theta = (a^(0.5)/n)*theta(1:N);
beta = G\theta;

if enforce_positive == 1
    beta = make_beta_positive(beta, 1e-18);
    beta = beta * (a^0.5/sum(beta));
end

end

function beta = make_beta_positive(beta, eps)

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

