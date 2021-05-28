function [GLCMS,SI] = glcm3D(I, NL, GL, Offset)

% Matthew Basso, IAMLAB, Ryerson University
%glcm3D

%   GLCMS = glcm3D(I) analyzes pairs of horizontally adjacent pixels
%   in a scaled version of I.  If I is a binary image, it is scaled to 2
%   levels. If I is an intensity image, it is scaled to 8 levels. In this
%   case, there are 8 x 8 = 64 possible ordered combinations of values for
%   each pixel pair. GRAYCOMATRIX accumulates the total occurrence of each
%   such combination, producing a 8-by-8 output array, GLCMS. The row and
%   column subscripts in GLCMS correspond respectively to the first and
%   second (scaled) pixel-pair values.
%
%   GLCMS = GRAYCOMATRIX(I,PARAM1,VALUE1,PARAM2,VALUE2,...) returns one or
%   more gray-level co-occurrence matrices, depending on the values of the
%   optional parameter/value pairs. Parameter names can be abbreviated, and
%   case does not matter.

% Scale I so that it contains integers between 1 and NL.
if GL(2) == GL(1)
  SI = ones(size(I));
else 
    slope = NL / (GL(2) - GL(1));
    intercept = 1 - (slope*(GL(1)));
    SI = floor(imlincomb(slope,I,intercept,'double'));
end

% Clip values if user had a value that is outside of the range, e.g.,
% double image = [0 .5 2;0 1 1]; 2 is outside of [0,1]. The order of the
% following lines matters in the event that NL = 0.
SI(SI > NL) = NL;
SI(SI < 1) = 1;

numOffsets = size(Offset,1);

if NL ~= 0

  % Create vectors of row and column subscripts for every pixel and its
  % neighbor.
  s = size(I);
  [r,c] = meshgrid(1:s(1),1:s(2));
  r = r(:);
  c = c(:);

  % Compute GLCMS
  
  GLCMS = zeros(NL,NL,numOffsets);
  
  for k = 1 : numOffsets
      
    GLCMS(:,:,k) = computeGLCM3D(r,c,Offset(k,:),SI,NL);

  end
  
end

