% CenterNormv2.m
% Centers data and normalizes if requested.
% MPT 2017.03.17
%
% mthayer@chem.wisc.edu
% github.com/mitchellpthayer
%
%%%%%%%%%%
% INPUTS:
%
% >> MatrixIn, NxT matrix
%
% >> (optional) strMeanMedianMode: Whether to center about the mean or median
%
% >> (optional) strNormalization can be:
%                   'Max'   - shrinking to unit entire range of data
%                   'StdDev' - Unit standard deviation
%                   'dblPrctileXX' - specify shortening by XX percentile
%                   'None' - No normalization. Just subtract the mean
%
% >> (optional) qVerbose: extra feedback? [0, 1]. Default: 0
%
% >> (optional) qTroubleShooting: extra plots, etc? [0, 1]. Default: 0
%

%%%%%%%%%%%
% OUTPUTS:
% > MatrixOut: Normalized matrix with same dimension as MatrixIn
% > vMeans: The means that were subtracted to center the data

%%%%%%%%%%%
% CHANGELOG:
%
% > v2 - switching to centering then normalizing

%%%%%%%%
% TO DO:
%

%%%%%%%%%%%%%
% EXAMPLE:
%

function [MatrixOut, vMeans, TakeAlong] = CenterNormv2(MatrixIn, varargin)
%% I/O

% Deal with inputs:
% (specify defaults and valid options)
varInfo = {...
    %name               %default       %valid
    'strMeanMedianMode',        'median'     {'mean','median','Mean','Median','mode','Mode'};...
    'strNormalization',         'StdDev',    [];...
    'qSilentFigs',              0,           [0 1];...
    'qVerbose',                 0,           [];...
    'qTroubleShooting',         0,           [0 1];...
    'WorkAlong',               'R',          {'R','C'};... % default for HBP: each col is data point
    'qCenter',                  1,           [0 1];...
    'TakeAlong',                [],          [];... % To be transformed with
    };
ParsePairs(varargin,varInfo);

% Convert silent figs boolean to 'on' or 'off' Visibility argument
if (qSilentFigs) qSilentFigs = 'off'; else  qSilentFigs = 'on'; end % Now use: figure('Visible',qSilentFigs);

% If data arranged in rows: Transpose here, then transpose back
if strcmpi(WorkAlong,'R')
    MatrixIn = MatrixIn';
    TakeAlong = TakeAlong';
end

[rr,cc] = size(MatrixIn);
MatrixOut = nan(size(MatrixIn));
vMeans = nan(cc,1);

%% Loop over data (columns)

for c = 1:cc
    X = MatrixIn(:,c);
        
    
    % Find the center of the data
    if strcmpi(strMeanMedianMode, 'MEAN')
        vMeans(c) = nanmean(X);
    elseif strcmpi(strMeanMedianMode, 'MEDIAN')
        vMeans(c) = nanmedian(X);
    elseif strcmpi(strMeanMedianMode, 'MODE')
        vMeans(c) = mode(X);
    end
    
    % Display said centers
    if qVerbose >= 2
        disp('----------------------------')
        disp(['Row # ', num2str(r)]);
        disp(['Mean: ', num2str(nanmean(X))]);
        disp(['Median: ', num2str(nanmedian(X))]);
        disp(['Mode: ', num2str(mode(X))]);
    end
    
    % Center the data
    if qCenter
        X = X-vMeans(c);
    end
       
    % Depending on normalization settings, select unit range
    if strcmpi(strNormalization, 'Percentile')
        % Normalize to some percentile. Not yet coded fully
        disp('************** code PercentileInCenterNorm')
        [UnitRange] = Bookends(X, NormalizingPercentile);
    elseif strcmpi(strNormalization,'Max')
        % Just move ALL the data onte [-1/2, +1/2]
        [UnitRange] = Bookends(X);
    elseif strcmpi(strNormalization, 'StdDev')
        % Unit standard deviation
        stddev = nanstd(X);
        UnitRange = [-stddev, stddev];   
    elseif strcmpi(strNormalization, 'None')
        UnitRange = [0 1]; % don't normalize
    end
    
    % Normalize
    X = X/diff(UnitRange);

    % Return to matrix
    MatrixOut(:,c) = X;
    
    if ~isempty(TakeAlong)
        T = TakeAlong(:,c);
        T = T-vMeans(c);
        T = T/diff(UnitRange);
        TakeAlong(:,c) = T;
    end
end

% If data arranged in rows: Transpose here, then transpose back
if strcmpi(WorkAlong,'R')
    MatrixOut = MatrixOut';
    TakeAlong = TakeAlong';
end

