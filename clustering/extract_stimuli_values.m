function [values] = extract_stimuli_values(data, indices)

values = zeros(size(indices, 1), 1);
for i=1:size(indices, 1)
    values(i) = data(indices(i, 1), indices(i, 2));
end