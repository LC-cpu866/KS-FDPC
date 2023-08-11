function [rho,delta,nneigh,ordrho]=getRhoDelta(distM, distK)

ND=size(distM,1);
rho=zeros(ND,1);

for i=1:ND
    idx=find(distM(i,:)~=inf);
    len=length(idx)-1;
    if len>0
        rho(i)=sqrt(len)*len/sum(distM(i,idx));
    end
end

delta=1./zeros(ND,1);
nneigh=zeros(ND,1);

[~,ordrho]=sort(rho,'descend');

for ii = 2:ND
    for jj = 1:size(distK,2)
        xi = ordrho(ii);
        xj = distK(ordrho(ii),jj);
        if rho(xj)>rho(xi) && distM(xi,xj)~=inf
            nneigh(xi) = xj;
            delta(xi) = distM(xi,xj);
            break;
        end
    end
end

end