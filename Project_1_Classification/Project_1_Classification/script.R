# Load External Scripts
source("Scripts/Libraries.R");
source("Scripts/Functions.R");
source("Scripts/Data.R");

# Create tree for Mushroom Data and test it
set.seed(2079345);
TrainAndTest(V1 ~ ., mushrooms, 0.75, 'tree');
CrossValidate(V1 ~ ., mushrooms, 'tree');

# Create a support vector machine for Mushroom Data and test it
set.seed(2079345);
TrainAndTest(V1 ~ ., mushrooms.simplified, 0.75, 'svm');
CrossValidate(V1 ~ ., mushrooms.simplified, 'svm');
