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

function [BookendingValues] = Bookends(DataArray, optDblPrctileTol)
if ~exist('optDblPrctileTol','var');  optDblPrctileTol = 0; end; % if no tol, return max & min.
if issparse(DataArray) % full out & nix empty elements of DataArray if sparse
    DataArray = full(DataArray);
    DataArray(~DataArray) = [];
end
BookendingValues = [prctile(DataArray(:), optDblPrctileTol), prctile(DataArray(:), 100-optDblPrctileTol)];
end