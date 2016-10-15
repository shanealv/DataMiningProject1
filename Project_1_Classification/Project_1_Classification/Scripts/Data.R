# Other Configuration ---
options(max.print = 230);

# Load Data Sets ---
mushrooms.table <- read.table("Data/agaricus-lepiota.data", sep = ",");
mushrooms.size <- nrow(mushrooms.table);
mushrooms <- within(mushrooms.table, {edible = ifelse(V1 == 'e', 2, 1)});
mushrooms <- data.frame(mushrooms[,c(24,2:16, 18:23)]);
mushrooms.simplified <- data.frame(sapply(mushrooms, c))

yeast.table <- read.table("Data/yeast.data");
yeast.size <- nrow(yeast.table);
yeast <- within(yeast.table, { ME = ifelse(V10 == 'ME1' | V10 == 'ME2' | V10 == 'ME3', 2, 1) })
yeast <- data.frame(yeast[, c(11, 2:9)]);
yeast.simplified <- data.frame(sapply(yeast, c))