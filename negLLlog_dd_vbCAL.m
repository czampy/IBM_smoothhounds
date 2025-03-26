function [nLLtot] = negLLlog_dd_vbCAL(parameters)
%NEGLLLOG_DD_VBCAL Negative log-likelyhood (nLLtot)
%
% Computing negative log-likelihood of the IBM integrating
% density-dependence, and where growth parameters are missing
%   inputs:
%   parameters      vector of size [1 5] with log-transformed values of
%                   the parameters, ordered as follows:
%           (1)     starting population abundance
%           (2),(3) beta1 and beta2 to compute the asymptotic lengh as in
%                   van Poorten & Walters (2016)
%           (4)     k parameter of the von Bertalanffy curve
%           (5)     annual catchability
%           (6)     sigma, the observation uncertainty

% parameters extraction
N0 = exp(parameters(1));
b1 = exp(parameters(2));
b2 = exp(parameters(3));
K = exp(parameters(4));
Fm = exp(parameters(5));
Sigma = exp(parameters(6));
% load other parameters
p = load('musp.csv')';
EffObs = load("effort_m.txt");
gns = EffObs(:,8);
EffObs = EffObs(:,7);
mfp = load('fmp.txt');
mfp = mfp(:,2);
LandObs = load('landings_y.txt');
yspan = LandObs(:,1);
LandObs = LandObs(:,2)*2.4;
% run the model
[pop,~]=IBM_dd_vbCAL(N0,b1,b2,K,Fm,p,yspan,51.1,EffObs,mfp,gns,true);
% extract landings biomass from results
LandExp=pop.Landings(2:end);
% compute delta observed-expected(from model) for each year
log_delta=log(LandObs)-log(LandExp);
% compute negative log-Likelihood for landings
log_ind_L=log(Sigma)+0.5*log(2*pi)+0.5*(log_delta/Sigma).^2;
nLLtot=sum(log_ind_L);

end

