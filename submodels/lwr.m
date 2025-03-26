function [output] = lwr(x,s,p,stoc)
%LWR Length-Weight relationship
%
%   inputs:
%   x       body size of the individual
%   s       sex of the individual (1 for females 2 for males)
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males
%   stoc    logical indicating if stocasticity should be implemented

output = p(s,6).*x.^(p(s,7));
if stoc
    output = output + p(s,8).*randn(size(output));
end
end

