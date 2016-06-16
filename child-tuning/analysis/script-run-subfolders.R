#run a script on multiple files in a folder
  parent.folder <- "~/InfantThresh200"
  sub.folders <- list.dirs(parent.folder, recursive=TRUE)
  r.scripts <- file.path(parent.folder, "general_extract.r")
  # Run scripts in sub-folders 
    for(i in sub.folders) {
        setwd(i)
        source(r.scripts)
      }
  
    #List all directories in file path
    list.dirs(path = ".", full.names = TRUE, pattern = , recursive = TRUE)
  
    # list a single directory
    list.dirs(".", recursive = FALSE)
  
    a1<-file.info(list.files("./.")) 
    mydir<-row.names(a1[a1$isdir==TRUE,]) 