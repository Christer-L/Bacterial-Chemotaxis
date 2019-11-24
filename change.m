function change = change(p_concentration)
  change = 1 + 2.7 .* exp(-((-p_concentration+3).^2)/4);
endfunction
