function [output] = M_eval(t,s,p)
%M_EVAL Evaluation of natural mortality (M) given individual age, as
%described in Chen & Watanabe (1989)
%
%   inputs:
%   t       scalar or vector with the age of the individual/individuals
%   s       integer indicating the sex of the individuals
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males

k = p(:,2);
t0 = p(:,3);
tM = (-1./k).*log(abs(1-exp(k.*t0)))+t0;
a0 = 1-exp(-k.*(tM-t0));
a1 = k.*exp(-k.*(tM-t0));
a2 = (-.5).*(k.^2).*exp(-k.*(tM-t0));

output = (t > tM(s)).*(a0(s)+a1(s).*(t-tM(s))+a2(s).*(t-tM(s)).^2) + (t <= tM(s)).*(1-exp(-k(s).*(t-t0(s))));
output = k(s)./output;

end

