% BatchSave.m: MPT 2016.08.30 
% Saves a bunch of figure handles as FIG & PNG
% Nothing particularly new & exciting, just saving time for IGACplots2016.m
%
%%%%%%%%%
% INPUTS:
% FigureHandles -- Array of figure handles
% strFigureName -- Base name for saving files ('Test_1', 'Test_2',...)
% strOutputPath -- Where to save files
%
% OPTIONAL INPUTS:
% PositionArray -- 1x4 Position Array
% qCloseFigs -- Close figures once saved? [0,1] default: 0

function [] = BatchSave(FigureHandles, strFigureName, strOutputPath, varargin)
%% I/O
% Deal with inputs:
% (specify defaults and valid options)
varInfo = {...
    %name               %default            %valid
    'PositionArray',     [],                [];...
    'qCloseFigs',        0,                 [0,1];...
    };
ParsePairs(varargin,varInfo);

for i = 1:length(FigureHandles);
    thisF = FigureHandles(i);
    
    prevDockedness = thisF.WindowStyle; % Was this docked or normal?
    
    if ~isempty(PositionArray) % if desired, resize
        thisF.WindowStyle = 'normal'; % to resize, must ensure undocked
        set(thisF,'Position',PositionArray);
        pause(0.001)
        drawnow update
        
    end

    DoubleSave(thisF, [strFigureName,'_',num2str(i)], strOutputPath);
    
    pause(0.001)

    if qCloseFigs % if desired, close the figure
        close(thisF)        
    else
        thisF.WindowStyle = prevDockedness; % make sure it is left as is (was).
    end
    

end
end
