% run with case before running Julia
runcase = loadcase('case200');
obj = Grid_class(runcase,'case200',0);

cd ~/Desktop

f = obj.f;

filename = strcat(obj.case_name,'_f');
save(filename, 'f');

