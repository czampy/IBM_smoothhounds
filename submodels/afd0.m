function [output] = afd0(n,s,p)
%AFD0 Age frequency distribution of the starting population
%
%   inputs:
%   n       integer indicating the total number of individuals
%   s       integer indicating the sex of the individuals
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males

t = 1:p(s,5);
M = M_eval(t,s,p);
intgrl = 0;
for i=1:p(s,5)
    intgrl(i+1) = sum(M(1:i));
end
Mexp = exp(-intgrl);
output = round(n*Mexp/sum(Mexp));
check = n-sum(output);
if check ~= 0
    corrector = check/abs(check);
    correction = repelem([corrector 0],[abs(check),(length(output)-abs(check))]);
    output = output + correction;
end
end

