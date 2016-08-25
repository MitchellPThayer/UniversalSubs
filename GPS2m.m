% MPT 2016.07.24
% Converts GPS coordinates to a cartesian X/Y (N/E) coords
%%%%%%%%%%%%%%%%%%%
% INPUTS: (Lon/Lat/Alt can be vectors!)
%   >> Latitude in degrees
%   >> Longitude in degrees
%   >> Height in meters
%   >> vRefPoint ... Can be either vector or string
%       >> if vector, [Lat, Lon, Alt]
%       >> e.g. string = 'RAf'

%%%%%%%%%%%%%%%%%%%
% OUTPUTS:
%   >> Distances in cartesian meters
%
%
%%%%%%%%%%%%%%%%%%%
% Some example stuff from SONGNEX
% %% Some coordinates for testing
% wgs84 = wgs84Ellipsoid('meters');
% latParis = dms2degrees([48 51 24]); lonParis = dms2degrees([2 21 03]); hParis = 80;
% latMiami = dms2degrees([ 25 46 31]); lonMiami = dms2degrees([-80 12 32]); hMiami = -25; refMiami = [latMiami, lonMiami, hMiami];
% latRAF = 39.913921; lonRAF = -105.117761; hRAF = 1716; refRAF = [latRAF, lonRAF, hRAF];
% %% Example from MATLAB
% [dx,dy,dz] = ecefOffset(wgs84,latParis,lonParis,hParis,latMiami,lonMiami,hMiami); 
% %% Same example, using my fxn
%  [dXm dYm dZm] = GPS2m(latParis, lonParis, hParis, refMiami);


function [dXm dYm dZm] = GPS2m(vLat, vLon, vAlt, vRefPoint)

if nargin < 4
    disp('################################')
    disp('Missing data! Need Lon + Lat!')
    [dXm dYm dZm] = deal(NaN);
end

if ischar(vRefPoint)
    switch vRefPoint
        case 'RAF'
            vRefPoint = [39.913921, -105.117761, 1716]; % Coordinates for RAF base in [deg, deg, meter]
            % For my own silliness, make sure I entered LatLonAlt rather
            % than the LonLatAlt, which I usually use
            
            if vLon > vLat
                for i = 1:20
                disp('********************************')
                end
                disp('HEY HEY! You probably switched Lon and Lat')
                disp('Just a warning!!!!!')
            end
            
        case 'potato'
            disp('lololol')
    end
end

wgs84 = wgs84Ellipsoid('meters'); % Call the earth

[dXm,dYm,dZm] = ecefOffset(wgs84, vLat, vLon, vAlt, vRefPoint(1), vRefPoint(2), vRefPoint(3));



end