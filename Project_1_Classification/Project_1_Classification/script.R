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
    cat("Precision:\t", precision, "\nRecall:\t\t", recall, "\nF1:\t\t\t", fMeasure, "\n");
}

CrossValidate <- function(test, k) {

}

# Load Libraries ---
UsePackage("tree");
UsePackage("e1071"); # used for svm

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
mushrooms.tree <- tree(V1 ~ ., data = mushrooms.train);
mushrooms.tree.pred <- predict(mushrooms.tree, mushrooms.test, type = 'class');
FindPRF(mushrooms.test[, 1], mushrooms.tree.pred);

# Create a support vector machine for Mushroom Data and test it
mushrooms.svm <- svm(V1 ~ ., data.frame(sapply(mushrooms.train, c)), scale = FALSE);
mushrooms.svm.pred <- predict(mushrooms.svm, data.frame(sapply(mushrooms.test, c)), type = 'class');
FindPRF(mushrooms.test[, 1], mushrooms.svm.pred);

# Plot the tree
plot(mushrooms.tree);
text(mushrooms.tree);
