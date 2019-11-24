% Script to generate histograms of tumble distributions.

v = zeros(1,1166)
for i=1:1166
  v(i) = abs(maxwell_tumble());
end
mean(v)
std(v)
hist(v, nbins=18)

% Beta: mean =  66.062, std = 34.918
% Maxwell: mean =  61.884, std = 25.273
