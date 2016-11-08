printaggregatedata <- function(dataset, groups) {
    aggdata <- read.table(text = "", col.names = c(1:(length(dataset) + 1)));
    for (i in as.numeric(min(groups):max(groups))) {
        group <- dataset[groups == i,]
        average <- c(colMeans(group), nrow(group));
        aggdata <- rbind(aggdata, average);
    }
    names(aggdata) <- c(names(dataset), "Size");
    cat(capture.output(aggdata), sep = "\n");
}