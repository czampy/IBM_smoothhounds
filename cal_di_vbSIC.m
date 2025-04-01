function [] = cal_di_vbSIC(calnum)
%CAL_DI_VBSIC calibration of an IBM using growth parameters from literature
%
%   Inputs:
%   calnum      integer indicating which element of the population of
%               initial conditions should be used

% load observations
LandObs = load("landings_y.txt");
yspan = LandObs(:,1);
LandObs = LandObs(:,2)*2.4;

% load starting set of values for parameters estimation
strpop = readtable("starting_values\startval_di_vbSIC.dat");
pstart = [strpop.N0(calnum),strpop.q(calnum),strpop.sigma(calnum)];
pstart = log(pstart);
fprintf("Starting points loaded from line %2i: \n\n",calnum)
disp(strpop(calnum,1:3))

% define ranges for parameters search
N0_range=log([1 100]);
q_range=log([.000000001 .00005]);
sigma_range=log([.0001 5]);

lb=[N0_range(1) q_range(1) sigma_range(1)];
ub=[N0_range(2) q_range(2) sigma_range(2)];

% initialise results table
resTypes={'double','double','double','double','double','double'};
resNames={'N0','q','sigma','LogLikelihood','AIC','AICc'};
res=table('Size',[1 6],'VariableTypes',resTypes,'VariableNames',resNames);

% set patternsearch options
opt=optimoptions(@patternsearch,'Display','iter','FunctionTolerance',.01);

% minimise objective function
fprintf("Minimization started!\n")
[pfit,nLL,~,~]=patternsearch(@negLLlog_di_vbSIC,pstart,[],[],[],[],lb,ub,[],opt);

% compute AIC (i.e., AIC corrected for small sample size)
n = length(LandObs);
k = sum(pfit > 0);
AIC = 2*nLL+2*k; % AIC=-2*logL+2*k;
AICC = AIC+((2*k*(k+1))/(n-k-1));

% record obtained values
pfit = exp(pfit);
res(1,:) = {pfit(1)*10000 pfit(2) pfit(3) nLL AIC AICC};
disp(res)

% run model with the best set of parameters
p = load("musp.csv")';
EffObs = load("effort_m.txt");
gns = EffObs(:,8);
EffObs = EffObs(:,7);
mfp = load("fmp.txt");
mfp = mfp(:,2);
stoc = true;

fprintf("Running model with best performing set of parameters\n")
[pop,~]=IBM_di_vbSIC(pfit(1),pfit(2),p,yspan,51.1,EffObs,mfp,gns,stoc);

% save workspace
dataname = sprintf("results\res_MUSv304%03i.mat",calnum);
save(dataname)

end
