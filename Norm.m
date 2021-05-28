function Norm = Norm( Source, Target, Method, varargin )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Norm: Normalise the appearance of a Source Image to a Target Image using 
%       the specified method.
%
%
% Input:
% Source         - RGB Source image.
% Target         - RGB Reference image.
% Method         - Stain Normalisation method.
% varargin       - Any additional arguments for the target Normalisation
%                  method. The order of the arguments must match that of 
%                  the target function.
%
%
% Output:
% Norm           - Normalised RGB Source image.
%
%
% Notes: Valid values for Method and their associated normalisation 
%        function are as follows:

%            'Macenko'  - Macenko Linear Stain Channel Normalisation.
%            'Reinhard' - Reinhard Colour Normalisation.
%            'RGBHist'  - RGB Histogram Specification.
%
%        If you wish to use your own Stain Normalisation function, please
%        select the 'Custom' option for Method and provide a function 
%        handle to your custom function as the forth argument.
%
%        A valid custom Normalisation function must take the following input 
%        arguments, in this order:
%            Source         - RGB Source image.
%            Target         - RGB Reference image.
%            varargin       - Any additional arguments for the custom Normalisation
%                             method.
%        And output the following:
%            Norm           - Normalised RGB Source image.
%
%        If your existing Stain Normalisation function is not of this form: 
%            Please create a new function that accepts these arguments and 
%            then calls the existing function as appropriate. 
%            This new function can then be used here instead. 
%
%
% References:
% See each normalisation function for its associated references.
%
%
% Copyright (c) 2015, Nicholas Trahearn
% Department of Computer Science,
% University of Warwick, UK.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~exist('Source', 'var') || isempty(Source)
   error('Please supply a Source Image.');
end

if ~exist('Target', 'var') || isempty(Target)
   error('Please supply a Target Image.');
end

if ~exist('Method', 'var') || isempty(Method)
   error('Please supply a Stain Normalisation Method.');
end

switch Method
    case 'Macenko'
        % Call Macenko's Method.
        Norm = NormMacenko(Source, Target, varargin{:});
    case 'Reinhard'
        % Call Reinhard's method.
        Norm = NormReinhard(Source, Target, varargin{:});
    case 'RGBHist'
        % Call the RGB Histogram Specification method.
        Norm = NormRGBHist(Source, Target, varargin{:});
    otherwise
        error('Unknown Stain Normalisation Method.');
end

end

