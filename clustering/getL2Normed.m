function [dataset] = getL2Normed(dataset)
dataset.l2_normed = zeros(size(dataset.data));
for i=1:size(dataset.data, 1)
    dataset.l2_normed(i, :) = dataset.data(i, :) / norm(dataset.data(i, :), 2);
end