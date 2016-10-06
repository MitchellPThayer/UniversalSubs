% FindOzoneEvents.m
% Looks for days in which the (8)-hour average ozone maximum increases
% monotonically for (4) days in a row. (parenthetical numbers adjustable
% parameters). 
%
% MPT 2016-10-06
% mthayer@chem.wisc.edu
% github.com/mitchellpthayer
%
%%%%%%%%%%
% INPUTS:
% >> vTime: 1-d array of times in fractional day of year
%
% >> vOzone: 1-d array of ozone concentrations.
%
% >> (optional) nHourAverage: averaging width in hours. Default: 8-hour average
%
% >> (optional) nDaysEvent: number of days with max average monotonically increasing 
%                   to constitute an 'event'. Default: 4 days 
%
% >> (optional) qSilentFigs: make figures invisible? (1 = visible 'off')
%                   default: 0 = visible figures
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

function [Outputs] = FindOzoneEvents(Inputs, varargin)
%% I/O

% Deal with inputs:
% (specify defaults and valid options)
varInfo = {...
    %name               %default       %valid
    'nHourAverage'        8,           [1:24];...
    'nDaysEvent'          4,           [];...
    'qSilentFigs',        0,           [0 1];...
    'qVerbose',           0,           [0 1];...
    'qMakeFigures',       0,           [0 1];...
    };
ParsePairs(varargin,varInfo);

% Convert silent figs boolean to 'on' or 'off' Visibility argument
if (qSilentFigs) qSilentFigs = 'off'; else  qSilentFigs = 'on'; end

%%%%%%%%%%%%%%%%%%%%
% Function goes here
%%%%%%%%%%%%%%%%%%%%

Outputs = Inputs;

end
