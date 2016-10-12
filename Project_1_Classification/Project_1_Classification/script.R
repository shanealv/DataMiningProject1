# source("script.R")
# Load Libraries ---
usePackage <- function(p) {
    if (!is.element(p, installed.packages()[, 1]))
        install.packages(p)
    library(p, character.only = TRUE)
}
usePackage("tree");

# Load Data Sets ---
mushrooms <- read.table("Data/agaricus-lepiota.data", sep = ",");
names(mushrooms) <- c("Class", "CS", "CC", "B", "O", "GA", "GSp", "GSi", "GC", "SS", "SR", "SSuAR", "SSuBr", "SCAR", "SCBR", "VT", "VC", "RN", "RT", "SPC", "P", "H");
mushrooms.class <- mushrooms[[1]]
set.seed(123);
mushrooms.size <- nrow(mushrooms);
mushrooms.train_idx <- sample(seq_len(mushrooms.size), size = floor(0.75 * mushrooms.size));
mushrooms.test_idx <- -mushrooms.train_idx;
mushrooms.train <- mushrooms[mushrooms.train_idx,];
mushrooms.test <- mushrooms[mushrooms.test_idx,];
mushrooms.testclass <- mushrooms.class[mushrooms.test_idx];


# Other Configuration ---
options(max.print = 230);

# Create tree for Mushroom Data ---
mushrooms.tree <- tree(Class ~ CS + CC + B + O + GA + GSp + GSi + GC + SS + SR + SSuAR + SSuBr + SCAR + SCBR + VT + VC + RN + RT + SPC + P + H, data = mushrooms.train);

# Plot the tree
plot(mushrooms.tree);
text(mushrooms.tree, pretty = 0);

# Check how the model is doing using the test data
mushrooms.tree.pred <- predict(mushrooms.tree, mushrooms.test, type = 'class');
mean(mushrooms.tree.pred != mushrooms.testclass);


# Perform Cross Validation
set.seed(123);
