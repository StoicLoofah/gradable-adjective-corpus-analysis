function [] = getClusters(dataset)

for i=3:4
    getAllClusters(dataset, dataset.data, i, [dataset.name 'raw']);
    getAllClusters(dataset, dataset.ooe, i, [dataset.name 'ooe']);
    getAllClusters(dataset, dataset.pmi, i, [dataset.name 'pmi']);
    
    name = [dataset.name 'th'];
    mycluster(dataset, 1, i, 1, dataset.thresholded, name);
    %mycluster(dataset, 2, i, 1, dataset.thresholded, name);
    mycluster(dataset, 4, i, 0, dataset.thresholded, name);
end