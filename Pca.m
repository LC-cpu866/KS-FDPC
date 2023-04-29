function data = Pca(data)

[~, score, latent] = pca(data);

for cut = 1:length(latent)
    if sum(latent(1:cut))/sum(latent) > 0.99
        break;
    end
end
data = score(:,1:cut);


end