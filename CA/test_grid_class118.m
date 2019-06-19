% test Grid_class.m work 
% you can load any MATPOWER case.
%     for example  loadcase('case2737sop');
res = [];
clear all;
clc; 

% res :  fast_full fast_loop brute_full cont C1_isl C2_isl final 

%runcase = loadcase('case_ACTIVSg500');

%runcase = loadcase('case2746wp');
 runcase = loadcase('case39')
%runcase = loadcase('case3012wp')
%runcase = loadcase('case2746wp');
grid = Grid_class(runcase,'poland_winter_peak',1);

grid.N_1_analysis(); % runs N-1 analysis
grid = grid.N_2_analysis('fast'); % runs fast N-2 contingency analysis
% res(3,1) = grid.t_fast;
% res(3,2) = grid.t_fast - grid.t_brute;
% res(3,5) = Sz.r(grid.C1_isl);
% res(3,6) = Sz.r(grid.C2_isl);
%grid = grid.N_2_analysis('bruteforce'); % runs bruteforce N-2 contingency analysis
%res(3,3) = grid.t_brute;
%res(3,4) = Sz.r(grid.brute_cont);



% 
% a = 14.5; 
% b = 2.8;
% N = 24;
% pd = makedist('weibull', 'a', a,'b',b);
% r = wblrnd(a,b,[1,N]);
% vbins = linspace(0, 34, N);
% y = pdf(pd,vbins);
% 
% prated = 1e3;
% vin = 2;
% vr = 14;
% vout = 25;
% 
% powervbins = prated*(vbins.^2 - vin^2)/(vr^2 - vin^2);
% powervbins(vbins <= vin ) = 0;
% powervbins(vbins > vout ) = 0;
% powervbins(vbins >= vr & vbins <= vout ) = prated;
% 
% probvbins = r/sum(r);
% avgpower = sum(probvbins.*powervbins);
% ratedpower = num2str(prated/1e6);
% turbinepower = num2str(avgpower/1e3);
% 
% wind = powervbins;


% for kk = 1:24 
% 
% runcase = loadcase('case39');
% % runcase.bus(40,3) = wind(kk);
% % runcase.bus(41,3) = wind(kk);
% % runcase.bus(42,3) = wind(kk);
% runcase.gen(11,2) = wind(kk);
% runcase.gen(12,2) = wind(kk);
% runcase.gen(13,2) = wind(kk);
% 
% grid = Grid_class(runcase,'poland_winter_peak',0);
% grid.N_1_analysis(); % runs N-1 analysis
% grid = grid.N_2_analysis('fast'); % runs fast N-2 contingency analysis
% 
% end

