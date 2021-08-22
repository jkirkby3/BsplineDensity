function alph = GetGridAlphaForCrazyData( type )
% Helper function to return alpha value (grid width param) for examples
% 
alph = 6;
if strcmp(type, 'claw')
    alph = 6;
elseif strcmp(type, 'weibull')
    alph = 3;
elseif strcmp(type, 'kurtoticUnimodal')
    alph = 6;
elseif strcmp(type, 'stronglySkewed')
    alph = 4;   
elseif strcmp(type, 'skewBimodal')
    alph = 4.5; 
elseif strcmp(type, 'bimodal')
    alph = 10;
elseif strcmp(type, 'separatedBimodal')
    alph = 6;
elseif strcmp(type, 'outlier')
    alph = 4;
elseif strcmp(type, 'skewUnimodal')
    alph = 5;
elseif strcmp(type, 'MJD')
    alph = 2;
elseif strcmp(type, 'DE')
    alph = 2;
elseif strcmp(type, 'smoothComb')
    alph = 4;
elseif strcmp(type, 'discreteComb')
    alph = 8;
elseif strcmp(type, 'trimodal')
    alph = 250;    
elseif strcmp(type, 'studentT')
    alph = 7;    
elseif strcmp(type, 'genExtremeVal') 
    alph = 12;
elseif strcmp(type, 'gamma') 
    alph = 14;
elseif strcmp(type, 'chiSqr') 
    alph = 40;
elseif strcmp(type, 'logNormal') 
    alph = 20;
end

end

