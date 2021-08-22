function y = BSpline2(order,a,x,c)
%Basis Spline evaluation
%   a = dilation factor  (ie resolution)
%   c = center of spline (this is point x_n on the grid)
%   n = order of spline
%       n=0: harr [-.5,.5]
%       n=1: tent [-1,1]
%       n=2: quadratic [-1.5,1.5]
%       n=3: cubic [-2,2]

a3 = a^(1.5);
delta = 1/a;
y = zeros(size(x));

if order == 1 %Linear
    y(c-delta < x & x <=c) = a3*(x(c - delta < x & x <=c) - c + delta);
    y(c < x & x < c+delta) = a3*(c + delta - x(c < x & x < c + delta));
end

end