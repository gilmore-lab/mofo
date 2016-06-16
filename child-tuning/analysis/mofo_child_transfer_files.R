# Make directories on target location (GitHub:/Users/ars17/GitHub/mofo/child-tuning) 
# containing only the needed files from the source location 
# (Box: /Users/ars17/Box Sync/b-gilmore-lab-group Shared/gilmore-lab/projects/optic-flow/optic-flow-eeg/mofo/mofo-child-tuning/sessions).
#
# Created: 1/26/2016
# Author: Andrea Seisler

# Notes: to clear the workspace use > rm(list = ls())

# Lists just the folder names in the source directory (Box)

box.dir = "~/Box Sync/b-gilmore-lab-group Shared/gilmore-lab/projects/optic-flow/optic-flow-eeg/mofo/mofo-child-tuning/sessions"
folder.names = list.dirs(box.dir, full.names = FALSE, recursive=FALSE)


# Create a new directory for each of the folder names above in the target directory (GitHub)

git.dir = "~/GitHub/mofo/child-tuning/Thresh100"

for (i in 1:length(folder.names))  { 
  dir.create(file.path(git.dir,folder.names[i]))
} 


# Copy all .INI and .txt files from the source directory (Box) to their respective 
# folders at the target directory locatin (GitHub)

# create a vector of source file paths

box.dir <- rep(box.dir,length(folder.names)) 
sourcepath <- file.path(box.dir,folder.names, "ThreshBlink100")


# create a vector of target file paths

targetpath <- rep(git.dir,length(folder.names))
targetpath <- file.path(targetpath,folder.names)


# select only the files that need to be copied

files2copy <- list.files(sourcepath[1], pattern = ".txt|.INI", full.names = FALSE)


# copy the necessary files from the source directories to the target directories

lapply(files2copy, function(x) file.copy(paste (sourcepath, x , sep = "/"),  
                                         paste (targetpath, x, sep = "/"), recursive = FALSE,  copy.mode = TRUE))