% KS-FDPC: Fast Density Peaks Clustering based on Improved Mutual K-nearest-neighbor and Sub-cluster Merging
clear
clc

load D:\Xnewm\datasets\synthetic\Pathbased.txt;
X = Pathbased;
labels = X(:,end);
X(:,end) = [];

tic;

% delete duplicate data
[data, ia, ic] = unique(X,'rows');

K = 12;
ND=size(data,1);
N=ND*(ND-1)/2;

% Obtain the sparse distance matrix between samples and the nearest-neighbor of each point
% Input：data，K
% Output：sparse distance matrix，K-nearest-neighbor
[distM,distK,noise]=getDistM(data,K);

% Obtain the local density and relative distance of sample points
% Input：sparse distance matrix
% Output：local density (rho)，relative distance (delta)，father node (nneigh)
[rho,delta,nneigh,ordrho]=getRhoDelta(distM, distK);

% Obtain the results of initial clustering
% Input：nneigh, rho
% Output：initial centers and results
NCLUST=length(unique(labels));
[cl,icl,nneigh]=initClust(rho, nneigh, distK, delta, NCLUST);

if length(icl)<NCLUST
    error('Warning：the initial number of centers is too small，please reduce the value of K.');
end

% Merge the initial clustering results
% Input：initial cl; density(rho)；sparse distance matrix (distM)；the number of sub-clusters(NCLUST)
% Output：Final merge result(cl)
[cl,icl]=mergingNew(cl,rho,distM,NCLUST,icl,distK);

for i=1:ND
    if(nneigh(ordrho(i))~=0)
        cl(ordrho(i))=cl(nneigh(ordrho(i)));
    end
end

% If the K is too small, reallocate the sub-clusters with smaller sample sizes
cl = finalClust(cl,distK,rho,NCLUST);

% Restore
icl = ia(icl);
pred = cl(ic);
cl = pred;
toc;

% print
drawRes(cl,icl,X,labels);
if length(unique(cl))~=NCLUST
    disp('The number of clusters is wrong !');
end
