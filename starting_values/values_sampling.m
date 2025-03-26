function [s] = values_sampling(n,lb,ub)
%VALUES_SAMPLING Latin Hypercube Sampling within given bounds
%   
%   Sampling n points from a k-dimensional space where k is the number of
%   elements in lb and ub
r = ub-lb;
k = length(r);
s = lhsdesign(n,k);
s = lb + s.*r;
end

