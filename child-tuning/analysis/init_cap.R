init_cap <- function(s) {
  if (nchar(s)) {
    paste(toupper(substr(s,1,1)), substr(s,2,nchar(s)), sep="")
  }
}