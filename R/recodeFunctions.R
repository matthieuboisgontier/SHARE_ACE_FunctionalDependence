#### Some simple and stupid functions to help with recoding

### Load required library just in case
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
        res <- ux[which.max(tabulate(match(x, ux)))]
        return(res)
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