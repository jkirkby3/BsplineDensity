%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% B-spline Density Estimator Comparison
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descritpion: Script to for B-spline density estimation
%
% Author:      Justin Kirkby / Alvaro Leitao
% References: 1) Nonparametric Density Estimation by B-spline Duality. Cui,
%                Kirkby and Nguyen (2019).
%             2) Nonparametric Density Estimation and Bandwidth Selection
%   `           with B-spline bases: a Novel Galerkin Method. Kirkby, Leitao and Nguyen, (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[folder, name, ext] = fileparts(which( mfilename('fullpath')));
cd(folder);
addpath('./helper')
addpath('../lib')

% ================
% Parameters
% ================
coeff_method = 2; % 1 = Galerkin, 2 = ECF, 3 = Redner
bandwidth_method = 'LSCV';  % 'LSCV', 'LCV', 'RuleOfThumb', 'Plugin', 'NormalRule'
order = 1;  % keep at 1 for now (linear basis)

% ================
% Choose Example (see SimCrazyData for many more examples)
% ================
type = 'skewBimodal';  % 'normal', 'bimodal', 'skewBimodal', 'separatedBimodal', 'outlier', 'claw'      

N_sim = 10^5;

% ================

X = SimCrazyData( type, N_sim);

upper = GetGridAlphaForCrazyData(type);
xx = linspace(-upper, upper, 1e5);

figure;
hold on
plot(xx, GetPdfCrazyData(type, xx));

[grid, beta] = BSplines_Estimator( X, order, coeff_method, bandwidth_method);
h = grid(2) - grid(1); a = 1/h;
plot(grid, a^0.5*beta);


legend({'True', 'Estimate'})

