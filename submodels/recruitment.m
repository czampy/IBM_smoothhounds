function [newgen] = recruitment(n,p,m)
%RECRUITMENT  Initialisation of recruits and their features
%
%   inputs:
%   n       number of recruits
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males
%   m       current month

% initialise table of the new generation
types={'double','double','double','logical','double','double'};
names={'sex','len','bd','mat','ls','pe'};
newgen=table('Size',[n,6],'VariableTypes',types,'VariableNames',names);

% given the sex ratio 1:1 half of newborns will be females, the other males
% the function computes nfemales and nmales individually because it
% considers the case in which newborns is not even
nsexes = [ceil(n/2) n-ceil(n/2)];
newgen.sex = repelem(1:2,nsexes)'; % 1 = F and 2 = M

% set birth month
newgen.bd(:)=m;

% set body size
newgen.len = p(1,24)+p(1,25)*randn(size(newgen.bd));

end

