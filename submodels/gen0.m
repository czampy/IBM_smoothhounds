function [indiv] = gen0(n,p,stoc)
%GENERATION0 Initialisation of starting population
%
%   inputs:
%   n       integer indicating the starting population size;
%           set it equal to 0 for an empty table
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males
%   stoc    logical indicating if stocasticity should be implemented
%
%   outputs:
%   indiv   table containing all the information of each one of the
%           individuals of the population

% initialise table
n=round(n*10000);
types={'double','double','double','logical','double','double'};
names={'sex','len','bd','mat','ls','pe'};
indiv=table('Size',[n,6],'VariableTypes',types,'VariableNames',names);

% given the sex ratio 1:1 half of newborns will be females, the other males
% nfemales and nmales sholud be the same, but the function computes them
% individually because it considers the case in which n0 is not even

nsexes = [ceil(n/2) n-ceil(n/2)];
indiv.sex = repelem(1:2,nsexes)'; % 1 = F and 2 = M

% generate size distribution for generation0
afdF = afd0(nsexes(1),1,p);
afdM = afd0(nsexes(2),2,p);
age = [repelem(0:p(1,5),afdF)+.5 repelem(0:p(2,5),afdM)+.5]'-(8/12);
indiv.len = p(indiv.sex,1).*(1-exp(-p(indiv.sex,2).*(age-p(indiv.sex,3))));
if stoc
    indiv.len = indiv.len + p(indiv.sex,4).*randn(size(age));
end
indiv.bd = age*(-12)-8;

for i=-7:0
    age = (i-indiv.bd)/12;
    [indiv,~] = reproduction(indiv,i,p,stoc);
    indiv.len = indiv.len + growth(age,indiv.sex,p);
end

end

