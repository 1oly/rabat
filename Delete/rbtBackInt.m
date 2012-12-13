function R = rbtBackInt(h,kneepoint,C)
%
%   Description: Compute decay curve from Schr�ders backwards integration
%                method
%
%   Usage: R = rbtBackInt(h,onset,kneepoint)
%
%   Input parameters:
%       - h         : Impulse response
%       - onset     : Index value at onset
%       - kneepoint : Index value at kneepoint between sound decay and noise floor
%       - method    : 'comp' - with energy compensation (default)
%   Output parameters:
%       - R: Normalized decay curve in dB
%
%   Ref: ISO 3382-1:2009(E) section 5.3.3
%
%   Author: Oliver Lylloff, Mathias Immanuel Nielsen & David Duhalde
%   Date: 30-10-2012, Last update: 5-11-2012
%   Acoustic Technology, DTU 2012

% Check size of h
[m,n] = size(h);

if m<n
    h = h';
    [m,n] = size(h);
end

if isempty(kneepoint)
    kneepoint = length(h);
else
    kneepoint = floor(kneepoint);
end

R = zeros(kneepoint,n);

for i = 1:n
    
    h2 = h(:,i).^2;
    R(:,i) = cumsum(h2(kneepoint:-1:1))+C;
    R(:,i) = R(end:-1:1,i);
    R(:,i) = 10*log10(R(:,i));        % In dB
    R(:,i) = R(:,i)-max(R(:,i));      % Normalize
    
end


end