function angle = maxwell_tumble()
  while true
    x = rand;
    if rand < maxwell(x)
      if rand > 0.5
        angle = x * 180;
      else
        angle = -x * 180;
      endif
      break
    endif
  endwhile
endfunction
