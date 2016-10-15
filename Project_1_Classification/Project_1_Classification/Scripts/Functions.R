# Calculate the Precision, Recall, and F1-Measure of the data
FindPRF <- function(actual, pred) {
    a <- c(actual) - 1;
    p <- c(pred) - 1;
    precision = sum(p & a) / (sum(p & a) + sum(p & !a));
    recall = sum(p & a) / (sum(p & a) + sum(!p & a));
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
        model <- svm(formula, train, scale = TRUE);
    }
    pred <- predict(model, test, type = 'class');
    prf <- FindPRF(test[[1]], pred);
    PrintPRF(prf);
}

# Create a model and output statistics ----
CrossValidate <- function(formula, data, method) {
    bins = rep(1:10, nrow(data) / 10 + 1)[1:nrow(data)];
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
            model <- svm(formula, train, scale = TRUE);
        }
        else return;
        pred <- predict(model, test);
        prf <- FindPRF(test[[1]], pred);
        p[index] = prf[1];
        r[index] = prf[2];
        f[index] = prf[3];
    }

    PrintPRF(c(mean(p), mean(r), mean(f)));
}