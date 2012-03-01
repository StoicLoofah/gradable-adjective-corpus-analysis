function [dataset] = getThresholded(dataset)
threshold = 10;
dataset.thresholded = zeros(size(dataset.data));
for i=1:size(dataset.data, 1)
    for j=1:size(dataset.data, 2)
        if dataset.data(i,j) >= threshold;
            dataset.thresholded(i, j) = 1;
        else
            dataset.thresholded(i, j) = 0;
        end
    end
end