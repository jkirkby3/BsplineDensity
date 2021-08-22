function CV_h = BSplines_LCV(h, beta, X, order, xmin)

N = length(beta);
n = length(X);

a = 1/h;

S_N = 0;
switch(order)

    case 0
        K = floor((X - xmin)*a + 1);
        XK = xmin + (K-1)./a;
        Lam = (X - XK)*a;
        for k = 1:N-1
            Lamk = Lam(k==K);
            S_N = S_N + sum( (n*beta(k) - 1)*(Lamk < 0.5)...
                + (n*beta(k+1) - 1)*(Lamk >= 0.5) );
        end
        CV_h = -(a^0.5/(n*(n - 1)))*S_N;

    case 1

        K = floor((X - xmin)*a + 1);
        XK = xmin + (K-1)./a;
        Lam = (X - XK)*a;

        cons = a^0.5*(3/sqrt(3))/n;
        cons2 = (sqrt(3) - 2)*2;
        for k = 1:N-1
            Lamk = Lam(k==K);
            S_N = S_N + sum( (1 - Lamk)*beta(k) + Lamk*beta(k+1)...
                - cons*(1 - 2*Lamk + 2*Lamk.^2 + cons2*Lamk.*(1-Lamk)) );
        end
        CV_h = -(a^0.5/(n-1))*S_N;

    otherwise
        disp('Order not implmented yet!!')

end

end