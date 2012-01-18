function [row_clust_idx, col_clust_idx,y_index,x_index]=SpectralCoClustering(A,k,display,names)
% co-clustering sparse data (e.g. words and documents) using the simultaneous occurrences
% For best performance, use discrete values, preferably binary or ternary representation. 
% The basic algorithm follows the paper by :
% Dhillon, I.S. (2001) Co-clustering documents and words using bipartite
% spectral graph partitioning, in proceedings of the acm sigkdd conference, 269-274
% Each bicluster is also sorted using single-linkage hierarchical algorithm 
% Usage: [row_clust_idx, col_clust_idx,y_index,x_index]=SpectralCoClustering(A,k,display,names)
% Inputs: 
%       A: the [nxm] matrix to co-cluster, containing the co-occurrences of n instances
%           (rows) and m features (columns).
%       k (default =2): The number of desired clusters.
%       display (optional, default =0): binary variable determining whether to create a figure of
%                                       the clustered matrix
%       names (optional, used only if display=1): the names of the instances to display. 
%                       Use names = 1 to display the cluster numbers on the y-axis
% Outputs:
%       row_clust_idx: the cluster number for each instance  (rows)
%       col_clust_idx: the cluster number for each feature (columns)
%       y_index: The order of the y-axis (Instances)
%       x_index: The order of the x-axis (features)
%   Author: Assaf Gottlieb, 2008.
%
%   Contact: Assaf Gottlieb www.tau.ac.il/~assafgot
%            School of Physics and Astronomy, Tel Aviv University, Tel Aviv, Israel

if (isempty(A))
    error('The input matrix is empty');
end;
if (length(find(sum(abs(A),1)==0))>0)
    error('data matrix contains empty features. Please remove them and re-run');
end;
if (length(find(sum(abs(A),2)==0))>0)
    error('data matrix contains empty instances. Please remove them and re-run');
end;
if nargin<2
    k=2;
end;
if nargin<3
    display=0;
end;

D1=diag(sum(A,2));
D2=diag(sum(A,1));
D1(find(D1==0))=eps;
D2(find(D2==0))=eps;

D1_root=abs((D1)^(-0.5));
D2_root=abs((D2)^(-0.5));
An=D1_root*A*D2_root;

[U,S,V]=svd(An,'econ');
num_of_pcs=ceil(log2(k));
z=[D1_root*U(:,2:num_of_pcs+1);D2_root*V(:,2:num_of_pcs+1)];
%z=[D1_root*U(:,2:k);D2_root*V(:,2:k)];
clust_idx=kmeans(z,k);
row_clust_idx=clust_idx(1:size(A,1));
col_clust_idx=clust_idx(size(A,1)+1:end);
x_index=[];
y_index=[];
for clust=1:k
    clustk_y_idx=find(clust_idx(1:size(A,1))==clust);
    clustk_x_idx=find(clust_idx(size(A,1)+1:end)==clust);
    data_clust=A(clustk_y_idx,clustk_x_idx);
    if (length(clustk_x_idx)>2 & length(clustk_y_idx)>2 & (sum(var(data_clust,0,1))>0 | sum(var(data_clust,0,2))>0))
        if (length(find(sum(data_clust,1)==0))>0 | length(find(sum(data_clust,2)==0))>0) 
            % this section is actually obsolete, since no empty rows or features are allowed
            data_clust_y_zeros=find(sum(data_clust,2)==0);
            data_clust_x_zeros=find(sum(data_clust,1)==0)';
            data_clust_y_no_zeros=find(sum(data_clust,2));
            data_clust_x_no_zeros=find(sum(data_clust,1))';
            data_clust_no_zeros=data_clust(data_clust_y_no_zeros,data_clust_x_no_zeros);
            [clust_x_sorted,clust_y_sorted]=ArrangeData2Clusters(data_clust_no_zeros,'cosine','single',0);
            x_index=[x_index;clustk_x_idx([data_clust_x_no_zeros(clust_x_sorted);data_clust_x_zeros])];
            y_index=[y_index;clustk_y_idx([data_clust_y_no_zeros(clust_y_sorted);data_clust_y_zeros])];
        else
            [clust_x_sorted,clust_y_sorted]=ArrangeData2Clusters(data_clust,'cosine','single',0);
            x_index=[x_index;clustk_x_idx(clust_x_sorted')];
            y_index=[y_index;clustk_y_idx(clust_y_sorted')];
        end;
    else
        x_index=[x_index;clustk_x_idx];
        y_index=[y_index;clustk_y_idx];
    end
end

% displaying the biclusters
if display
    figure;colormap(gray);
    imagesc(-A(y_index,x_index));
    set(gca,'FontSize',14,'FontWeight','bold');
    if nargin>3
        if length(names)==length(y_index)
            names_clusters=names;
            for k=1:length(names)
                name_cluster=[names{k},' (',num2str(clust_idx(k)),')'];
                names_clusters{k}=name_cluster;
            end
            set(gca,'YTick',1:length(y_index),'YTickLabel',names_clusters(y_index'),'FontSize',10,'FontWeight','bold');
        else
            set(gca,'YTick',1:length(y_index),'YTickLabel',clust_idx(y_index'),'FontSize',10,'FontWeight','bold');
        end
    end;
end;
