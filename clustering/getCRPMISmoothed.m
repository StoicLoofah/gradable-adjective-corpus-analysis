function [dataset] = getCRPMISmoothed(dataset)
dataset = getPMISmoothed(dataset);
f_adjust = dataset.data ./ (dataset.data + 1);
dataset.crpmi_smoothed = zeros(size(dataset.data));

for i=1:size(dataset.data, 1)
    for j=1:size(dataset.data, 2)
        other = min(sum(dataset.data(i, :)), sum(dataset.data(:, j)));
        dataset.crpmi_smoothed(i, j) = dataset.pmi_smoothed(i, j) * f_adjust(i, j) * other / (other + 1);
    end
end