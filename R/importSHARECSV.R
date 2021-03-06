### If the CSV files were generated using Stata, then there is nothing to change

### If the CSV files were generated using SPSS the fileEncoding option
### of read.csv should be set to "UTF-8-BOM"

### It is assumed that these files are located in the ”data_raw” directory

rawList <- list.files(path = "../data_raw", pattern = "\\.csv")

for (file in rawList) {

    dfName <- gsub("\\.csv.*", "", file)
    dfName <- gsub("rel[[:digit:]]+-[[:digit:]]+-[[:digit:]]+_", "", dfName)

    assign(dfName,
           read.csv(file = paste("../data_raw", file, sep = "/"),
                    encoding = "UTF-8"))
}

### We then save each imported file into a separate RData file

## Get the list of all the data frames

dfs <- ls(pattern = "sharew")

for (df in dfs) {

    fName <- paste0("../data/", df, ".RData")

    save(list = df, file = fName)

}

## Clean up
rm(rawList, file, dfName, dfs, df, fName)
