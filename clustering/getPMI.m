function [dataset] = getPMI(dataset)
dataset.pmi = zeros(size(dataset.data));
for i=1:size(dataset.data, 1)
    for j=1:size(dataset.data, 2)
        if dataset.data(i,j) == 0
            dataset.pmi(i, j) = 0;
        else
            dataset.pmi(i, j) = log(dataset.data(i, j) * ...
                dataset.nTokens / dataset.adj_count(i) / dataset.mod_count(j));
        end
    end
end