%% STARTVAL_GEN
% This code generates starting values for the calibration of the IBMs and
% computes the negative log-likelihood relative to each of those starting
% points

% access data and sampling function directories
addpath("data/")
addpath("submodels/")
addpath("starting_values/")
% number of sampling points
n = 100;
% define ranges
N0_range=[1 100];
B1_range=[119 221];
B2_range=[0 .000000000057];
Linf_range=[135 210];
K_range=[.01 .5];
q_range=[.000000001 .00005];
sigma_range=[.0001 20];

%% di_vbSIC
% sample values within bounds
lb=[N0_range(1) q_range(1) sigma_range(1)];
ub=[N0_range(2) q_range(2) sigma_range(2)];
st_pop = values_sampling(n,lb,ub);
% evaluate negative log-likelihood
nLL = zeros([n,1]);
for i = 1:n
    nLL(i,1) = negLLlog_di_vbSIC(log(st_pop(i,:)));
    disp(i)
end
% summarise in a table
varnames = {'N0','q','sigma'};
summtbl = array2table(st_pop,'VariableNames',varnames);
summtbl = addvars(summtbl,(1:n)','Before',1,'NewVariableNames','id');
summtbl.nLL = nLL;
summtbl.delta = summtbl.nLL - min(summtbl.nLL);
summtbl = sortrows(summtbl,"delta");
% save results
writetable(summtbl,"starting_values/startval_di_vbSIC.dat")

%% di_vbCAL
% sample values within bounds
lb=[N0_range(1) Linf_range(1) K_range(1) q_range(1) sigma_range(1)];
ub=[N0_range(2) Linf_range(2) K_range(2) q_range(2) sigma_range(2)];
st_pop = values_sampling(n,lb,ub);
% evaluate negative log-likelihood
nLL = zeros([n,1]);
for i = 1:n
    nLL(i,1) = negLLlog_di_vbCAL(log(st_pop(i,:)));
    disp(i)
end
% summarise in a table
varnames = {'N0','Linf','K','q','sigma'};
summtbl = array2table(st_pop,'VariableNames',varnames);
summtbl = addvars(summtbl,(1:n)','Before',1,'NewVariableNames','id');
summtbl.nLL = nLL;
summtbl.delta = summtbl.nLL - min(summtbl.nLL);
summtbl = sortrows(summtbl,"delta");
% save results
writetable(summtbl,"starting_values/startval_di_vbCAL.dat")

%% dd_vbSIC
% sample values within bounds
lb=[N0_range(1) B1_range(1) B2_range(1) q_range(1) sigma_range(1)];
ub=[N0_range(2) B1_range(2) B2_range(2) q_range(2) sigma_range(2)];
st_pop = values_sampling(n,lb,ub);
% evaluate negative log-likelihood
nLL = zeros([n,1]);
for i = 1:n
    nLL(i,1) = negLLlog_dd_vbSIC(log(st_pop(i,:)));
    disp(i)
end
% summarise in a table
varnames = {'N0','B1','B2','q','sigma'};
summtbl = array2table(st_pop,'VariableNames',varnames);
summtbl = addvars(summtbl,(1:n)','Before',1,'NewVariableNames','id');
summtbl.nLL = nLL;
summtbl.delta = summtbl.nLL - min(summtbl.nLL);
summtbl = sortrows(summtbl,"delta");
% save results
writetable(summtbl,"starting_values/startval_dd_vbSIC.dat")

%% dd_vbCAL
% sample values within bounds
lb=[N0_range(1) B1_range(1) B2_range(1) K_range(1) q_range(1) sigma_range(1)];
ub=[N0_range(2) B1_range(2) B2_range(2) K_range(2) q_range(2) sigma_range(2)];
st_pop = values_sampling(n,lb,ub);
% evaluate negative log-likelihood
nLL = zeros([n,1]);
for i = 1:n
    nLL(i,1) = negLLlog_dd_vbCAL(log(st_pop(i,:)));
    disp(i)
end
% summarise in a table
varnames = {'N0','B1','B2','K','q','sigma'};
summtbl = array2table(st_pop,'VariableNames',varnames);
summtbl = addvars(summtbl,(1:n)','Before',1,'NewVariableNames','id');
summtbl.nLL = nLL;
summtbl.delta = summtbl.nLL - min(summtbl.nLL);
summtbl = sortrows(summtbl,"delta");
% save results
writetable(summtbl,"starting_values/startval_dd_vbCAL.dat")
