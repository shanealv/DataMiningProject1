# Calculate the Precision, Recall, and F1-Measure of the data
FindPRF <- function(actual, pred) {
    # convert the values in the vectors binary 0 1
    actual = sapply(actual, c) - 1;
    predicted = sapply(pred, c) - 1;
    precision = sum(predicted & actual) / (sum(predicted & actual) + sum(predicted & !actual));
    recall = sum(predicted & actual) / (sum(predicted & actual) + sum(!predicted & actual));
    fMeasure = 2 * precision * recall / (precision + recall);
    return(c(precision, recall, fMeasure));
}

# Print a prf tuple
PrintPRF <- function(prf) {
    cat("Precision: ", prf[1], "\n",
        "Recall:    ", prf[2], "\n",
        "F1:        ", prf[3], "\n", sep = "");
}

# Create a model and output statistics ----
TrainAndTest <- function(formula, data, alpha, method) {
    size = nrow(data);
    split = sample(seq_len(size), size = floor(alpha * size));
    train = data[split,];
    test = data[ - split,];
    if (method == 'tree') {
        model <- tree(formula, train);
        plot(model);
        text(model);
    }
    else if (method == 'svm') {
        model <- svm(formula, train, scale = FALSE);
    }
    pred <- predict(model, test, type = 'class');
    prf <- FindPRF(test[[1]], pred);
    PrintPRF(prf);
}

# Create a model and output statistics ----
CrossValidate <- function(formula, data, method) {
    bins = rep(1:10, nrow(data) / 10 + 1)[1:nrow(data)];
    #folds <- createFolds(mushrooms$V1, 10, FALSE)
    segs = split(data, bins);
    p <- 1:10;
    r <- 1:10;
    f <- 1:10;

    for (index in 1:10) {
        test <- segs[[index]];
        all <- rbind(data, test);
        train <- all[!duplicated(all, fromLast = FALSE) & !duplicated(all, fromLast = TRUE),];
        if (method == 'tree') {
            model <- tree(formula, train);
        }
        else if (method == 'svm') {
            model <- svm(formula, train, scale = FALSE);
        }
        else return;
        pred <- predict(model, test, type = 'class');
        prf <- FindPRF(test[[1]], pred);
        p[index] = prf[1];
        r[index] = prf[2];
        f[index] = prf[3];
    }

    PrintPRF(c(mean(p), mean(r), mean(f)));
}