function [DeconI] = StainDecon(Source, Io, beta, alpha, verbose)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if ~exist('verbose', 'var') || isempty(verbose)
   verbose = 0;
%else
%    warning('Verbose mode for individual normalisation functions is likely to be removed in a future release. Please use Norm.m for Visualisation.');
end

if ~exist('Source', 'var') || isempty(Source)
   error('Please supply a Source Image.');
end

% transmitted light intensity
if ~exist('A', 'var') || isempty(Io)
    Io = 255;
end

% OD threshold for transparent pixels
if ~exist('beta', 'var') || isempty(beta)
    beta = 0.15;
end

% tolerance for the pseudo-min and pseudo-max
if ~exist('alpha', 'var') || isempty(alpha)
    alpha = 1;
end


% Estimate Stain Matrix for Taret Image
MSource = EstUsingMacenko(Source, Io, beta, alpha);

% Perform Color Deconvolution of Target Image to get stain concentration
% matrix
[ ~, H, E, Bg, ~ ] = Deconvolve( Source, MSource);

DeconI(:,:,1) = H(:,:,1);
DeconI(:,:,2) = E(:,:,2);
DeconI(:,:,3) = Bg(:,:,3);
DeconI = uint8(DeconI);

end

