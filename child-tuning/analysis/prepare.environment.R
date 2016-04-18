# Parameters
harmonic = "1F1"
p_thresh = .0005
plot_titles = TRUE
condition = "Direction" # {"Direction", "Coherence"}
study = "MOFO"
group = "child"
dpi = 300
n_top = 9

# Paths to data
analysis_path <- 'child-tuning/analysis/'
data_path <- paste(analysis_path, 'data/', sep="")
figs_path <- 'child-tuning/figs/'

data_fn <- "child-mofo-all.csv"
egi_fn <- "egi.csv"
topo_fn <- "topoplog.png"

fn_path <- paste(data_path, data_fn, sep="")
egi_path <- paste(data_path, egi_fn, sep="")
topo_path <- paste(figs_path, "topoplot.png", sep="")

# Source R scripts.
#file.sources <- list.files(path=analysis_path, pattern="*.R$", full.names = TRUE)
#sapply(file.sources, source, .GlobalEnv)

# Load libraries
library(ggplot2)
library(dplyr)
library(png)
library(gridExtra)
library(tidyr)
library(knitr)
library(DescTools)
library(heplots) # for etasq()
# library(ez)
library(Cairo)

# Condition indices
direction_conds <- c(1,2,3,6,7,8)
coherence.conds <- c(4,9)
fig.only.conds <- c(5,10)
