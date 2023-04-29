%编写归一化函数，对输入的向量或矩阵进行归一化操作
function result=Normal(X)
%n=size(X,1);
m=size(X,2);
index=zeros(2,m);
for i=1:m
    index(1,i)=max(X(:,i));
    index(2,i)=min(X(:,i));
    if index(1,i)==index(2,i) % 防止出现某一维数据为零的情况
        index(1,i)=index(1,i)+1;
    end
end
%result=zeros(n,m);
result=(X-index(2,:))./(index(1,:)-index(2,:));
end