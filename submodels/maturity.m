function [mature] = maturity(l,s,p)
% MATURITY estimate sexual maturity given body size
%
%   inputs:
%   l       body size of the individual
%   s       integer indicating the sex of the individuals
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males

ml = 1./(1+exp(-(l-p(s,9))./p(s,10)));
mature = binornd(1,ml,size(ml));

end