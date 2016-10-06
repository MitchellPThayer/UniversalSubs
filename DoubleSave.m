% DoubleSave.m
% Saves a figure as both PNG and FIG
% Drop in FigHandle (opt), specify the FileName (opt), and FilePath (opt)
%
% Defaults:
% >> Will save by timestamp (HHmmss.{png,fig}) if filename unspecified
%    ... OR if short-circuited by feeding in 0 (double) instead of a string
% >> Will save to FigDump folder (subsorted by YYYYMMDD) if FilePath unspecified
% >> If you really want to live on the edge, you can run with NO arguments
% in which case it grabs current figure and dumps in default directory.
% There is severe likelihood of saving the wrong thing. NOT suggested.
%
% * When adapting this code for a new computer/user/project, need only
% adjust the line:
%
% if nargin < 3
%    FilePath = [ ... PATH TO YOUR FIGDUMP GROUNDS ...];
% end
%
% Returns [1] if successful, [0] if encountered any problems
% Generally the output of this fxn can/should be ignored
% I would only use the output if DoublSave is called from inside a loop.
%
% MPT 2016.03

function [WasSuccessful] = DoubleSave(FigHandle, FileName, FilePath)
WasSuccessful = 0;

%%%%%%%%%
% Disable "Directory Exists" warning when making output folder
warning('off','MATLAB:MKDIR:DirectoryExists'); % hush

%%%%%%%%
% Default figure handle
% Probably dicey to include...
if nargin < 1
    FigHandle = gcf;
    disp('******************** DoubleSave.m')
    disp('No Figure handle fed in, took gcf')
    disp('Very possible WRONG fig saved!!')
end

%%%%%%%%%
% Default Figure Name (time of saving)
if nargin < 2
    FileName = datestr(datetime, 'HHmmss');
end

%%%%%%%%%
% Generate time if FileName == 0
try
    if FileName == 0 % This is the 'short circuit' over filename
        FileName = datestr(datetime, 'HHmmss');
    end
catch
    % Catches here if filename is string (i.e. specified)
    % In principle, if class(FileName) ==> double would probably...
    % ... be more elegant, but if/if no better than try/if, so w/e.
end

%%%%%%%%%
% Default Dumping Grounds
if nargin < 3
    [dbrp, ~, ~] = HandPaths();
    FilePath = [dbrp,filesep,'FigDump',filesep,datestr(date, 'yyyymmdd')];
    % ^ This is only line that you have to customize!!
end

%%%%%%%%%
% Take off extra '/' if included in FilePath
% Otherwise will crash due to [FilePath,filesep...]
if strcmp(FilePath(end),'/')
    FilePath = FilePath(1:end-1);
end

%%%%%%%%%
% Save it
try
    mkdir(FilePath)
    saveas(FigHandle, [FilePath, filesep, FileName,'.png'],'png')
    saveas(FigHandle, [FilePath, filesep, FileName,'.fig'],'fig')
    WasSuccessful = 1;
    disp(['DoubleSaved ',FileName, ' to ', FilePath])
catch
    disp('#######################')
    disp('DoubleSave.m')
    disp('Something went wrong!!')
end


end