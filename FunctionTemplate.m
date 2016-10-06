% FUNCTION NAME.m
% Function brief description
% MPT 201x
%
% mthayer@chem.wisc.edu
% github.com/mitchellpthayer
%
%%%%%%%%%%
% INPUTS:
%
% >> (optional) qSilentFigs: make figures invisible? (1 = visible 'off')
%                   default: 0 = visible figures
%
% >> (optional) qVerbose: extra feedback? [0, 1]. Default: 0
%
% >> (optional) qTroubleShooting: extra plots, etc? [0, 1]. Default: 0
%

%%%%%%%%%%%
% OUTPUTS:
%

%%%%%%%%%%%
% CHANGELOG:
%

%%%%%%%%
% TO DO:
%

%%%%%%%%%%%%%
% EXAMPLE:
%

function [Outputs] = FunctionTemplate(Inputs, varargin)
%% I/O

% Deal with inputs:
% (specify defaults and valid options)
varInfo = {...
    %name               %default       %valid
    'qSilentFigs',        0,           [0 1];...
    'qVerbose',           0,           [0 1];...
    'qTroubleShooting',   0,           [0 1];...
    };
ParsePairs(varargin,varInfo);

% Convert silent figs boolean to 'on' or 'off' Visibility argument
if (qSilentFigs) qSilentFigs = 'off'; else  qSilentFigs = 'on'; end

%%%%%%%%%%%%%%%%%%%%
% Function goes here
%%%%%%%%%%%%%%%%%%%%

Outputs = Inputs;

end
