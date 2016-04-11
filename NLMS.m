%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NLMS.m - Normalized least mean squares algorithm
%
% Usage: [emean, y] = NLMS(d, u, mu, M, a)
%
% Inputs:
% d  - the vector of desired signal samples of size Ns,
% u  - the vector of input signal samples of size Ns,
% mu - the � parameter,
% M  - the number of taps.
% a  - constant to mitigate norm(u) ~ 0
%
% Outputs:
% emean - the output error vector of size Ns
% y  = output coefficients
%
%%%%%%%%%%%%%%%%os%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [e,y] = NLMS(d, u, m, M, a)

% Initialization

 Ns = length(d);
if (Ns ~= length(u))  
    return; 
end

u = [zeros(M-1, 1); u];
w = zeros(M,1);
y = zeros(Ns,1);
e = zeros(Ns,1);

   for n = 1:Ns
       uu = u(n+M-1:-1:n);
       k=(uu*m)/(a+norm(uu));
       y(n) = w'*uu;
       e(n) = d(n) - y(n);
       w = w + e(n)*k;
    end
  


end

