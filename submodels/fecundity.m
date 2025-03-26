function [ls] = fecundity(l,p,stoc)
%FECUNDITY Litter size based on mother body size
%
%   inputs:
%   l       body size of the mother
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males
%   stoc    logical indicating if stocasticity should be implemented

ls = p(1,11)*(l.^p(1,12));
if stoc
    ls = ls + p(1,13)*randn(size(ls));
end
ls = floor(ls);
ls(ls < p(1,14)) = p(1,14);
ls(ls > p(1,15)) = p(1,15);
end

