function [dataset] = getNormalizedPMI(dataset)
dataset = getPMI(dataset);
dataset.normalized_pmi = zeros(size(dataset.data));
for i=1:size(dataset.data, 1)
    for j=1:size(dataset.data, 2)
        p_x = dataset.adj_count(i) / dataset.nTokens;
        p_y = dataset.mod_count(j) / dataset.nTokens;
        val = max(p_x, p_y);
        dataset.normalized_pmi(i, j) = dataset.pmi(i, j) / -log(val);
    end
end