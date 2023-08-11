function cl = finalClust(cl,distK,rho,NCLUST)
% perform final processing on the merged sub-clusters (in cases where the K value is too small)
num = length(unique(cl));
if num<=NCLUST
    return;
end
ND = length(cl);
numcl = unique(cl);
nClu = zeros(num,1);
clu = zeros(num,ND);

for i=1:num
    item = find(cl==numcl(i));
    nClu(i) = length(item);
    clu(i,1:nClu(i)) = item(:);
end

[~,index] = sort(nClu);

count = num-NCLUST;
while count>0
    idx = index(count);
    clu_idx = clu(idx,1:nClu(idx));  % find all elements of the sub-cluster to be merged
    clu_idx_exp = distK(clu_idx,:);  % find the extension of all elements of the sub-cluster to be merged (KNN)
    clu_idx_exp = clu_idx_exp(:);   
    clu_cl = unique(cl(clu_idx_exp));
    
    mergIdx = 0;
    mergValue = 0;
    for j=1:num
        if j==idx
            continue;
        end
        if ismember(numcl(j),clu_cl)
            idxI = clu_idx;
            idxJ = clu(j,1:nClu(j));
            PavgI = mean(rho(idxI));
            PavgJ = mean(rho(idxJ));
            stdI = max(std(rho(idxI)),1e-6); % when there is only one sample in the cluster, the variance is zero.
            stdJ = std(rho(idxJ));
            stdIJ = std([rho(idxI)' rho(idxJ)']);
            merg = min(PavgI,PavgJ)*min(stdI,stdJ)/max(PavgI,PavgJ)/max(stdI,stdJ);
            merg = sqrt(merg)/stdIJ;
            if merg>mergValue
                mergValue = merg;
                mergIdx = j;
            end
        end
    end
    if mergIdx>0
        ci = cl(clu_idx(1));
        cl(cl==ci) = numcl(mergIdx);
    end
    count=count-1;
end

end