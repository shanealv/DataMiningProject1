# Load External Scripts
source("Scripts/Libraries.R");
source("Scripts/Functions.R");
source("Scripts/Data.R");


# Create a Model
set.seed(2079345);
mushrooms.split <- sample(seq_len(mushrooms.size), size = floor(0.75 * mushrooms.size));
mushrooms.train <- mushrooms[mushrooms.split,];
mushrooms.test <- mushrooms[ - mushrooms.split,];

# Create tree for Mushroom Data and test it
TrainAndTest(V1 ~ ., mushrooms, 0.75, 'tree');
CrossValidate(V1 ~ ., mushrooms, 'tree');
plot(mushrooms.tree);
text(mushrooms.tree);

# Create a support vector machine for Mushroom Data and test it
TrainAndTest(V1 ~ ., mushrooms.simplified, 0.75, 'svm');
CrossValidate(V1 ~ ., mushrooms.simplified, 'svm');
