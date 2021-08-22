function h = BSplines_bandwidth(X, order, bw_method, theta_override)
% Estimate the bandwidth according the methods:
%   'LCV' - Likelihood Cross-Validation
%   'LSCV' - Least-Squares Cross-Validation
%   'RuleOfThumb' - Adaptive Heuristic Rule of Thumb, See Cui, Kirkby and Nguyen (2019)
%   'Plugin' - Uses a plugin rule to estimate (theta_override allows you to make this over/undersmooth)	
%   'NormalRule' - the standard rule of thumb for normal data

if nargin < 4
    % overrides the theta parameter for Plugin/Rule of Thumb estimators, to
    % control over vs under smoothing
    theta_override = 0;
end

switch(bw_method)
    case 'LCV'
        % Likelihood Cross-Validation
        range = max(X) - min(X);
        h = fminbnd(@(h) BSplines_LCV_function(h, X, order), range/1000, range/10, optimset('TolX', 1e-2));

    case 'LSCV'
        % Least-Squares Cross-Validation
        range = max(X) - min(X);
        h = fminbnd(@(h) BSplines_LSCV_function(h, X, order), range/1000, range/10, optimset('TolX', 1e-2));

    case 'RuleOfThumb'
        % This is the heuristic adaptive rule of thumb
        h = getBandwidth_RuleOfThumb(X, order, theta_override, std(X));

    case 'Plugin'	
        % Plugin method, estimates roughness using KDE
        h = getBandwidth_Plugin(X, order, theta_override);

    case 'NormalRule'
        % Traditional normal rule of thumb
        h = getBandwidth_NormalRule( order, std(X), length(X), theta_override);
        
    otherwise
        disp('Bandwidth selection method not implmented!!')
end
	

end



function h = getReducedBinWidthByMaximalMass( Samp, sigma, h)
% Maxmial Bin Mass for a Normal density with same stddev
p = normcdf(h/2,0,sigma) - normcdf(-h/2,0,sigma);

maxCountAllowed = length(Samp)*p;
%normalMult = 3.5; % how many standard deviations on each side of zero

maxSamp = max(Samp);
minSamp = min(Samp);

%Nbins = 2*sigma*normalMult / h - 1;
Nbins = round((maxSamp - minSamp)/h - 1);
Nbins = min(length(Samp), Nbins);

[counts, centers] = hist(Samp, Nbins);  % As an approximation
maxCounts = max(counts);

while  maxCounts > maxCountAllowed
    h = h * (maxCountAllowed / maxCounts);
    
    %Nbins = 2*sigma*normalMult / h - 1;
    Nbins = (maxSamp - minSamp)/h - 1;
    
    [counts, centers] = hist(Samp, Nbins);  % As an approximation
    maxCounts = max(counts);
end

end


function h = getBandwidth_RuleOfThumb( Samp, order, theta_override, stddev )
% stddev = std(Samp);
%%% IQR Robust Version
% zeta = 2.5;

IQR = iqr(Samp);
kurt = kurtosis(Samp);

exKurt = max(0, kurt - 3);
zeta = 2.5 + (1 - exp(-exKurt));

stddev = min(stddev, IQR/zeta);

N_sim = max(size(Samp));  % chooses the larger dimension, so we dont need to know if row or column vector
h_0 = getBandwidth_NormalRule( order, stddev, N_sim, theta_override);  % used to initialize

h = getReducedBinWidthByMaximalMass( Samp, stddev, h_0);

end

function h = getBandwidth_NormalRule( order, sigma, N_sim, theta_override)
% Return rule of thumb bandwidth for normal data
% 

if order == 0
    C = 0.288675^2;
    theta = 1;
    R = 1;
    cons = 2;
    
elseif order == 1
    C = (3.72678 * 10^-2)^2;
    theta = 4/3;
    R = 1.73205;
    cons = 2/3;
    
elseif order == 2
    C = (5.75055 * 10^-3)^2;
    theta = 2;
    R = 2.84217;
    cons = 4/45;
    
elseif order == 3
    C = (9.09241 * 10^-4)^2;
    theta = 2;
    R = 4.96473;
    cons = 4/105;
end

if theta_override > 0
    theta = theta_override;
end
    
h = sigma * ( cons * theta * sqrt(pi) * R / C / N_sim)^(1/(2*order+3));

end


function h = getBandwidth_Plugin( Samp, order, theta_override)
p = order;

%%%% Get rule of thumb with plugin
if p == 0
    C = 0.288675^2;
    theta = 1;
    R = 1;    
elseif p == 1
    C = (3.72678 * 10^-2)^2;
    theta = 4/3;
    R = 1.73205;
    
elseif p == 2
    C = (5.75055 * 10^-3)^2;
    theta = 2;
    R = 2.84217;
    
elseif p == 3
    C = (9.09241 * 10^-4)^2;
    theta = 2;
    R = 4.96473;
end

if theta_override > 0
    theta = theta_override;
end

%%%% NOTE: 
normSqr = estimateNormSquare_kde(Samp);  %NOTE: this needs to be generalized in case of p!=1
cons = 1/(2*(p+1));

Ns = length(Samp);
h = ( cons * theta * R / (C * normSqr * Ns))^(1/(2*p+3));

end

function CV_h = BSplines_LSCV_function(h, X, order)

	a = 1/h;
% 	[N, alph] = BSplines_params_by_h(X, h);
% 	xmin = -alph;
	[N, xmin, xmax] = BSplines_params_by_h(X, h);

	beta = BSplines_coefficients_Galerkin(X, order, N, a, xmin);

	CV_h = BSplines_LSCV(h, beta, X, order, xmin);

end

function CV_h = BSplines_LCV_function(h, X, order)

	a = 1/h;
% 	[N, alph] = BSplines_params_by_h(X, h);
% 	xmin = -alph;
	[N, xmin, xmax] = BSplines_params_by_h(X, h);

	beta = BSplines_coefficients_Galerkin(X, order, N, a, xmin);

	CV_h = BSplines_LCV(h, beta, X, order, xmin);

end