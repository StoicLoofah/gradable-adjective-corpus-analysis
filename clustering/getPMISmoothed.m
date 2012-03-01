function [dataset] = getPMISmoothed(dataset)
dataset.pmi_smoothed = zeros(size(dataset.data));
temp_data = dataset.data + 1;
nTokens = dataset.nTokens + numel(dataset.data);
for i=1:size(dataset.data, 1)
    for j=1:size(dataset.data, 2)
        if temp_data(i,j) == 0
            dataset.pmi_smoothed(i, j) = 0;
        else
            dataset.pmi_smoothed(i, j) = log(temp_data(i, j) * ...
                nTokens / (dataset.adj_count(i) + size(dataset.data, 2)) / ...
                (dataset.mod_count(j) + size(dataset.data, 1)));
        end
    end
end