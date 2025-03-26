function [output] = op_mort(l,s,p,gns)
%OP_MORT Estimates at-vessel mortality
%
%   inpute:
%   l       body size of the individual
%   s       sex of the individual (1 for females 2 for males)
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males
%   gns     proportion of fishing effort given by passive gears

avm_gns = l.*p(s,20)+p(s,21);
avm_gns = exp(avm_gns)./(1+exp(avm_gns));
avm_otb = l.*p(s,22)+p(s,23);
avm_otb = exp(avm_otb)./(1+exp(avm_otb));
output = avm_gns*gns + avm_otb*(1-gns);
end

