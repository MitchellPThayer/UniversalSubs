% Bookends.m MPT 2016.08.25
% Returns biggest(ish) and smallest(ish) values in a any-dimensional array 
% Ignores NaNs
% For sparse array input, returns small(ish) _nonzero!_ element
% Good for shorthanding: e.g. xlim(Bookends(DATA));
%
% INPUTS:
% >> DataArray: Array of any dimension, may include NaNs
% >> optional: optDblPrctileTol: double on (0,50). Instead of returning the
%   absolute min/max, will return that percentile distance from ends
%   e.g. if optDblPrctileTol = 2, this fxn returns [2%tile, 98%tile]
%
% Useful for nixing outliers, e.g. so that a few random data points don't 
% skew a colorbar and wipe out variability
%
% e.g.
% [BookendingValues] = Bookends(rand(90),2)
%
% Changelog:
%   >>  I think that nonzeros(X) accomplishes the same thing as:
%       full(X);X(~X)=[];
%       ... so, this simplified significantly from v0.

function [BookendingValues] = Bookends(DataArray, optDblPrctileTol)
if ~exist('optDblPrctileTol','var');  optDblPrctileTol = 0; end; % if no tol, return max & min.
BookendingValues = [prctile(nonzeros(DataArray), optDblPrctileTol), prctile(nonzeros(DataArray), 100-optDblPrctileTol)];
end