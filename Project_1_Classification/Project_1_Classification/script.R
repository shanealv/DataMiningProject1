# source("script.R")
# Utility Functions ----
UsePackage <- function(p) {
    if (!is.element(p, installed.packages()[, 1]))
        install.packages(p)
    require(p, character.only = TRUE)
}

FindPRF <- function(actual, pred) {
    # convert the values in the vectors binary 0 1
    actual = sapply(actual, c) - 1;
    predicted = sapply(pred, c) - 1;
    precision = sum(predicted & actual) / (sum(predicted & actual) + sum(predicted & !actual));
    recall = sum(predicted & actual) / (sum(predicted & actual) + sum(!predicted & actual));
    fMeasure = 2 * precision * recall / (precision + recall);
    return(c(precision, recall, fMeasure));
}

PrintPRF <- function(prf) {
    cat("Precision:\t", prf[1], "\nRecall:\t\t", prf[2], "\nF1:\t\t\t", prf[3], "\n");
}

CrossValidateTree <- function(formula, data) {
    bins = rep(1:10, nrow(data) / 10 + 1)[1:nrow(data)];
    #folds <- createFolds(mushrooms$V1, 10, FALSE)
    segs = split(data, bins);
    p <- 1:10;
    r <- 1:10;
    f <- 1:10;

    for (index in 1:10) {
        test <- segs[[index]];
        all <- rbind(data, test);
        train <- all[!duplicated(all, fromLast = FALSE) & !duplicated(all, fromLast = TRUE),];
        tree <- tree(formula, data);
        pred <- predict(tree, test, type = 'class');
        prf <- FindPRF(test[[1]], pred);
        p[index] = prf[1];
        r[index] = prf[2];
        f[index] = prf[3];
    }

    return(c(mean(p),mean(r),mean(f)));
}

# Load Libraries ---
UsePackage("tree");
# used for svm
UsePackage("e1071");
# used for createFolds
UsePackage("caret");

# Other Configuration ---
options(max.print = 230);
# Load Data Sets ---
mushrooms.table <- read.table("Data/agaricus-lepiota.data", sep = ",");
mushrooms.size <- nrow(mushrooms.table);
mushrooms <- data.frame(mushrooms.table);

# Create a Model
set.seed(2079345);
mushrooms.split <- sample(seq_len(mushrooms.size), size = floor(0.75 * mushrooms.size));
mushrooms.train <- mushrooms[mushrooms.split,];
mushrooms.test <- mushrooms[ - mushrooms.split,];

set.seed(2079345);
# Create tree for Mushroom Data and test it
mushrooms.tree <- tree(V1 ~ ., mushrooms.train);
mushrooms.tree.pred <- predict(mushrooms.tree, mushrooms.test, type = 'class');
mushrooms.tree.prf = FindPRF(mushrooms.test[, 1], mushrooms.tree.pred);
PrintPRF(mushrooms.tree.prf);

# Create a support vector machine for Mushroom Data and test it
mushrooms.svm <- svm(V1 ~ ., data.frame(sapply(mushrooms.train, c)), scale = FALSE);
mushrooms.svm.pred <- predict(mushrooms.svm, data.frame(sapply(mushrooms.test, c)), type = 'class');
mushrooms.svm.prf = FindPRF(mushrooms.test[, 1], mushrooms.svm.pred);
PrintPRF(mushrooms.svm.prf);

# Plot the tree
plot(mushrooms.tree);
text(mushrooms.tree);
