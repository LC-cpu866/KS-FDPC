function [cl,icl]=mergingNew(cl,rho,distM,NCLUST,icl,distK)

ND=length(cl);
num=length(unique(cl));
clu=zeros(num,ND);
nClu=zeros(num,1);
merg=zeros(num);
SIM=zeros(num); % the similarity between sub-clusters
Pavg=zeros(num); % the average density between sub-clusters
STD=zeros(num); % the standard deviation between sub-clusters
K=size(distK,2);
% mind = min(min(distM));

for i=1:ND
    nClu(cl(i))=nClu(cl(i))+1;
    clu(cl(i),nClu(cl(i)))=i;
end

for i=1:ND
    for j=1:K
        xj=distK(i,j);
        if merg(cl(i),cl(xj))>0 || cl(i)==cl(xj)
            continue;
        end
        % compute the similarity
        idxI=clu(cl(i),1:nClu(cl(i)));
        idxJ=clu(cl(xj),1:nClu(cl(xj)));
        item=1./distM(idxI,idxJ);
        len=length(find(item>0));
        SIM(cl(i),cl(xj))=sum(sum(item))/sqrt(len);
        SIM(cl(xj),cl(i))=SIM(cl(i),cl(xj));
        
        % compoute the average density and the standard deviation
        PavgI=mean(rho(idxI));
        PavgJ=mean(rho(idxJ));
        Pavg(cl(i),cl(xj))=2*sqrt(PavgI*PavgJ)/(PavgI+PavgJ);
        Pavg(cl(xj),cl(i))=Pavg(cl(i),cl(xj));
        
        idxIJ=[idxI idxJ];
        STD(cl(i),cl(xj))=std(rho(idxIJ));
        STD(cl(xj),cl(i))=STD(cl(i),cl(xj));
        
        % compute merge
        merg(cl(i),cl(xj))=1;
        merg(cl(xj),cl(i))=merg(cl(i),cl(xj));
    end
end

SIM=SIM./max(max(SIM));
STD=Pavg./STD;
STD=STD./max(max(STD));

[x,y]=find(merg>0);
merg(:,:)=0;
for i=1:length(x)
    if merg(x(i),y(i))==0 
        a=x(i);
        b=y(i);
        merg(a,b)=SIM(a,b)*Pavg(a,b)+SIM(a,b)*STD(a,b)+Pavg(a,b)*STD(a,b);
        merg(b,a)=merg(a,b);
    end
end


% merge sub-clusters
while(num>NCLUST)
    if max(max(merg))==0
        break;
    end
    [x,y]=find(merg==max(max(merg)));

    if cl(icl(x(1)))~=cl(icl(y(1)))
        item=cl(icl(x(1)));
        for j=1:length(icl)
            if cl(icl(j))==item
                cl(icl(j))=cl(icl(y(1)));
            end
        end
        num=num-1;
    end
    
    merg(x(1),y(1))=0;
    merg(y(1),x(1))=0;
end
end