# Load Libraries ---
library("rpart")

# Load Data Sets ---
mushrooms.table <- read.table("Data/agaricus-lepiota.data", sep = ",");
names(mushrooms.table) <- c("Class", "CS", "CC", "B", "O", "GA", "GSp", "GSi", "GC", "SS", "SR", "SSuAR", "SSuBr", "SCAR", "SCBR", "VT", "VC", "RN", "RT", "SPC", "P", "H");
mushrooms.classlabel <- mushrooms.table[, 1];
mushrooms.data <- mushrooms.table[, -1];
set.seed(123);
mushrooms.size <- nrow(mushrooms.table);
mushrooms.train_index <- sample(seq_len(mushrooms.size), size = floor(0.75 * mushrooms.size));
mushrooms.training <- mushrooms.table[mushrooms.train_index,];
mushrooms.test <- mushrooms.table[ - mushrooms.train_index,];

# Other Configuration ---
options(max.print = 230);

# Rpart on Mushroom Data ---
mushrooms.dtModel <- rpart(Class ~ CS+CC+B+O+GA+GSp+GSi+GC+SS+SR+SSuAR+SSuBr+SCAR+SCBR+VT+VC+RN+RT+SPC+P+H, data = mushrooms.table);
plot.rpart(mushrooms.dtModel);
