function [pdfVal] = GetPdfCrazyData( type, x )
% Pdf for "crazy" data examples

if strcmp(type, 'normal')
    pdfVal = normpdf(x,0,1);
    
elseif strcmp(type, 'claw')
    pdfVal = 0.5*normpdf(x,0,1) + 1/10*( normpdf(x,0/2 - 1,1/10) + normpdf(x,1/2 - 1,1/10) ...
        + normpdf(x,2/2 - 1,1/10) + normpdf(x,3/2 - 1,1/10) + normpdf(x,4/2 - 1,1/10));
    
elseif strcmp(type, 'asymmetricClaw')    
    pdfVal = 0.5*normpdf(x,0,1) + 2^(1-(-2))/31 * normpdf(x,-2 + 1/2, 2^-2/10) ...
        + 2^(1-(-1))/31 *  normpdf(x,-1 + 1/2, 2^-1/10) ...
        + 2^(1-(0))/31 * normpdf(x,0 + 1/2, 2^0/10) ...
        + 2^(1-(1))/31 * normpdf(x,1 + 1/2, 2^1/10) ...
        + 2^(1-(2))/31 * normpdf(x,2 + 1/2, 2^2/10);

elseif strcmp(type, 'doubleClaw')    
    pdfVal = ...
    + 49/100 *  normpdf(x, -1 , 2/3) ...
    + 49/100 *  normpdf(x, 1 , 2/3) ...
    + 1/350 *  normpdf(x, (0-3)/2, 1/100) ...
    + 1/350 *  normpdf(x, (1-3)/2 , 1/100) ...
    + 1/350 *  normpdf(x, (2-3)/2 , 1/100) ...
    + 1/350 *  normpdf(x, (3-3)/2 , 1/100) ...
    + 1/350 *  normpdf(x, (4-3)/2 , 1/100) ...
    + 1/350 *  normpdf(x, (5-3)/2 , 1/100) ...
    + 1/350 *  normpdf(x, (6-3)/2 , 1/100);
    
elseif strcmp(type, 'asymmetricDoubleClaw')    
        pdfVal = ...
        + 46/100 *  normpdf(x, 2*0 -1 , 2/3) ...
        + 46/100 *  normpdf(x, 2*1 -1 , 2/3) ...
        + 1/300 *  normpdf(x, -1/2 , 1/100) ...
        + 1/300 *  normpdf(x, -2/2 , 1/100) ...
        + 1/300 *  normpdf(x, -3/2 , 1/100) ...
        + 7/300 *  normpdf(x, 1/2 , 7/100) ...
        + 7/300 *  normpdf(x, 2/2 , 7/100) ...
        + 7/300 *  normpdf(x, 3/2 , 7/100);
    
elseif strcmp(type, 'stronglySkewed')    
        pdfVal = ...
        + 1/8 *  normpdf(x, 3*( (2/3)^0 - 1) , (2/3)^0) ...
        + 1/8 *  normpdf(x, 3*( (2/3)^1 - 1) , (2/3)^1) ...
        + 1/8 *  normpdf(x, 3*( (2/3)^2 - 1) , (2/3)^2) ...
        + 1/8 *  normpdf(x, 3*( (2/3)^3 - 1) , (2/3)^3) ...
        + 1/8 *  normpdf(x, 3*( (2/3)^4 - 1) , (2/3)^4) ...
        + 1/8 *  normpdf(x, 3*( (2/3)^5 - 1) , (2/3)^5) ...
        + 1/8 *  normpdf(x, 3*( (2/3)^6 - 1) , (2/3)^6) ...
        + 1/8 *  normpdf(x, 3*( (2/3)^7 - 1) , (2/3)^7);   
    
elseif strcmp(type, 'smoothComb')    
    pdfVal = ...
    + 2^(5 - 0)/63 * normpdf(x, (65 - 96/2^0)/21, (32/63)/(2^0)) ...
    + 2^(5 - 1)/63 *  normpdf(x, (65 - 96/2^1)/21, (32/63)/(2^1)) ...
    + 2^(5 - 2)/63 * normpdf(x, (65 - 96/2^2)/21, (32/63)/(2^2)) ...
    + 2^(5 - 3)/63 * normpdf(x, (65 - 96/2^3)/21, (32/63)/(2^3)) ...
    + 2^(5 - 4)/63 * normpdf(x, (65 - 96/2^4)/21, (32/63)/(2^4));
    
elseif strcmp(type, 'discreteComb')  
    pdfVal = (2/7)*(normpdf(x, (12*0 - 15)/7, 2/7) + normpdf(x, (12*1 - 15)/7, 2/7)...
        + normpdf(x, (12*2 - 15)/7, 2/7))...
    + (1/21)*( normpdf(x, (2*8)/7, 1/21) + normpdf(x, (2*9)/7, 1/21) + normpdf(x, (2*10)/7, 1/21));
    
elseif strcmp(type, 'kurtoticUnimodal')
    pdfVal = 2/3*normpdf(x,0,1) + 1/3 * normpdf(x,0,1/10);
    
elseif strcmp(type, 'bimodal')
    pdfVal = 0.5*normpdf(x,0,1/10) + 0.5 * normpdf(x,5,1);  % Version in KDE PAPER
    %pdfVal = 0.5*normpdf(x,-1,2/3) + 0.5 * normpdf(x,1,2/3);
elseif strcmp(type, 'skewBimodal')
    
    pdfVal = 3/4*normpdf(x,0,1) + 1/4 * normpdf(x,3/2,1/3);
elseif strcmp(type, 'separatedBimodal')
    %pdfVal = 1/2*normpdf(x,-12,1/2) + 1/2*normpdf(x,12,1/2);   % Version in KDE PAPER
    pdfVal = 1/2*normpdf(x,-2,1/2) + 1/2*normpdf(x,2,1/2); 
    
elseif strcmp(type, 'outlier')
    pdfVal = 1/10*normpdf(x,0,1) + 9/10*normpdf(x,0,1/10);
    
elseif strcmp(type, 'skewUnimodal')
    pdfVal = 1/5*normpdf(x,0,1) + 1/5*normpdf(x,1/2,2/3) + 3/5*normpdf(x,13/12,5/9);
    
elseif strcmp(type, 'trimodal_1')
    pdfVal = 9/20*normpdf(x,-6/5,3/5) + 9/20*normpdf(x,6/5,3/5) + 1/10*normpdf(x,0,1/4);
    
elseif strcmp(type, 'trimodal')  % BOTEV VERSION
    pdfVal = 1/3*normpdf(x,80*0, (0 + 1)^2) + 1/3*normpdf(x,80*1, (1 + 1)^2) + 1/3*normpdf(x,80*2, (2 + 1)^2);
    
elseif strcmp(type, 'MJD') || strcmp(type, 'DE')
    r = 0; q = 0;
    
    N = length(x);
    dx = x(2)-x(1);  a = 1/dx;
    
    xmin = x(1);
    
    dw    = 2*pi*a/N;
    omega = dw*(1:N-1);  
    Cons = 24*a^2/N;
    
    if strcmp(type, 'MJD')
        dt = 1/4;
        sigma = 0.08;  lam= 3;  muj = -0.01; sigmaj = 0.4;  
        rnCHF   = @(u)cf_RN_MJD( u, r-q, dt, sigma, muj, sigmaj , lam);
        
    elseif strcmp(type, 'DE')
        dt = 1/4;
        sigma = 0.04; lam   = 2; p_up  = 0.4; eta1  = 3; eta2  = 5; 
        rnCHF   =  @(u)cf_RN_KOU(u,dt,r-q,sigma,lam,p_up,eta1,eta2);
        
    end

    
    grand = rnCHF(omega).*(sin(omega/(2*a))./omega).^2./(2+cos(omega/a));
    pdfVal = a*Cons*real(fft([1/(24*a^2) exp(-1i*xmin*omega).*grand]));

elseif strcmp(type, 'logNormal')
    mu = 1; sigma = 1;
    pdfVal = lognpdf(x,mu, sigma);
    
elseif strcmp(type, 'weibull')
    lambda = 1; kk = 5;
    pdfVal = wblpdf(x, lambda, kk);
    
elseif strcmp(type, 'gamma')
    kk = 9; theta = 0.5;
    pdfVal = gampdf(x, kk, theta);  
    
elseif strcmp(type, 'chiSqr')
    nu = 4;
    pdfVal = chi2pdf(x, nu);    
    
elseif strcmp(type, 'studentT')
    nu = 6;
    pdfVal = tpdf(x, nu);    
    
elseif strcmp(type, 'genExtremeVal')   
    pdfVal = gevpdf(x,0.5,1,0);
    
elseif strcmp(type, 'BirnbaumSaunders')
    pdfVal = pdf('BirnbaumSaunders', x, 0.5, 1);  
    
elseif strcmp(type, 'Nakagami')
    pdfVal = pdf('Nakagami', x, 2, 2);     
    
% elseif strcmp(type, '5modes')    
%     pdfVal = 
%     
%     norm1 = normrnd(80*0, 1, [N_sim,1]);
%     norm2 = normrnd(80*1, 2, [N_sim,1]);
%     norm3 = normrnd(80*2, 3, [N_sim,1]);
%     norm4 = normrnd(80*3, 4, [N_sim,1]);
%     norm5 = normrnd(80*4, 5, [N_sim,1]);
    
end

