% Concentration: Give a concentration map with normalized gradient map.
% Input parameters:
% n - size of the map for bacterium
% grad_f - function for gradient.
% Output: normalized map for visualization and matrix of conc. gradient.
% --- Potential improvements ---
% Implement t (time) as a parameter to allow changing
% concentration maps in time.
% To simplify time has been left out in given simulation.
function [conc_map, norm_map] = concmap(n, grad_f)
  % Manipulate matrix to have p[C] values from 2 to 6
  conc_map = grad_f(n) .* 6 + 2;
  norm_map = grad_f(n);
endfunction
