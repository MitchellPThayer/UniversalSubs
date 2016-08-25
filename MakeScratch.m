%%

function MakeScratch(strProjectName)

warning('off','MATLAB:MKDIR:DirectoryExists'); % hush

[DropboxResearchPath, ModelingPath] = HandPaths; % Get research path
% ^ if no HandPaths fxn, no worries. Just specify the paths as hardcoded strings

cProjects = {...
    % proj name    % project directory
    'SONGNEX',  [ModelingPath,filesep,'ScratchSpace'];...
    }';

if nargin == 0 % if no project specified, open in generic ScratchSpace
    mkdir([DropboxResearchPath,filesep,'UniversalSubs',filesep,'ScratchSpace']);
    edit([DropboxResearchPath,filesep,'UniversalSubs',filesep,'ScratchSpace',filesep,'Scratch',datestr(date, 'yyyymmdd'),'.m']);

else % if a project specified, put the scratch there
    w = find(strcmp(cProjects,strProjectName));
    
    if ~isempty(w) % if specified project name is in cProjects
        mkdir([cProjects{w+1},filesep,'Scratch'])
        edit([cProjects{w+1},filesep,'Scratch',datestr(date, 'yyyymmdd'),'.m']);
    else
        disp('#################################')
        disp('Project name not recognized...')
    end  
end

end
