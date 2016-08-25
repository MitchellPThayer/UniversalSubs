% MYBoxPlots.m
% MPT 2016.07.14
% Required for SONGNEX, designed to be flexible
%
%%%%%%%%
% INPUTS: 
% >> cData = (n measurements)x2 cell.
%       {measurement label string, data vector;...}
% >> cPartitions = (n partitions)x2 cell
%       {partition name string, partition indices;...}
% >> strTitle. String, title for plots. Default: no title
% 
%%%%%%%%%%
% OUTPUTS:
% >> FigureHandles. Exactly what you'd think.
%
%%%%%%%%%%%%%%%%%
% Example inputs:
% cData = {...
%         'Ozone',    D.O3_CaRDS_ppbv;...
%         'HCHO',     D.HCHO_ppbv;...
%         };
%            
% cPartitions = {...
%         % Name          % Indices
%         'Denver',       D.i.DenPBL;...
%         'Greely',       D.i.GrPBL;...
%         'Background',   D.i.BkgPBL;...
%         };
%           

function [FigHandles] = MyBoxPlots(cData, cPartitions, strTitleOpt, qSilentFigs)
   
if nargin < 3
    strTitleOpt = '';
end

if nargin < 4
    qSilentFigs = 0;
end
          
    for f = 1:length(cData(:,1))
            disp(['Working on ',cData{f,1}]);
            Ddat = cData{f,2};
            BoxMatrix = [];
            
            for p = 1:length(cPartitions(:,1));            
              BoxMatrix(1:length(cPartitions{p,2}),p) = Ddat(cPartitions{p,2});                
            end
                      
            BoxMatrix(BoxMatrix == 0) = NaN;
            FigHandles(f) = figure('Visible','off');
            boxplot(BoxMatrix,'labels',cPartitions(:,1));
            ylabel(cData{f,1}, 'Interpreter', 'none');
            prettyplot;
            title(strTitleOpt, 'Interpreter', 'none')
            
    end
    
    if ~qSilentFigs
        set(FigHandles,'Visible','on');
    end
end
