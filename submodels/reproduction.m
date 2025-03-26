function [out,newborns] = reproduction(i,m,p,stoc)
%REPRODUCTION This function simulate the reproductive processes
%
%   inputs:
%   i       table where each row is an individual and each column a feature
%   m       current month
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males
%   stoc    logical indicating if stocasticity should be implemented in the
%           reproductive processes
%
%   outputs:
%   out         updated version of table i
%   newborns    scalar indicating how many new individuals in the next
%               generation

warning('off')

% delivering = pregnant females who have reached the end of pregnancy
delivering=(i.sex==1)&(i.ls~=0)&(i.pe==m);
% newborns = number of offsprings from females ready for delivery
newborns=sum(i.ls(delivering));

% mating probability depending on the current month
ms = p(1,18):p(1,19);
month=mod(m,12);
mp = find(ms == month)*(1/length(ms));
if isempty(mp)
    mp = 0;
end

% determine sexual maturity
i.mat(~i.mat)=maturity(i.len(~i.mat),i.sex(~i.mat),p);
% mating = mature females, not yet pregnant
mating=(i.mat==1)&(i.sex==1)&(i.ls==0);
nmating=binornd(mating,mp);
logicnmating=logical(nmating); % mature females who are going to mate
% embryos generation depending on maternal size
i.ls(logicnmating)=fecundity(i.len(logicnmating),p,stoc);
% set pregnancy duration
i.pe(logicnmating)=m+randsample(p(1,16):p(1,17),sum(logicnmating),true);

% reset pregnancy variables for delivering females
i.ls(delivering)=0; % number of embryos
i.pe(delivering)=0; % pregnancy duration

out=i;

end

