function [nLLtot] = negLLlog_di_vbSIC(parameters)
%NEGLLLOG_DI_VBSIC Negative log-likelyhood (nLLtot)
%
% Computing negative log-likelihood of the IBM using growth parameters
% from literature
%   inputs:
%   parameters      vector of size [1 3] with log-transformed values of
%                   the parameters, ordered as follows:
%           (1)     starting population abundance
%           (2)     annual catchability
%           (3)     sigma, the observation uncertainty

% parameters extraction
N0 = exp(parameters(1));
Fm = exp(parameters(2));
Sigma = exp(parameters(3));
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
[pop,~]=IBM_di_vbSIC(N0,Fm,p,yspan,51.1,EffObs,mfp,gns,true);
% extract landings biomass from results
LandExp=pop.Landings(2:end);
% compute delta observed-expected(from model) for each year
log_delta=log(LandObs)-log(LandExp);
% compute negative log-Likelihood for landings
log_ind_L=log(Sigma)+0.5*log(2*pi)+0.5*(log_delta/Sigma).^2;
nLLtot=sum(log_ind_L);

end

