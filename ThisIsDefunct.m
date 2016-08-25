%Ironically, this is defunct

function ThisIsDefunct(mfilepath)
disp('############################')
disp(['You are running obsolete ]')
disp(mfilepath)
qc = ''
while ~strcmp(qc,'Y') & ~strcmp(qc,'n')
    qc = input('Continue?? [Y/n]')
end
switch qc
    case 'Y'
        continue
    case 'n'
        break
end
end