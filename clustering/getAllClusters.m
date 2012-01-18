function [] = getAllClusters(dataset, data, nClusters, name)

mycluster(dataset, 1, nClusters, 1, data, name);
mycluster(dataset, 2, nClusters, 1, data, name);
mycluster(dataset, 3, nClusters, 1, data, name);
mycluster(dataset, 4, nClusters, 0, data, name);