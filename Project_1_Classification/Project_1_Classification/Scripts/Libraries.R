UsePackage <- function(p) {
    if (!is.element(p, installed.packages()[, 1]))
        install.packages(p)
    require(p, character.only = TRUE)
}

UsePackage("tree");

# used for svm
UsePackage("e1071");

# used for createFolds
UsePackage("caret");