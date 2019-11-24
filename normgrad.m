function norm_map = normgrad(n, type="Circular")
  [X,Y] = meshgrid(-1:1/n:1, -1:1/n:1);
  gradient = sqrt(X.^2 + Y.^2);
  % Normalization (Make values fall between 0 and 1)
  norm_map = gradient / max(max(gradient));
  imshow(norm_map);
endfunction
