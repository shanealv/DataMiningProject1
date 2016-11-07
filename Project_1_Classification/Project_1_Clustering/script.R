# Load External Scripts
source("Scripts/Libraries.R");
source("Scripts/Functions.R");
source("Scripts/Data.R");

surgeries.dist <- dist(surgeries, method = "euclidean");
surgeries.fit <- hclust(surgeries.dist, method = "ward.D");
plot(surgeries.fit);
surgeries.groups <- cutree(surgeries.fit, 4);
rect.hclust(surgeries.fit, 4, border = "red");

creditCards.split = sample(seq_len(creditCards.size), 2000);
creditCards.subset = creditCards[creditCards.split,];

creditCards.dist <- dist(creditCards.subset, method = "euclidean");
creditCards.fit <- hclust(creditCards.dist, method = "ward.D");
plot(creditCards.fit);
creditCards.groups <- cutree(creditCards.fit, 5);
rect.hclust(creditCards.fit, 5, border = "red")

kNNdistplot(surgeries, k = 4)
surgeries.res <- dbscan::dbscan(surgeries, eps = 3, 4)
unique(surgeries.res$cluster)
sum(surgeries.res$cluster == 0)
pairs(surgeries, col = surgeries.res$cluster[surgeries.res$cluster > 0]) 

kNNdistplot(creditCards.subset, k = 10)
creditCards.res <- dbscan::dbscan(creditCards.subset, 5, 4)
unique(creditCards.res$cluster)
sum(creditCards.res$cluster == 0)
pairs(creditCards.subset, col = creditCards.res$cluster[creditCards.res$cluster > 0])
