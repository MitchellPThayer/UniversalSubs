function [ResearchPath, ModelingPath, MaxdWinSize] = HandPaths()

[~,hostname]= system('hostname');
NamePaths = {...
    %System Name    ResearchPath                     F0AMv3Pth      figure.position;
    'BreadFish',   '/hdd/Dropbox/Research',          'usual', [1 1 1215 902];...
    'Bernie2020',  '/home/eleven/Dropbox/Research','usual', [-1214 -123 1215 945];...
    'ThisIsNotAComputer','/home/mitchell/Dropbox/Research','usual', 'Code in HandPaths!';...
    'BadW0lf',     '/home/mitchell/Dropbox/Research','usual', [1 1 1215 945];...
    'HAL9000',      '/home/mitchell/Dropbox/Research','usual', [66 1 1215 945]  ;...
    };
    
% Poll hostname from the system
% Really, should only require the line system('hostname') once.
% However for some odd reason this occasionally hiccoughs and returns an
% empty string. (rare & usually not reproducible) 
% Therefore we give this 3 tries if necessary.

a = 0;
hostname = '';
while length(hostname)==0 & a<3
    [~,hostname]= system('hostname'); % Get hostname
    hostname(hostname==10) = ''; % Remove extra line
    a = a + 1;
end
if length(hostname) == 0
    disp('##############################')
    disp('Had difficulty polling hostname')
    disp('This is probably a fluke??')
end

vind = find(not(cellfun('isempty', strfind({NamePaths{:,1}}, hostname)))); %Find which line

if isempty(vind) % Kick back error if hostname not in list
    disp('###############################')
    disp('Computer name not known!!!!!!!!')
    disp('Path uncertain... But easy fix:')
    disp('Add hostname in HandPaths.m')
    ResearchPath = 'UNKNOWN-PATH/'; ModelingPath = 'UNKNOWN-PATH/';
    return
end

ResearchPath = NamePaths{vind,2}; % Pull out the ResearchPath

if strcmp(NamePaths{vind,3}, 'usual') % Append to the usual if usual
    ModelingPath = [ResearchPath,filesep,'F0AMv31Path'];
else
    ModelingPath = NamePaths{vind,3}
end

MaxdWinSize = NamePaths{vind,4}; % Pull out the maximized figure window size (typically 'left' monitor in landscape orientation)

end
