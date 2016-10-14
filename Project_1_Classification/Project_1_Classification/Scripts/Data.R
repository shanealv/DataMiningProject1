# Other Configuration ---
options(max.print = 230);

# Load Data Sets ---
mushrooms.table <- read.table("Data/agaricus-lepiota.data", sep = ",");
mushrooms.size <- nrow(mushrooms.table);
mushrooms <- data.frame(mushrooms.table);
mushrooms.simplified <- data.frame(sapply(mushrooms, c))

yeast.table <- read.table("Data/yeast.data");
yeast.size <- nrow(yeast.table);
yeast <- data.frame(yeast.table[,c(10, 2:9)]);
yeast.simplified <- data.frame(sapply(yeast, c))