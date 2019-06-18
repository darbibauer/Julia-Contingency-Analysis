% test Grid_class.m work 
% you can load any MATPOWER case.
%     for example  loadcase('case2737sop');
res = [];
clear all;
clc; 

% % res :  fast_full fast_loop brute_full cont C1_isl C2_isl final 
% 
% %runcase = loadcase('case_ACTIVSg500');
% 
% %runcase = loadcase('case2746wp');
%  runcase = loadcase('case39_1')
% %runcase = loadcase('case3012wp')
% %runcase = loadcase('case2746wp');
% grid = Grid_class(runcase,'poland_winter_peak',1);
% 
% grid.N_1_analysis(); % runs N-1 analysis
% grid = grid.N_2_analysis('fast'); % runs fast N-2 contingency analysis
% % res(3,1) = grid.t_fast;
% % res(3,2) = grid.t_fast - grid.t_brute;
% % res(3,5) = Sz.r(grid.C1_isl);
% % res(3,6) = Sz.r(grid.C2_isl);
% %grid = grid.N_2_analysis('bruteforce'); % runs bruteforce N-2 contingency analysis
% %res(3,3) = grid.t_brute;
% %res(3,4) = Sz.r(grid.brute_cont);

% 
a = 14.5; 
b = 2.8;
N = 24;
pd = makedist('weibull', 'a', a,'b',b);
r = wblrnd(a,b,[1,N]);
vbins = linspace(0, 34, N);
y = pdf(pd,vbins);

% prated1 = 1.6525e2;
% prated2 = 1.4563e2;
% prated3 = 2.3e2;
prated1 = 1.2525e2;
prated2 = 1.2563e2;
prated3 = 0.7e2;

vin = 2;
vr = 14;
vout = 25;

powervbins1 = prated1*(vbins.^2 - vin^2)/(vr^2 - vin^2);
powervbins1(vbins <= vin ) = 0;
powervbins1(vbins > vout ) = 0;
powervbins1(vbins >= vr & vbins <= vout ) = prated1;

powervbins2 = prated2*(vbins.^2 - vin^2)/(vr^2 - vin^2);
powervbins2(vbins <= vin ) = 0;
powervbins2(vbins > vout ) = 0;
powervbins2(vbins >= vr & vbins <= vout ) = prated2;


powervbins3 = prated3*(vbins.^2 - vin^2)/(vr^2 - vin^2);
powervbins3(vbins <= vin ) = 0;
powervbins3(vbins > vout ) = 0;
powervbins3(vbins >= vr & vbins <= vout ) = prated3;



wind1 = -powervbins1;
wind2 = -powervbins2;
wind3 = -powervbins3;

win1=sum(wind1)/24;
win2=sum(wind2)/24;
win3=sum(wind3)/24;


for kk = 1:24 

runcase = loadcase('case39_1');
runcase.bus(40,3) = wind1(kk);
runcase.bus(41,3) = wind2(kk);
runcase.bus(42,3) = wind3(kk);
% runcase.gen(11,2) = wind(kk);
% runcase.gen(12,2) = wind(kk);
% runcase.gen(13,2) = wind(kk);

grid = Grid_class(runcase,'poland_winter_peak',0);
grid.N_1_analysis(); % runs N-1 analysis
grid = grid.N_2_analysis('fast'); % runs fast N-2 contingency analysis

end

