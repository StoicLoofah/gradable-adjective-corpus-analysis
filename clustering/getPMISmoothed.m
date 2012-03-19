function [dataset] = getPMISmoothed(dataset)
smoothing_constant = 1;
dataset.pmi_smoothed = zeros(size(dataset.data));
temp_data = dataset.data + smoothing_constant;
nTokens = dataset.nTokens + numel(dataset.data) * smoothing_constant;
for i=1:size(dataset.data, 1)
    for j=1:size(dataset.data, 2)
        if temp_data(i,j) == 0
            dataset.pmi_smoothed(i, j) = 0;
        else
            dataset.pmi_smoothed(i, j) = log(temp_data(i, j) * ...
                nTokens / (dataset.adj_count(i) + size(dataset.data, 2) * ...
                smoothing_constant) / ...
                (dataset.mod_count(j) + size(dataset.data, 1) * smoothing_constant));
        end
    end
end