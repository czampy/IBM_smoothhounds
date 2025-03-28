%% B_CALIBRATION
% This code runs the calibration of the four individual-based models
% described in the manuscript "Individual-Based Modelling to fin-tune
% management measures for commercial demersal sharks".

% add required directories
addpath("data\")
addpath("submodels\")

% set number of iterations
n = 4;

%% di_vbSIC
% calibration of the IBM without density-dependent processes and using
% growth parameter available in literature

for i = 1:n
    cal_di_vbSIC(i);
end

%% di_vbCAL
% calibration of the IBM without density-dependent processes and estimating
% growth parameter

for i = 1:n
    cal_di_vbCAL(i);
end

%% dd_vbSIC
% calibration of the IBM with density-dependent processes and using
% growth parameter available in literature

for i = 1:n
    cal_dd_vbSIC(i);
end

%% dd_vbCAL
% calibration of the IBM with density-dependent processes and estimating
% growth parameter

for i = 1:n
    cal_dd_vbCAL(i);
end
