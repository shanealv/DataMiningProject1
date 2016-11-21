# Other Configuration ---
#options(max.print = 230);

# Load Data Sets ----
#https://archive.ics.uci.edu/ml/datasets/Thoracic+Surgery+Data
surgeries.table <- read.arff("Data/thoraricsurgery.arff");
surgeries.size <- nrow(surgeries.table);
surgeries = data.frame(sapply(surgeries.table, c));
surgeries = within(surgeries, AGEGROUP <- AGE / 10)
surgeries = surgeries[, -16]
surgeries = within(surgeries, NPRE5 <- PRE5 / 10);
surgeries = surgeries[, -3]

#https://www.kaggle.com/uciml/default-of-credit-card-clients-dataset
creditCards.table <- read.csv("Data/UCI_Credit_Card.csv");
creditCards.size <- nrow(creditCards.table);
creditCards <- data.frame(creditCards.table[, -1]);
creditCards = within(creditCards, NLIMIT_BAL <- LIMIT_BAL / 100000)
creditCards = within(creditCards, NAGE <- AGE / 10)
creditCards = within(creditCards, BAMT1 <- (BILL_AMT1 - BILL_AMT1 %% 1000) / 100000)
creditCards = within(creditCards, BAMT2 <- (BILL_AMT2 - BILL_AMT2 %% 1000) / 100000)
creditCards = within(creditCards, BAMT3 <- (BILL_AMT3 - BILL_AMT3 %% 1000) / 100000)
creditCards = within(creditCards, BAMT4 <- (BILL_AMT4 - BILL_AMT4 %% 1000) / 100000)
creditCards = within(creditCards, BAMT5 <- (BILL_AMT5 - BILL_AMT5 %% 1000) / 100000)
creditCards = within(creditCards, BAMT6 <- (BILL_AMT6 - BILL_AMT6 %% 1000) / 100000)
creditCards = within(creditCards, PAMT1 <- (PAY_AMT1  - PAY_AMT1  %% 1000) / 100000)
creditCards = within(creditCards, PAMT2 <- (PAY_AMT2  - PAY_AMT2  %% 1000) / 100000)
creditCards = within(creditCards, PAMT3 <- (PAY_AMT3  - PAY_AMT3  %% 1000) / 100000)
creditCards = within(creditCards, PAMT4 <- (PAY_AMT4  - PAY_AMT4  %% 1000) / 100000)
creditCards = within(creditCards, PAMT5 <- (PAY_AMT5  - PAY_AMT5  %% 1000) / 100000)
creditCards = within(creditCards, PAMT6 <- (PAY_AMT6  - PAY_AMT6  %% 1000) / 100000)
creditCards <- creditCards[, - c(1, 5, 12:23)]
head(creditCards)