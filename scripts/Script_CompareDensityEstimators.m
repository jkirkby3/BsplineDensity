%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% B-spline Density Estimator Comparison
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descritpion: Script to Compare Methods For B-spline density estimation
%
% Author:      Justin Kirkby / Alvaro Leitao
% References: 1) Nonparametric Density Estimation by B-spline Duality. Cui,
%                Kirkby and Nguyen (2019).
%             2) Nonparametric Density Estimation and Bandwidth Selection
%                with B-spline bases: a Novel Galerkin Method. Kirkby, Leitao and Nguyen, (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[folder, name, ext] = fileparts(which( mfilename('fullpath')));
cd(folder);
addpath('./helper')
addpath('../lib')

% ================
% Parameters
% ================
bandwidth_method = 'LSCV';  % 'LSCV', 'LCV', 'RuleOfThumb', 'Plugin', 'NormalRule'
enforce_positive = 1;
order = 1;  % keep at 1 for now

% ================
% Choose Example (see SimCrazyData for many more examples)
% ================
type = 'outlier';  % 'bimodal', 'skewBimodal', 'separatedBimodal', 'outlier', 'claw'      

N_sim = 10^5;

% ================

X = SimCrazyData( type, N_sim);

upper = GetGridAlphaForCrazyData(type);
xx = linspace(-upper, upper, 1e5);

figure;
hold on
plot(xx, GetPdfCrazyData(type, xx));

%1) Galerkin Approach
[grid, beta] = BSplines_Estimator( X, order, 1, bandwidth_method, enforce_positive);
h = grid(2) - grid(1); a = 1/h;
z = @(x)BSplines_density(x, beta, order, a, grid(1));
plot(grid, z(grid));

%2) ECF Approach
theta_override = 0;
filter_type = 1;
filter_order = 8;
[grid, beta] = BSplines_Estimator( X, order, 2, bandwidth_method, enforce_positive, filter_type, filter_order);
h = grid(2) - grid(1); a = 1/h;
plot(grid, a^0.5*beta);

%3) Redner's (1999) Approach
[grid, beta] = BSplines_Estimator( X, order, 3, bandwidth_method, enforce_positive);
h = grid(2) - grid(1); a = 1/h;
plot(grid, a^0.5*beta);

legend({'True', 'Galerkin', 'ECF', 'Redner'})

