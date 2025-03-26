function [pop,ind] = IBM_di_vbCAL(n0,Linf,K,mortF,p,period,trsz,effk,pfm,gns,stoc)
%IBM_DI_VBCAL Individual-Based Model for Mustelus spp.
%
% IBM where growth parameters are missing
%   Inputs:
%   n0              starting population abundance
%   Linf            asymptotic length of the von Bertalanffy curve
%   K               k parameter of the von Bertalanffy curve
%   mortF           annual catchability
%   p               matrix containing life history traits of both sexes:
%                   - the first row refers to females, the second to males
%   period          vector of years
%   trsz            threshold size at which fishing mortality starts to
%                   affect individuals (i.e., the size below which fishers
%                   usually release them or a minimum conservation
%                   reference size)
%   effk            monthly fishing effort
%   pfm             factor scaling catchability across months
%   gns             proportion of fishing effort given by passive gears
%   stoc            logical indicating if stocasticity should be implemented

warning('off')

p(:,1) = [Linf;Linf];
p(:,2) = [K;K];

%% Setting of simulation end
usrend = length(period);
simend = usrend*12;

%% Setting of n0 and initialisation of generation0
ind=gen0(n0,p,stoc);

%% Initialisation of output table
% table wich records population abundance and biomass every year
popsz=[usrend+1,5];
popTypes={'double','double','double','double','double'};
popNames={'Year','N','Biomass','SexRatio','Landings'};
pop=table('Size',popsz,'VariableTypes',popTypes,'VariableNames',popNames);
% record starting values
sr=sum(ind.sex==1)/size(ind,1); % sex ratio (F/M)
biom=sum(lwr(ind.len,ind.sex,p,stoc))/1000;
land_y=0;
pop(1,:)={period(1)-1 size(ind,1) biom sr land_y};

%% Simulation
for sm=1:simend
    % mortality
    age = (sm - ind.bd)/12;
    cod=death(age,ind.sex,ind.len,p,trsz,sm,mortF,pfm,effk,gns);
    land_m=sum(lwr(ind.len(cod == 2),ind.sex(cod==2),p,stoc))/1000;
    land_y=land_y+land_m;
    ind=ind(cod == 0,:);
    % reproduction
    [ind,nrecruits]=reproduction(ind,sm,p,stoc);
    % growth
    age = (sm - ind.bd)/12;
    ind.len=ind.len+growth(age,ind.sex,p);
    % recruitment
    recruits=recruitment(nrecruits,p,sm);
    ind=[ind;recruits];
    % yearly summary
    if mod(sm,12)==0
        year=sm/12;
        abund=size(ind,1); % pop abundance
        biom=sum(lwr(ind.len,ind.sex,p,stoc))/1000;
        sr=sum(ind.sex==1)/size(ind,1); % sex ratio
        pop(year+1,:)={period(year) abund biom sr land_y}; % update pop
        land_y = 0;
    end 
end

end