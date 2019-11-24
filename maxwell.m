function p = maxwell(x)
  a = 1575.6;
  % b = 2915.64;
  % We do not use b to normalize distribution to scale between 0 to 1.
  p = sqrt(2/pi).*a.^(-3/2).*(180.*x).^2.*exp(-(180.*x).^2/(2.*a));
endfunction
