function [delta] = growth(age,sex,p)
%GROWTH Incremental growth in body size derived from the Von Bertalanffy
%Growth Function
%
%   inputs:
%   age     age of the indivual
%   sex     sex of the individual (1 for females 2 for males)
%   p       matrix containing life history traits of both sexes:
%           - the first row refers to females, the second to males

delta = p(sex,1).*exp(-p(sex,2).*(age-p(sex,3))).*(exp(p(sex,2)/12)-1);
delta(delta < 0) = 0;

end

