function f = BSplines_density(x, beta, order, a, xmin)
% Evaluates the Bspline density from a set of coefficients, at a set of x
% values

N = length(beta);
xk = ( xmin + (0:N-1)/a )';
f = sum(beta.*varphi_ak(x, a, xk, order), 1);
	
end

function psi = varphi_(x, order)

switch order

    case 0
        psi = (x >= -1/2 & x < 1/2);

    case 1
        psi = (1 + x).*(x >= -1 & x < 0) + (1 - x).*(x >= 0 & x < 1);

    otherwise
        error('Order not implmented yet!!')
end

end

function varphi = varphi_ak(x, a, xk, order)

	varphi = a^(0.5)*varphi_(a*(x - xk), order);
	
end