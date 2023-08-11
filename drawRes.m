function drawRes(cl,icl,data,labels)
halo=cl;
%cmap=colormap;
%ND=size(cl,1);

cmap=colormap;
NCLUST = length(icl);
figure(2);
% subplot(1,4,1);
for i=1:length(icl)
    idx=find(halo==i);
%     ic = randi(64);
%     ic=int8((i*64.)/(NCLUST*1.));
%     if i == 2
%         ic = 45;
%     end
%     ic = mod(i, 64)+1;
%     if ~isempty(idx)
%         disp(ic);
%     end
    hold on
    switch mod(i,28)+1
        case 1
            plot(data(idx,1),data(idx,2),'rh');%,'MarkerFaceColor','c');
        case 2
            plot(data(idx,1),data(idx,2),'g+');%,'MarkerFaceColor','m');
        case 3
            plot(data(idx,1),data(idx,2),'bo');%,'MarkerFaceColor','y');
        case 4
            plot(data(idx,1),data(idx,2),'rx');%,'MarkerFaceColor','r');
        case 5
            plot(data(idx,1),data(idx,2),'mh');%,'MarkerFaceColor','g');
        case 6
            plot(data(idx,1),data(idx,2),'c+');%,'MarkerFaceColor','b');
        case 7
            plot(data(idx,1),data(idx,2),'yo');%,'MarkerFaceColor','w');
        case 8
            plot(data(idx,1),data(idx,2),'cx');%,'MarkerFaceColor','c');
        case 9
            plot(data(idx,1),data(idx,2),'m<');%,'MarkerFaceColor','m');
        case 10
            plot(data(idx,1),data(idx,2),'ms');%,'MarkerFaceColor','y');
        case 11
            plot(data(idx,1),data(idx,2),'m^');%,'MarkerFaceColor','r');
        case 12
            plot(data(idx,1),data(idx,2),'mp');%,'MarkerFaceColor','g');
        case 13
            plot(data(idx,1),data(idx,2),'k<');%,'MarkerFaceColor','b');
        case 14
            plot(data(idx,1),data(idx,2),'m+');%,'MarkerFaceColor','w');
        case 15
            plot(data(idx,1),data(idx,2),'ks');%,'MarkerFaceColor','c');
        case 16
            plot(data(idx,1),data(idx,2),'mx');%,'MarkerFaceColor','m');
        case 17
            plot(data(idx,1),data(idx,2),'b<');%,'MarkerFaceColor','y');
        case 18
            plot(data(idx,1),data(idx,2),'kp');%,'MarkerFaceColor','r');
        case 19
            plot(data(idx,1),data(idx,2),'b^');%,'MarkerFaceColor','g');
        case 20
            plot(data(idx,1),data(idx,2),'bp');%,'MarkerFaceColor','b');
        case 21
            plot(data(idx,1),data(idx,2),'kh');%,'MarkerFaceColor','w');
        case 22
            plot(data(idx,1),data(idx,2),'b+');%,'MarkerFaceColor','c');
        case 23
            plot(data(idx,1),data(idx,2),'bo');%,'MarkerFaceColor','m');
        case 24
            plot(data(idx,1),data(idx,2),'kx');%,'MarkerFaceColor','y');
        case 25
            plot(data(idx,1),data(idx,2),'g<');%,'MarkerFaceColor','r');
        case 26
            plot(data(idx,1),data(idx,2),'kx');%,'MarkerFaceColor','g');
        case 27
            plot(data(idx,1),data(idx,2),'g^');%,'MarkerFaceColor','b');
        case 28
            plot(data(idx,1),data(idx,2),'rp');%,'MarkerFaceColor','w');
    end
%     plot(data(idx,1), data(idx,2),'o','MarkerSize',2,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
  
%     plot(data(icl,1),data(icl,2),'*','MarkerSize',20);
end


if nargin<4
    return;
end

end