function data = SimCrazyData( type, N_sim)
% Method for generating test data
%
data = zeros(N_sim,1);
if strcmp(type, 'normal')
    data = normrnd(0,1,[N_sim,1]);
    
elseif strcmp(type, '5modes')
    unif = rand(N_sim, 1);
    
    norm1 = normrnd(80*0, 1, [N_sim,1]);
    norm2 = normrnd(80*1, 2, [N_sim,1]);
    norm3 = normrnd(80*2, 3, [N_sim,1]);
    norm4 = normrnd(80*3, 4, [N_sim,1]);
    norm5 = normrnd(80*4, 5, [N_sim,1]);
    
    cdf1 = 1/5;
    cdf2 = 2/5;
    cdf3 = 3/5;
    cdf4 = 4/5;

    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4) = norm5(unif > cdf4);
    
elseif strcmp(type, 'stronglySkewed')    
   
    unif = rand(N_sim, 1);
      
    norm1 = normrnd(3*( (2/3)^0 - 1) , (2/3)^0, [N_sim,1]);
    norm2 = normrnd( 3*( (2/3)^1 - 1) , (2/3)^1, [N_sim,1]);
    norm3 = normrnd(3*( (2/3)^2 - 1) , (2/3)^2, [N_sim,1]);
    norm4 = normrnd(3*( (2/3)^3 - 1) , (2/3)^3, [N_sim,1]);
    norm5 = normrnd(3*( (2/3)^4 - 1) , (2/3)^4, [N_sim,1]);
    norm6 = normrnd(3*( (2/3)^5 - 1) , (2/3)^5, [N_sim,1]);
    norm7 = normrnd(3*( (2/3)^6 - 1) , (2/3)^6, [N_sim,1]);
    norm8 = normrnd(3*( (2/3)^7 - 1) , (2/3)^7, [N_sim,1]);
    
    cdf1 = 1/8;
    cdf2 = cdf1 + 1/8;
    cdf3 = cdf2 + 1/8;
    cdf4 = cdf3 + 1/8;
    cdf5 = cdf4 + 1/8;
    cdf6 = cdf5 + 1/8;
    cdf7 = cdf6 + 1/8;

    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4 & unif < cdf5) = norm5(unif > cdf4 & unif < cdf5);
    data(unif > cdf5 & unif < cdf6) = norm6(unif > cdf5 & unif < cdf6);
    data(unif > cdf6 & unif < cdf7) = norm7(unif > cdf6 & unif < cdf7);
    data(unif > cdf7) = norm8(unif > cdf7);    
    
elseif strcmp(type, 'claw')
    unif = rand(N_sim, 1);
    
    sigma = 0.1;
    norm1 = normrnd(0, 1,[N_sim,1]);
    norm2 = normrnd(0/2 -1,sigma,[N_sim,1]);
    norm3 = normrnd(1/2 -1,sigma,[N_sim,1]);
    norm4 = normrnd(2/2 -1,sigma,[N_sim,1]);
    norm5 = normrnd(3/2 -1,sigma,[N_sim,1]);
    norm6 = normrnd(4/2 -1,sigma,[N_sim,1]);
    
    cdf1 = 5/10;
    cdf2 = 6/10;
    cdf3 = 7/10;
    cdf4 = 8/10;
    cdf5 = 9/10;

    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4 & unif < cdf5) = norm5(unif > cdf4 & unif < cdf5);
    data(unif > cdf5) = norm6(unif > cdf5);
    
elseif strcmp(type, 'asymmetricClaw')
    unif = rand(N_sim, 1);
    
    norm1 = normrnd(0, 1,[N_sim,1]);
    norm2 = normrnd(-2 + 1/2, 2^-2/10,[N_sim,1]);
    norm3 = normrnd(-1 + 1/2, 2^-1/10,[N_sim,1]);
    norm4 = normrnd(0 + 1/2, 2^0/10,[N_sim,1]);
    norm5 = normrnd(1 + 1/2, 2^1/10,[N_sim,1]);
    norm6 = normrnd(2 + 1/2, 2^2/10,[N_sim,1]);
    
    
    cdf1 = 1/2;
    cdf2 = cdf1 + 2^(1-(-2))/31;
    cdf3 = cdf2 + 2^(1-(-1))/31;
    cdf4 = cdf3 + 2^(1-(0))/31;
    cdf5 = cdf4 + 2^(1-(1))/31;
    %cdf6 = cdf5 + 2^(1-(2))/31;

    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4 & unif < cdf5) = norm5(unif > cdf4 & unif < cdf5);
    data(unif > cdf5) = norm6(unif > cdf5);    

elseif strcmp(type, 'doubleClaw')    

    unif = rand(N_sim, 1);
      
    norm1 = normrnd(-1 , 2/3, [N_sim,1]);
    norm2 = normrnd( 1 , 2/3, [N_sim,1]);
    norm3 = normrnd((0-3)/2, 1/100, [N_sim,1]);
    norm4 = normrnd((1-3)/2, 1/100, [N_sim,1]);
    norm5 = normrnd((2-3)/2, 1/100, [N_sim,1]);
    norm6 = normrnd((3-3)/2, 1/100, [N_sim,1]);
    norm7 = normrnd((4-3)/2, 1/100, [N_sim,1]);
    norm8 = normrnd((5-3)/2, 1/100, [N_sim,1]);
    norm9 = normrnd((6-3)/2, 1/100, [N_sim,1]);
    
    cdf1 = 49/100;
    cdf2 = cdf1 + 49/100;
    cdf3 = cdf2 + 1/350;
    cdf4 = cdf3 + 1/350;
    cdf5 = cdf4 + 1/350;
    cdf6 = cdf5 + 1/350;
    cdf7 = cdf6 + 1/350;
    cdf8 = cdf6 + 1/350;

    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4 & unif < cdf5) = norm5(unif > cdf4 & unif < cdf5);
    data(unif > cdf5 & unif < cdf6) = norm6(unif > cdf5 & unif < cdf6);
    data(unif > cdf6 & unif < cdf7) = norm7(unif > cdf6 & unif < cdf7);
    data(unif > cdf7 & unif < cdf8) = norm8(unif > cdf7 & unif < cdf8);
    data(unif > cdf8) = norm9(unif > cdf8);        
    
elseif strcmp(type, 'asymmetricDoubleClaw')
    unif = rand(N_sim, 1);
      
    norm1 = normrnd(2*0 -1 , 2/3, [N_sim,1]);
    norm2 = normrnd( 2*1 -1 , 2/3, [N_sim,1]);
    norm3 = normrnd(-1/2 , 1/100, [N_sim,1]);
    norm4 = normrnd(-2/2 , 1/100, [N_sim,1]);
    norm5 = normrnd(-3/2 , 1/100, [N_sim,1]);
    norm6 = normrnd(1/2 , 7/100, [N_sim,1]);
    norm7 = normrnd(2/2 , 7/100, [N_sim,1]);
    norm8 = normrnd(3/2 , 7/100, [N_sim,1]);
    
    cdf1 = 46/100;
    cdf2 = cdf1 + 46/100;
    cdf3 = cdf2 + 1/300;
    cdf4 = cdf3 + 1/300;
    cdf5 = cdf4 + 1/300;
    cdf6 = cdf5 + 7/300;
    cdf7 = cdf6 + 7/300;

    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4 & unif < cdf5) = norm5(unif > cdf4 & unif < cdf5);
    data(unif > cdf5 & unif < cdf6) = norm6(unif > cdf5 & unif < cdf6);
    data(unif > cdf6 & unif < cdf7) = norm7(unif > cdf6 & unif < cdf7);
    data(unif > cdf7) = norm8(unif > cdf7);        

elseif strcmp(type, 'discreteComb')    
    unif = rand(N_sim, 1);
    
    norm1 = normrnd((12*0 - 15)/7, 2/7,[N_sim,1]);
    norm2 = normrnd((12*1 - 15)/7, 2/7,[N_sim,1]);
    norm3 = normrnd((12*2 - 15)/7, 2/7,[N_sim,1]);
    norm4 = normrnd((2*8)/7, 1/21,[N_sim,1]);
    norm5 = normrnd((2*9)/7, 1/21,[N_sim,1]);
    norm6 = normrnd((2*10)/7, 1/21,[N_sim,1]);
    
    cdf1 = 2/7;
    cdf2 = cdf1 + 2/7;
    cdf3 = cdf2 + 2/7;
    cdf4 = cdf3 + 1/21;
    cdf5 = cdf4 + 1/21;
    
    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4 & unif < cdf5) = norm5(unif > cdf4 & unif < cdf5);
    data(unif > cdf5) = norm6(unif > cdf5);    
    
elseif strcmp(type, 'smoothComb')    
    unif = rand(N_sim, 1);
    
    norm1 = normrnd((65 - 96/2^0)/21, (32/63)/(2^0),[N_sim,1]);
    norm2 = normrnd((65 - 96/2^1)/21, (32/63)/(2^1),[N_sim,1]);
    norm3 = normrnd((65 - 96/2^2)/21, (32/63)/(2^2),[N_sim,1]);
    norm4 = normrnd((65 - 96/2^3)/21, (32/63)/(2^3),[N_sim,1]);
    norm5 = normrnd((65 - 96/2^4)/21, (32/63)/(2^4),[N_sim,1]);
    
    cdf1 = 2^(5 - 0)/63;
    cdf2 = cdf1 + 2^(5 - 1)/63;
    cdf3 = cdf2 + 2^(5 - 2)/63;
    cdf4 = cdf3 + 2^(5 - 3)/63;
    cdf5 = cdf4 + 2^(5 - 4)/63;
    
    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    data(unif > cdf2 & unif < cdf3) = norm3(unif > cdf2 & unif < cdf3);
    data(unif > cdf3 & unif < cdf4) = norm4(unif > cdf3 & unif < cdf4);
    data(unif > cdf4 & unif < cdf5) = norm5(unif > cdf4 & unif < cdf5);
    
elseif strcmp(type, 'kurtoticUnimodal')
    unif = rand(N_sim, 1);
    norm1 = normrnd(0,1,[N_sim,1]);
    norm2 = normrnd(0,1/10,[N_sim,1]);
    
    prob1 = 2/3; %prob2 = 1 - prob1;
    data(unif < prob1) = norm1(unif < prob1);
    data(unif >= prob1) = norm2(unif >= prob1);
    
elseif strcmp(type, 'bimodal')
    unif = rand(N_sim, 1);
%     norm1 = normrnd(0,1/5,[N_sim,1]);
%     norm2 = normrnd(3,1,[N_sim,1]);
    norm1 = normrnd(0,1/10,[N_sim,1]);
    norm2 = normrnd(5,1,[N_sim,1]);
    
    %pdfVal = 0.5*normpdf(x,0,1/10) + 0.5 * normpdf(x,5,1);  % Version in KDE PAPER

%     norm1 = normrnd(-1,2/3,[N_sim,1]);
%     norm2 = normrnd(1,2/3,[N_sim,1]);
    
    prob1 = 1/2;   %prob2 = 1 - prob1;
    data(unif < prob1) = norm1(unif < prob1);
    data(unif >= prob1) = norm2(unif >= prob1);
    
elseif strcmp(type, 'skewBimodal')
    unif = rand(N_sim, 1);
    norm1 = normrnd(0, 1, [N_sim,1]);
    norm2 = normrnd(3/2, 1/3, [N_sim,1]);
    
    prob1 = 3/4;   %prob2 = 1 - prob1;
    data(unif < prob1) = norm1(unif < prob1);
    data(unif >= prob1) = norm2(unif >= prob1);
    
elseif strcmp(type, 'separatedBimodal')
    unif = rand(N_sim, 1);
%     norm1 = normrnd(-12, 1/2, [N_sim,1]);   % Version in KDE PAPER
%     norm2 = normrnd(12, 1/2, [N_sim,1]);

    norm1 = normrnd(-2, 1/2, [N_sim,1]);   % Version in KDE PAPER
    norm2 = normrnd(2, 1/2, [N_sim,1]);
    
    prob1 = 1/2;   %prob2 = 1 - prob1;
    data(unif < prob1) = norm1(unif < prob1);
    data(unif >= prob1) = norm2(unif >= prob1);
    
elseif strcmp(type, 'outlier')
    unif = rand(N_sim, 1);
    norm1 = normrnd(0, 1, [N_sim,1]);
    norm2 = normrnd(0, 1/10, [N_sim,1]);
    
    prob1 = 1/10;   %prob2 = 1 - prob1;
    data(unif < prob1) = norm1(unif < prob1);
    data(unif >= prob1) = norm2(unif >= prob1);
    
elseif strcmp(type, 'skewUnimodal')
    unif = rand(N_sim, 1);
    norm1 = normrnd(0, 1, [N_sim,1]);
    norm2 = normrnd(1/2, 2/3, [N_sim,1]);
    norm3 = normrnd(13/12, 5/9, [N_sim,1]);
    
    % pdfVal = 1/5*normpdf(x,0,1) + 1/5*normpdf(x,1/2,2/3) + 3/5*normpdf(x,13/12,5/9);
    
    cdf1 = 1/5;
    cdf2 = 2/5;
    
    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf2) = norm3(unif > cdf2);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    
elseif strcmp(type, 'trimodal_1')
    
    %pdfVal = 9/20*normpdf(x,-6/5,3/5) + 9/20*normpdf(x,6/5,3/5) + 1/10*normpdf(x,0,1/4);
    unif = rand(N_sim, 1);
    norm1 = normrnd(-6/5,3/5, [N_sim,1]);
    norm2 = normrnd(6/5,3/5, [N_sim,1]);
    norm3 = normrnd(0,1/4, [N_sim,1]);
    
    cdf1 = 9/20;
    cdf2 = 18/20;
    
    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf2) = norm3(unif > cdf2);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);
    
elseif strcmp(type, 'trimodal')
    
    % pdfVal = 1/3*normpdf(x,80*0, (0 + 1)^2) + 1/3*normpdf(x,80*1, (1 + 1)^2) + 1/3*normpdf(x,80*2, (1 + 2)^2);
    unif = rand(N_sim, 1);
    norm1 = normrnd(80*0, (0 + 1)^2, [N_sim,1]);
    norm2 = normrnd(80*1, (1 + 1)^2, [N_sim,1]);
    norm3 = normrnd(80*2, (1 + 2)^2, [N_sim,1]);
    
    cdf1 = 1/3;
    cdf2 = 2/3;
    
    data(unif < cdf1) = norm1(unif < cdf1);
    data(unif > cdf2) = norm3(unif > cdf2);
    data(unif > cdf1 & unif < cdf2) = norm2(unif > cdf1 & unif < cdf2);    
    
elseif strcmp(type, 'MJD')
    
    r = 0; q = 0;
    dt = 1/4;
    %sigma = 0.05;  lam= 4;  muj = -0.01; sigmaj = 0.4;
    %sigma = 0.08;  lam= 2;  muj = -0.12; sigmaj = 0.18;  %%% GOOD EXAMPLE
    sigma = 0.08;  lam= 3;  muj = -0.01; sigmaj = 0.4; 
    
    jumpModel = 1;
    jumpParams.kappa = exp(muj + .5*sigmaj^2)-1;
    jumpParams.lambda = lam; jumpParams.muJ = muj; jumpParams.sigJ = sigmaj; 
    data = Simulate_Jump_Diffusion_Log_Returns_func( N_sim, dt, r, q, sigma, jumpModel, jumpParams );
    
elseif strcmp(type, 'DE')
    
    r = 0; q = 0;
    dt = 1/4;
    %sigma = 0.08; lam   = 1; p_up  = 0.4; eta1  = 10; eta2  = 5;  
    %sigma = 0.10; lam   = 2; p_up  = 0.4; eta1  = 20; eta2  = 30; 
    %sigma = 0.05; lam   = 3; p_up  = 0.4; eta1  = 10; eta2  = 5; %%% GOOD
    
    sigma = 0.04; lam   = 2; p_up  = 0.4; eta1  = 3; eta2  = 5; %%% GOOD

    jumpModel = 2;
    kappa  = p_up*eta1/(eta1-1)+(1-p_up)*eta2/(eta2+1)-1;
    jumpParams.lambda = lam; jumpParams.kappa = kappa; jumpParams.eta1 = eta1; jumpParams.eta2 = eta2; jumpParams.p_up = p_up;  
    data = Simulate_Jump_Diffusion_Log_Returns_func( N_sim, dt, r, q, sigma, jumpModel, jumpParams );

elseif strcmp(type, 'logNormal')
    mu = 1; sigma = 1;
    data = lognrnd(mu, sigma, N_sim, 1);

elseif strcmp(type, 'weibull')
    lambda = 1; kk = 5;
    data = wblrnd(lambda, kk, N_sim, 1);
    
elseif strcmp(type, 'gamma')
     %kk = 5; theta = 1;   % .8, .3
     kk = 9; theta = 0.5;  %.73, .23
     %kk = 2; theta = 2;   %.77,  .73
     %kk = 9; theta = 1;   %0.73 & 0.33 
     %kk = 8; theta = 0.5;  %.78, 0.27
    data = gamrnd(kk, theta,  N_sim, 1);    
    
elseif strcmp(type, 'chiSqr')
    nu = 4;
    data = chi2rnd(nu,  N_sim, 1);    
    
elseif strcmp(type, 'studentT')
    nu = 6;
    data = trnd(nu,  N_sim, 1);
    
elseif strcmp(type, 'genExtremeVal')
    data = gevrnd(0.5,1,0,  N_sim, 1);    
    
elseif strcmp(type, 'BirnbaumSaunders')
    data = random('BirnbaumSaunders', 0.5,1,  N_sim, 1);    
    
elseif strcmp(type, 'Nakagami')
    data = random('Nakagami', 2,2,  N_sim, 1);  

end

