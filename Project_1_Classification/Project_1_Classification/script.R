# source("script.R")
# Load Libraries ---
usePackage <- function(p) {
    if (!is.element(p, installed.packages()[, 1]))
        install.packages(p, dep = TRUE, lib = "lib")
    library(p, lib.loc = "lib")
}
usePackage("party");
#install.packages("party", lib = "lib")
#library("party", lib.loc = "lib")

# Load Data Sets ---
mushrooms.table <- read.table("Data/agaricus-lepiota.data", sep = ",");
names(mushrooms.table) <- c("Class", "CS", "CC", "B", "O", "GA", "GSp", "GSi", "GC", "SS", "SR", "SSuAR", "SSuBr", "SCAR", "SCBR", "VT", "VC", "RN", "RT", "SPC", "P", "H");
mushrooms.classlabel <- mushrooms.table[, 1];
mushrooms.data <- mushrooms.table[, -1];
set.seed(123);
mushrooms.size <- nrow(mushrooms.table);
mushrooms.train_index <- sample(seq_len(mushrooms.size), size = floor(0.75 * mushrooms.size));
mushrooms.training <- mushrooms.table[mushrooms.train_index,];
mushrooms.testing <- mushrooms.table[ - mushrooms.train_index,];

# Other Configuration ---
options(max.print = 230);

# Create tree for Mushroom Data ---
mushrooms.tree <- ctree(Class ~ CS + CC + B + O + GA + GSp + GSi + GC + SS + SR + SSuAR + SSuBr + SCAR + SCBR + VT + VC + RN + RT + SPC + P + H, data = mushrooms.training);
plot(mushrooms.tree);
