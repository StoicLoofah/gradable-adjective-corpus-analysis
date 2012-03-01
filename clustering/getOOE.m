function [dataset] = getOOE(dataset)
dataset.ooe = zeros(size(dataset.data));
total = sum(dataset.data);
total = sum(total);
for i=1:size(dataset.data, 1)
    for j=1: size(dataset.data, 2)
        dataset.ooe(i, j) = dataset.data(i, j) / (sum(dataset.data(i, :)) * sum(dataset.data(:, j)) / total);
    end
end