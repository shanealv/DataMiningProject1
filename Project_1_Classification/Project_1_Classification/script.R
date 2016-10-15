# Load External Scripts
source("Scripts/Libraries.R");
source("Scripts/Functions.R");
source("Scripts/Data.R");

cat("Mushroom Data\n");
# Create tree for Mushroom Data and test it
cat("tree\n");
set.seed(2079345);
TrainAndTest(as.factor(edible) ~ ., mushrooms, 0.75, 'tree');
CrossValidate(as.factor(edible) ~ ., mushrooms, 'tree');

# Create a support vector machine for Mushroom Data and test it
cat("svm\n");
set.seed(2079345);
TrainAndTest(as.factor(edible) ~ ., mushrooms.simplified, 0.75, 'svm');
CrossValidate(as.factor(edible) ~ ., mushrooms.simplified, 'svm');

cat("Yeast Data\n");
# Create tree for Yeast Data and test it
cat("tree\n");
set.seed(2079345);
TrainAndTest(as.factor(ME) ~ ., yeast, 0.75, 'tree');
CrossValidate(as.factor(ME) ~ ., yeast, 'tree');

# Create a support vector machine for Yeast Data and test it
cat("svm\n");
set.seed(2079345);
TrainAndTest(as.factor(ME) ~ ., yeast.simplified, 0.75, 'svm');
CrossValidate(as.factor(ME) ~ ., yeast.simplified, 'svm');
