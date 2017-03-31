% F_PARKS: This is a DLL file to implement Parks-McClellan FIR filter design
%
% Usage: h = f_parks (numtaps,numband,bands,des,weight,type);
%
% Inputs:
%         numtaps = filter order
%         numband = number of filter bands
%         bands   = vector of length 2*numband containing normalized
%                   band edge frequencies (0 to 0.5)
%         des     = vector of length numband containing desired band
%                   gains (e.g. 0 = stop, 1 = pass)
%         weight  = vector of length numband containing relataive 
%                   weights for each band
%         type    = integer specifying filter type
%
%                  1 = frequency selective (e.g. bandpass)
%                  2 = differentiator
%                  3 = Hilbert transformer
% Outputs:
%          h = vector of length numtaps containint FIR filter
%              coefficients
%
% NOTE: The source version of this function was written in C and was developed
%       by Jake Janovetz (janovetz@uiuc.edu).  It is free software subject to  
%       the terms of the GNU Library General Public License as published by 
%       the Free Software Foundation.
 