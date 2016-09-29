% Conc2Colv3.m - Converts mixing ratios to vertical column, assuming a
% well-mixed planetary boundry layer.
%
% Mitchell Thayer 2016.08
% mthayer (at) chem.wisc.edu
%
% Essentially (mixing ratio)*(PBL height) with a altitude-pressure correction
% derived by integrating P(z) = P(z=0)*exp(z/ScaleHeight) from the ground to
% the top of the PBL.
%
%%%%%%%%%
% INPUTS: (can freely mix scalars and vectors)
% >> MixingRatio_ppb: Scalar or vector of mixing ratios in parts per billion.
% >> T_K: Scalar or vector of temperature in K
% >> P_torr: Scalar or vector of pressures in torr.
% >> zPBL_m: Scalar or vector describing height of boundary layer in meters.
%
%%%%%%%%%
% OUTPUTS:
% >> ColumnDensity_per_cm2: Column density in molecules per cm^2
% >> ColumnDensity_DU: Column density in Dobson Units
%
%%%%%%%%%
% EXAMPLE:
% [CloumnDensity_per_cm2, ColumnDensity_DU] = Conc2Col(3.3, 760, 298, 1500);
% CloumnDensity_per_cm2 = 1.104e+16
% ColumnDensity_DU = 0.4107


function [CloumnDensity_per_cm2, ColumnDensity_DU] = Conc2Col(MixingRatio_ppb, P_torr, T_K, zPBL_m)
    
    % Constants
    h_cm = 7.5e5; % scale height in cm
    
    % Unit conversion
    zPBL_cm = zPBL_m*1e2;
   
    % Calculate density of air in molecules/cm^3
    M = P_torr.*6.022E23./(T_K.*0.08206.*760*1e3);
    
    % Convert mixing ratio to molecules/cm^3
    MixingRatio_per_cm3 = MixingRatio_ppb.*M/(1e9); 
    
    % Convert Mixing Ratio to molecules/cm^2
    CloumnDensity_per_cm2 = MixingRatio_per_cm3*(h_cm - h_cm*exp(-zPBL_cm/h_cm));
  
    % Convert molecules/cm^3 to Dobson Units
    ColumnDensity_DU = CloumnDensity_per_cm2/2.69e16;
    
end