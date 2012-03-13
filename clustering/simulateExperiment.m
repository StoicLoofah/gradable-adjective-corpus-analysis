function [] = simulateExperiment(dataset, indices)

dataset = getNormalizedPMI(dataset);
my_values = extract_stimuli_values(dataset.normalized_pmi, indices);

std_dev = ones(100, 1) * 1.8;
means = (my_values + 1) * 4 + 1;

total = zeros(100, 1);
for i = 1:47
    values = normrnd(means, std_dev);
    values(values < 1) = 1;
    values(values > 9) = 9;
    values = round(values);
    values = zscore(values);
    total = total + values;
end

final_values = total / 47;
display(final_values);
my_corr = corr([my_values final_values]);
display(my_corr);