function [c, r, uh, u, subband] = crosset_Combine(CD,CV,CH)
% CD = 1; CV = 2; CH = 3;
[c_CD, r_CD, uh_CD, u_CD, mu_CD] = crossset_subband(CD);
[c_CH, r_CH, uh_CH, u_CH, mu_CH] = crossset_subband(CH);
[c_CV, r_CV, uh_CV, u_CV, mu_CV] = crossset_subband(CV);

CD_subband = ones(length(c_CD),1);
CV_subband = ones(length(c_CV),1);    CV_subband = CV_subband + 1;
CH_subband = ones(length(c_CH),1);    CH_subband = CH_subband + 2;

subband = [CD_subband; CV_subband; CH_subband];
c = [c_CD; c_CV; c_CH];
r = [r_CD; r_CV; r_CH];
u = [u_CD; u_CV; u_CH];
uh = [uh_CD; uh_CV; uh_CH];
mu = [mu_CD; mu_CV; mu_CH];

[nn,IX]=sort(mu);
c=c(IX);
r=r(IX);         % IX la index dc sap xep lai
uh=uh(IX);
u=u(IX);
subband = subband(IX);
end