function [N, MIN, MAX] = BSplines_params_by_h(X, h, N_min, pow_2)
	
%%%%%%%%%%%%%%%%%%% Botev's interval selection %%%%%%%%%%%%%%%%%%%%%%
if nargin < 3
    N_min = 2^5;
end
if nargin < 4
    pow_2 = 0;
end

minimum = min(X);
maximum = max(X);
Range = maximum - minimum;
MIN = minimum - Range/2;
MAX = maximum + Range/2;

N = ceil((MAX - MIN)/h);
N = max(N_min, N);

d = ((N-1)*h - (MAX - MIN))/2;
MAX = MAX + d;
MIN = MIN - d;

if pow_2 == 1
   %%% Adjust grid to next power of 2
    mtilde = log2( (MAX - MIN)/h);
    m = ceil(mtilde);
    m = max(floor(log2(N_min)),m);

    N = 2^m;
    N = max(N_min, N); 
end

end
