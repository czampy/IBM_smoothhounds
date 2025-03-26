function [cod] = death(age,sex,len,p,trsz,m,mortF,pfm,effk,gns)
%DEATH Occurrence and cause of death based on fishing effort and individual
%features
%
%   inputs:
%   age     age of the individual
%   sex     sex of the individual (1 for females 2 for males)
%   len     bosy size of the individual
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males
%   trsz    threshold size at which fishing mortality starts to affect
%           individuals (i.e., the size below which fishers usually release
%           them or a minimum conservation reference size)
%   m       current month
%   mortF   catchability
%   pfm     factor scaling catchability across months
%   effk    monthly fishing effort
%   gns     proportion of fishing effort given by passive gears

im=mod(m,12)+1;

% set death probability
fi = mortF*pfm(im)*effk(m);
mi = M_eval(age,sex,p)/12;
zi = mi + (len < trsz).*(fi*op_mort(len,sex,p,gns(m))) + (len >= trsz)*fi;
pfi = fi./zi;
pzi = 1-exp(-zi);

% determine whether they die or not
dies = binornd(1,pzi,size(pzi));
caso = rand(size(dies));
cod = dies;
cod((len > trsz)&(dies == 1)&(caso < pfi)) = 2;
cod(age > p(sex,5)) = 1;

end

