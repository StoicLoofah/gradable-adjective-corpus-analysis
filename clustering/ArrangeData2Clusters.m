function [x_idx,y_idx]=ArrangeData2Clusters(data, distType, linkType,display)
% performs hierarchical clustering of both dimensions of the data,
% re-arranges it and plots the result
% parameter distType:        
% 'euclidean'   - Euclidean distance (defualt)
% 'seuclidean'  - Standardized Euclidean distance, each coordinate
% in the sum of squares is inverse weighted by the
% sample variance of that coordinate
% 'cityblock'   - City Block distance
% 'mahalanobis' - Mahalanobis distance
% 'minkowski'   - Minkowski distance with exponent 2
% 'cosine'      - One minus the cosine of the included angle
% between observations (treated as vectors)
% 'correlation' - One minus the sample correlation between
% observatons (treated as sequences of values).
% 'hamming'     - Hamming distance, percentage of coordinates
% that differ
% 'jaccard'     - One minus the Jaccard coefficient, the
% percentage of nonzero coordinates that differ
% 'chebychev'   - Chebychev distance (maximum coordinate difference)
% parameter linkType:
% 'single'    --- nearest distance (defualt)
% 'complete'  --- furthest distance
% 'average'   --- unweighted average distance (UPGMA) (also known as
% group average)
% 'weighted'  --- weighted average distance (WPGMA) 
% 'centroid'  --- unweighted center of mass distance (UPGMC) (*)
% 'median'    --- weighted center of mass distance (WPGMC) (*) 
% 'ward'      --- inner squared distance (minimum variance algorithm) 
%
%   Author: Assaf Gottlieb, 2008.
%
%   Contact: Assaf Gottlieb www.tau.ac.il/~assafgot
%            School of Physics and Astronomy, Tel Aviv University, Tel Aviv, Israel

if (nargin<2)
    distType='euclidean';
end;
if (nargin<3)
    linkType='average';
end;
if nargin<4
    display=1;
end;
x_dst=pdist(data',distType);
y_dst=pdist(data,distType);
x_clust=linkage(x_dst,linkType);
y_clust=linkage(y_dst,linkType);
h=figure; [tmp,tmp2,x_idx]=dendrogram(x_clust,0);close(gcf);
h=figure;[tmp,tmp2,y_idx]=dendrogram(y_clust,0);close(gcf);
if display
    figure;
    imagesc(-data(y_idx,fliplr(x_idx)));
    colormap('gray');
end