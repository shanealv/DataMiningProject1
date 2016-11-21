UsePackage <- function(p) {
    if (!is.element(p, installed.packages()[, 1]))
        install.packages(p)
    require(p, character.only = TRUE)
}

UsePackage("plyr");
UsePackage("readxl");
UsePackage("doParallel");


