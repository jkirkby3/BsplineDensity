function [grid, beta] = BSplines_Estimator( X, order, coeff_method, bandwidth_method, enforce_positive, theta_override, filter_type, filter_order)
% Estimate the B-spline density coefficients using a variety of methods
%
% Author:      Justin Kirkby / Alvaro Leitao
% References: 1) Nonparametric Density Estimation by B-spline Duality. Cui,
%                Kirkby and Nguyen (2019).
%             2) Nonparametric Density Estimation and Bandwidth Selection
%   `           with B-spline bases: a Novel Galerkin Method. Kirkby, Leitao and Nguyen, (2021)
%
% Parameters:
% ------------------------
% X: sample of data (univariate)
% order: order of B-splines, 1 works for all methods (linear)
%
% coeff_method: coefficient estimation method:
%    1 = Galerkin Approach (recommended)
%    2 = ECF Approach
%    3 = Redner (1999) approach (for testing)
%
% bandwidth_method: the bandwidth selection method
%   'LCV' = Likelihood Cross-Validation
%   'LSCV' = Least-Squares Cross-Validation
%   'RuleOfThumb' = Adaptive Heuristic Rule of Thumb, See Cui, Kirkby and Nguyen (2019)
%   'Plugin' = Uses a plugin rule to estimate (theta_override allows you to make this over/undersmooth)	
%   'NormalRule' = the standard rule of thumb for normal data
%
% enforce_positive: if 1, makes all coefficients positive
% theta_override: overrides the theta parameter for Plugin/Rule of Thumb estimators, to control over vs under smoothing
% filter_type: applies only to ECF method, set 0 to turn off, set 1 to use exp filter
% filter_order: if filter type ~= 0, this is the order of filter, e.g. 6 (must be even)

N_min = 2^5;

if nargin < 2
    order = 1;  % linear
end
if nargin < 3
    coeff_method = 1; % Galerkin
end
if nargin < 4
    bandwidth_method = 'LSCV';  % Least-Squares Cross-Validation
end
if nargin < 5
    enforce_positive = 1;
end
if nargin < 6
    theta_override = 0;  % Can be used to override the theta param for plugin method
end
if nargin < 7
    filter_type = 0;
end
if nargin < 8
    filter_order = 8;
end

% 1) Determine bandwidth
h = BSplines_bandwidth(X, order, bandwidth_method, theta_override);

if coeff_method == 1
    % Galerkin
    [N, xmin, xmax] = BSplines_params_by_h(X, h, N_min);
    grid = xmin + (0:N-1)*h;  %actual grid [l,u]
    
    beta = BSplines_coefficients_Galerkin(X, order, N, 1/h, xmin);
    
elseif coeff_method == 2
    % ECF (Empirical Characteristic Function)
    [N, xmin, xmax] = BSplines_params_by_h(X, h, N_min, 1);
    grid = xmin + (0:N-1)*h;  %actual grid [l,u]
    
    beta = BSplines_coefficients_ECF(X, order, N, 1/h, xmin, enforce_positive, filter_type, filter_order);
    
elseif coeff_method == 3
    % Approach of Redner (1999)
    [N, xmin, xmax] = BSplines_params_by_h(X, h, N_min);
    grid = xmin + (0:N-1)*h;  %actual grid [l,u]
    a = 1/h;
    beta = zeros(1,N);
    for i=1:N
        beta(i) = mean(BSpline2(order,a,X,grid(i)));
    end
end

end

