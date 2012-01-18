function [] = printClusters(clusters)
nClusters = size(clusters, 1);
longest = 0;
fid = fopen('results.csv', 'w');
for i=1:nClusters
    if size(clusters{i}, 1) > longest
        longest = size(clusters{i});
    end
end
for i=1:longest
    for j=1:nClusters
        if size(clusters{j}, 1) >= i
            fprintf(fid, '%s,', clusters{j}{i});
        else
            fprintf(fid, ',');
        end
    end
    fprintf(fid, '\n');
end

fclose(fid);