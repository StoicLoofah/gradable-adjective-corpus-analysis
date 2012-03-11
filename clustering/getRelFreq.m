function [dataset] = getRelFreq(dataset)
dataset.rel_freq = zeros(size(dataset.data));
for i=1:size(dataset.data, 1)
    dataset.rel_freq(i, :) = dataset.data(i, :) / sum(dataset.data(i, :));
end