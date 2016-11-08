### Load External Scripts----
source("Scripts/Libraries.R");
source("Scripts/Functions.R");
source("Scripts/Data.R");

### perform AGNES clustering on the surgeries data set ----
surgeries.dist <- dist(surgeries, method = "euclidean");
surgeries.fit <- hclust(surgeries.dist, method = "ward.D");
plot(surgeries.fit);

# get 6 clusters
surgeries.groups.count <- 6;
surgeries.groups <- cutree(surgeries.fit, surgeries.groups.count);
rect.hclust(surgeries.fit, surgeries.groups.count, border = "red");

# print average for all columns for each group
printaggregatedata(surgeries, surgeries.groups, surgeries.groups.count);

### perform DBSCAN clustering on the surgeries data set----
kNNdistplot(surgeries, k = 4)
surgeries.res <- dbscan::dbscan(surgeries, eps = 6, 4)
unique(surgeries.res$cluster)
sum(surgeries.res$cluster == 0)
pairs(surgeries, col = surgeries.res$cluster[surgeries.res$cluster > 0])

printaggregatedata(surgeries, surgeries.res$cluster)

### take a sample of the credit cards since the data set is very large----
creditCards.split = sample(seq_len(creditCards.size), 1000);
creditCards.subset = creditCards[creditCards.split,];

### perform AGNES clustering on the credit defaults data set----
creditCards.dist <- dist(creditCards.subset, method = "euclidean");
creditCards.fit <- hclust(creditCards.dist, method = "ward.D");
plot(creditCards.fit);

# get 5 clusters
creditCards.groups.count <- 10;
creditCards.groups <- cutree(creditCards.fit, creditCards.groups.count);
rect.hclust(creditCards.fit, creditCards.groups.count, border = "red")

printaggregatedata(creditCards.subset, creditCards.groups);

### perform DBSCAN clustering on the credit defaults data set----
kNNdistplot(creditCards.subset, k = 3)
creditCards.res <- dbscan::dbscan(creditCards.subset, 4.5, 3)
unique(creditCards.res$cluster)
sum(creditCards.res$cluster == 0)
pairs(creditCards.subset, col = creditCards.res$cluster[creditCards.res$cluster > 0])

printaggregatedata(creditCards.subset, creditCards.res$cluster)
