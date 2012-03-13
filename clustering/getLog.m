function [dataset] = getLog(dataset)
dataset.log = log(dataset.data);
dataset.log(dataset.log == -Inf) = 0;