function [distM,distK,noise]=getDistM(data,K)
% M(k-NN)G-DPC: density peaks clustering based on improved mutual
% K-nearest-neighbor graph

tree=createns(data);
ND=size(data,1);
distM=1./zeros(ND);
noise=zeros(ND,1);

distK=zeros(ND,2*K);
[item,dist]=knnsearch(tree,data(:,:),'K',2*K+1); 

for i=1:ND
    distK(i,:)=item(i,2:2*K+1);
    distM(i,distK(i,:))=dist(i,2:2*K+1);
    distM(distK(i,:),i)=dist(i,2:2*K+1);
end

DS_knn=zeros(ND);
DS_knn_num=zeros(ND,1);
dislevel=zeros(ND,1);

for i=1:ND
    for j=1:2*K
        xj=distK(i,j);
        DS_knn_num(xj)=DS_knn_num(xj)+1;
        DS_knn(xj,DS_knn_num(xj))=i;
    end
end

for i=1:ND
    if DS_knn_num(i)==0
        noise(i)=1;
    elseif DS_knn_num(i)<K
        idx=DS_knn(i,1:DS_knn_num(i));
        dislevel(i)=max(distM(i,idx));
    else
        idx=DS_knn(i,1:DS_knn_num(i));
        dist=sort(distM(i,idx));
        dislevel(i)=dist(K);
    end
end

for i=1:ND
    for j=1:2*K
        xj=distK(i,j);
        if distM(i,xj)<dislevel(i) && distM(i,xj)<dislevel(xj)
            continue;
        end
        distM(i,xj)=inf;
        distM(xj,i)=inf;
    end
end

end