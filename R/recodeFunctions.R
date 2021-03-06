#### Some simple and stupid functions to help with recoding

### Load required library just in case it hasn't already been loaded
library("plyr", character.only = TRUE)

### Set default missing values to NA
SetMissing <- function(x = NULL, values = NULL, addToDefault = FALSE) {
    if (!is.null(x)) {
        if (is.factor(x) || is.character(x)) {
            defaults <- c("Refusal", " ", "Don't know", "Implausible/ suspected wrong",
                          "Not applicable", "")
            if (is.null(values)) {
                values <- defaults
            }
            if (addToDefault) {
                values <- c(values, defaults)
            }
        }

        if (is.numeric(x)) {
            defaults <- c(-9:-1)
            if (is.null(values)) {
                values <- defaults
            }
            if (addToDefault) {
                values <- c(values, defaults)
            }
        }

        ret <- x
        ret <- mapvalues(ret, from = values,
                         to = rep(NA, length(values)))
        return(ret)
    } else {
        return(x)
    }
}

### Get the mode of a vector
### Only returns 1 value even when multiple modes
### Code taken from https://stackoverflow.com/a/8189441
GetMode <- function(x = NULL) {
    if (all(is.na(x))) {
        return(NA)
    } else {
        ux <- unique(x)

        if (length(ux) == 1) {
            return(ux)
        } else {
            res <- ux[which.max(tabulate(
                match(x, ux, incomparables = NA)))]
            return(res)
        }
    }
}

### Convert a factor to a numeric vector (approx.)
factorToNumeric <- function(x = NULL) {
    if (is.factor(x)) {
        ret <- x
        ret <- as.numeric(levels(x)[x])
        return(ret)
    } else {
        return(x)
    }
}

### Function that gives out computed means per individual with each value being
### repeated the same amount of times as the length of the argument
RepMean <- function(x = NULL) {
    if (all(is.na(x))) {
        return(rep(NA, length(x)))
    } else {
        return(rep(mean(x, na.rm = TRUE), length(x)))
    }
}

### Function to make sure tapply results list is in the same order as the INDEX
### column -- mergeid -- in the data frame
tapplySaferUnlist <- function(tapplyList = NULL, dfIndex = NULL) {
    stopifnot(is.list(tapplyList))
    dfIndex <- dfIndex
    res <- tapplyList
    tapplyListNames <- names(tapplyList)

    ## For each level of index vector -- that is each name in the tapply list --
    ## find the indices of that level in the data frame
    levelPosList <- match(dfIndex, tapplyListNames)

    res <- unlist(tapplyList[levelPosList])

    res
}

### A few useful functions as some of the variables used to construct the ACE
### and HACE indices are age-dependent

IsEventAtAge <- function(x = NULL, birthVar = NULL,
                         ub = NULL, lb = 0) {
    ageAtEvent <- x - birthVar
    ret <- rep(NA, length(x))
    ret[which(ageAtEvent >= lb & ageAtEvent <= ub)] <- 1L
    ret[which(ageAtEvent < lb | ageAtEvent > ub)] <- 0L

    ret
}
