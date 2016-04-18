make.agg.df <- function(data.dir = "child-tuning/analysis/data/csv-bysession"){
  source("child-tuning/analysis/make.mofo.df.R")
  files <- list.files(path = data.dir, pattern="*.csv$", full.names = TRUE)
  df.list <- lapply(X = files, FUN = make.mofo.df)
  df.agg <- Reduce(function(x,y) merge(x,y, all=TRUE), df.list)
  write.csv(x = df.agg, file = "child-tuning/analysis/data/child-mofo-all.csv", row.names=FALSE)
  return(df.agg)
}