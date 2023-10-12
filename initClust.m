function [cl,icl,nneigh]=initClust(rho, nneigh, distK, delta, c)

ND=length(rho);
cl=zeros(ND,1)-1;
[~,ordrho]=sort(rho,'descend');
icl=[];

for i=1:ND
    if nneigh(ordrho(i))==0 && rho(ordrho(i))~=0
        icl=[icl ordrho(i)];
        cl(ordrho(i))=length(icl);
    end
end

if length(icl) < c
    r = rho.*delta;
    r(isnan(r)) = 0;
    [~, ordr] = sort(r, 'descend');
    setf = setdiff(ordr, icl);
    [~, loc] = ismember(setf, ordr);
    newordr = ordr(sort(loc));
    numicl = length(icl);
    while numicl < c
        icl = [icl newordr(1)];
        newordr(1) = [];
        numicl = numicl + 1;
        cl(icl(numicl)) = numicl;
    end
end

for i=1:ND
    if cl(ordrho(i))==-1 && rho(ordrho(i))~=0
        cl(ordrho(i))=cl(nneigh(ordrho(i)));
    end
end

% rho==0
for i=1:ND
    if rho(i)==0 && ~ismember(i, icl)
        for j=1:size(distK,2)
            if cl(distK(i,j))>0
                cl(i)=cl(distK(i,j));
                nneigh(i)=distK(i,j);
                break;
            end
        end
    end
end

end