function [dataset] = getAllWeightings(dataset)

%dataset.mod_count = sum(dataset.data)';
%dataset.adj_count = sum(dataset.data, 2);
%dataset.nTokens = sum(dataset.adj_count);

dataset = getLog(dataset);
dataset = getL2Normed(dataset);
dataset = getOOE(dataset);
dataset = getRelFreq(dataset);
dataset = getThresholded(dataset);
dataset = getPMI(dataset);
dataset = getNormalizedPMI(dataset);
dataset = getPMISmoothed(dataset);
dataset = getCRPMI(dataset);
dataset = getCRPMISmoothed(dataset);
