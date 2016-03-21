# README
Rick Gilmore  
`r Sys.time()`  

## Motion Form (MOFO) Child Tuning

This is the repo for the Motion Form (MOFO) tuning study with child participants.

Last updated 2016-03-02 13:16:13.

## Contents

- *.bib, bibliography file
- *.Rmd, RMarkdown files for scripting various reports.
- [notes/](notes/)
    - [Project notes](notes/project-notes-mofo-child-tuning.md)
    - [Stimulus parameters](notes/mofo-child-tuning-parameters.md)
    - [How to transfer files from PowerBook to iMac](connect_PowerBook2iMac.md)
- [analysis/](analysis/)
    - [mofo-RLS-file-convert.R](analysis/mofo-RLS-file-convert.R), function to import, merge, and convert PowerDiva RLS, Session, and related files into CSVs.
    - [data/](analysis/data/)
        - [egi.csv](analysis/data/egi.csv), comma-delimited file with coordinates of EGI 128 channels.
        - [csv-bysession/](analysis/data/csv-bysession/) comma-delimited files of individual sessions.
        - [Thresh100-identifiable/](analysis/data/Thresh100/), individual testing sessions with identifiable data elements so not pushed to GitHub.

## Session Info

```r
sessionInfo()
```

```
## R version 3.2.3 (2015-12-10)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: OS X 10.10.5 (Yosemite)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] magrittr_1.5    formatR_1.2     tools_3.2.3     htmltools_0.2.6
##  [5] yaml_2.1.13     stringi_0.4-1   rmarkdown_0.9.5 knitr_1.12.3   
##  [9] stringr_1.0.0   digest_0.6.8    evaluate_0.8
```
