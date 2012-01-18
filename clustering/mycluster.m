function [clusters, adv_clusters] = mycluster(dataset, method, k, pca, data, name)
adj = dataset.adj;
%name = dataset.name;
name = [name num2str(k)];
adv_clusters = cell(0,0);
if pca == 1
    [coeff, score] = princomp(zscore(data));
    data = score;
end

if method == 1 %k-means
    name = [name 'km'];
    [idx, c] = mykmeans(data, k);
    clusters = cell(k, 1);
    for i=1:k
        clusters{i} = adj(find(idx==i));
    end
elseif method == 2 %hierarchical clustering
    name = [name 'hc'];
    %Z = linkage(data);
    %H = dendrogram(Z);
    %idx = cluster(Z, 'maxclust', k);
    idx = clusterdata(data, 'maxclust', k);%, 'linkage', 'centroid');
elseif method == 3 %mixture of gaussians
    name = [name 'gm'];
    [idx, nlogl] = mygm(data, k);
elseif method == 4 %coclustering
    name = [name 'cc'];
    [idx, col_idx] = SpectralCoClustering(data, k, 1);
    adv_clusters = cell(max(col_idx), 1);
    for i=1:max(col_idx)
        adv_clusters{i} = sort(dataset.mod(find(col_idx==i)));
    end
end

if pca == 1
    %name = [name '_pca'];
end

clusters = cell(k, 1);
for i=1:k
    clusters{i} = sort(adj(find(idx==i)));
end

for i=1:k
    max_index = i;
    for j=i+1:k
        if size(clusters{max_index}, 1) < size(clusters{j}, 1)
            max_index = j;
        end
    end
    temp = clusters{i};
    clusters{i} = clusters{max_index};
    clusters{max_index} = temp;
end

longest = size(clusters{1});
fid = fopen([name '.csv'], 'w');
% for i=1:longest
%     for j=1:k
%         if size(clusters{j}, 1) >= i
%             fprintf(fid, '%s,', clusters{j}{i});
%         else
%             fprintf(fid, ',');
%         end
%     end
%     fprintf(fid, '\n');
% end
for i=1:k
    for j=1:size(clusters{i}, 1)
        fprintf(fid, '%s,', clusters{i}{j});
    end
    fprintf(fid, '\n');
end

fclose(fid);

    
function [idx, c] = mykmeans(data, k)
[idx, c, sumd] = kmeans(data, k);
for i=1:1000
    [temp_idx, temp_c, temp_sumd] = kmeans(data,k);
    if sum(temp_sumd) < sum(sumd)
        idx = temp_idx;
        c = temp_c;
        sumd = temp_sumd;
    end
end

function [idx, nlogl] = mygm(data, k)
obj = gmdistribution.fit(data, k, 'SharedCov', true);
[idx, nlogl] = cluster(obj, data);
for i=1:100
    temp_obj = gmdistribution.fit(data, k, 'SharedCov', true);
    [temp_idx, temp_nlogl] = cluster(temp_obj, data);
    if temp_nlogl < nlogl
        idx = temp_idx;
        nlogl = temp_nlogl;
        obj = temp_obj;
    end
end