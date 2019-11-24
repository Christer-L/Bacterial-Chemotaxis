function angle = tumble()
  % 1. Generate random value from uniform distribution
  % 2. Select left or right direction with nearly equal probabilities.
  % 3. Get angle from beta distribution inverse CDF.
  % Parameters for beta distribution accuired through curve fitting.
  if rand >= 0.5
    angle = -180 * betainv(rand, 2.1, 3.6);
  else
    angle = 180 * betainv(rand, 2.1, 3.6);
  endif
endfunction
