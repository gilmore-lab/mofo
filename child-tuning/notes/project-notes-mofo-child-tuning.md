# Child Motion Form (MOFO) Project Notes

This is the project notes file for the MOFO child tuning project.

## 2016-05-03-07:44

- Rick updated and submitted the [SfN-16](../pubs/sfn-16-abstract.md).

## 2016-04-28-10:34

- Rick created a new .Rmd file with parameters to render figures for the direction condition (child-motion-form-direction.Rmd). Sourcing "mofo_render_all.R" then running mofo_render_all() generates .html files in html/ for harmonics 1F1, 2F1, 3F1, and 1F2, respectively. Rick also deleted the RStudio project file in mofo/ and created a new one in mofo/child-tuning.
- Remaining work needs to be done to modify the child-motion-form-direction.Rmd file and associated .R scripts to work with the coherence and figure-only conditions.

## 2016-04-27-11:19

- Andrea created .jpg images of the stimuli using OmniGraffle. They are located in the [figs directory](../figs/). I believe the only one that I have a question about is the coh100 image. Do we need the inbetween images where the dots are moving randomly?

## 2016-04-18-15:24

- From weekly meeting and Rick's work.
- Rick accidentally lost all of this morning's work, so he had to regenerate it all.
- There are a set of new .R functions in the analysis directory. Sourcing [plot.figs.R](../analysis/plot.figs.R) should generate all of the plots and data.
- Rick saved a draft abstract from a prior SfN submission to [../pubs/sfn-16-abstract.txt](../pubs/sfn-16-abstract.txt). We should use this and the information in [mofo-child-tuning-parameters.md](mofo-child-tuning-parameters.md) to revise the draft abstract. We will determine authorship later.

## 2016-04-11-11:40

- Weekly, Rick, Andrea, Daved, Michael
- Created make.agg.df.R and make.mofo.df.R functions to create aggregate and single dataframes from CSV files.
- Exported child-mofo-all.csv, but won't push this to GitHub b/c too big.
- Noticed that we don't have density and coherence values in data files or dataframe. Put text in mofo-RLS-file-convert.R to show how this may be done using iCond as an index.
- Talked about ANOVA.

## 2016-03-28-11:36

- weekly project meeting.
  - Check with Andrea about static images. (M & D will check on status)
  - Still need to set-up videos. (Schedule with A)
  - Need to de-identify data files and think about sharing strategy.
  - Develop visualization code.
- Created draft README.md for data file (../analysis/data/README.md)
- Daved created a commit 
- Worked on MD's connection. Worked via GitHub app. Now testing RStudio.

## 2016-03-21-11:18

- weekly project meeting.
- AGENDA
  - Review status of stimulus/condition descriptions and images.
      - Check with Andrea about status of schematic images.
      - Need to add schematic images to notes folder and text-based descriptions of the conditions.
      - Plan to capture videos using GoPro of all conditions and upload to Databrary.
  - Discuss data analysis plan.
      - Update RStudio or install, <https://www.rstudio.com/>
      - Check to see if git installed. From Mac OS X Terminal, enter 'which git', if installed, you should have '/usr/bin/git' as response.
      - Could install GitHub desktop for Mac or Windows, <https://desktop.github.com/>
      - 
  - Discuss Databrary sharing plan.
      - Daved and Michael will register for Databrary.
  <http://databrary.org/register>
      - Check with Andrea about Databrary sharing status.
      - Design and complete participant data entry into spreadsheet.
  - Discuss Psychopy-based display code; videos of display conditions.
  - GOAL: SfN submission deadline is **May 5**, <https://www.sfn.org/annual-meeting/neuroscience-2016/dates-and-deadlines>
      - Abstract guidelines: <https://www.sfn.org/annual-meeting/neuroscience-2016/abstracts/call-for-abstracts/submission-instructions>
      - Michael will investigate dynamic poster option.

## 2016-03-17
- updated [mofo-child-tuning-parameters.md](https://github.com/gilmore-lab/mofo/blob/master/child-tuning/mofo-child-tuning-parameters.md) to include a short verbal description of all conditions, added speed in deg/s to chart, updated notes to include the names used in the merged datafile for each condition, and copied some text from Fesi et. al. 2011 to start forming a paragraph description of the stimuli. (ars)

## 2016-03-14
- finished hand drawing pictures of stimuli (ars)

## 2016-03-02

- rog refactored the repository to reflect the organization recommended in "Reproducible Research with R and RStudio" by Gandrud.
- exported all session files with 100 uV artifact threshold (Thresh100) to session-level CSV files. Session-level CSV files were renamed based on iSess (YYYY-MM-DD-HHMMSS.csv) value.

## 2016-02-12
- ars copied the script 'script-run-subfolders.R' into the child-tuning/R folder
  - this script is not complete

## 2016-02-08  

- Started to review the mofo-RLS-file-convert.R function and how it works  

- To do  
  - Look at displays and create a drawing and written description of each of the 10 conditions. (meet on 2016-02-10 @ 11:30)
  - Read Fesi JD, et. al. 2011 (10.1016/j.visres.2011.07.015) and 2014 (10.1016/j.visres.2014.04.004)

- mofo child tuning parameters located at gilmore-lab/mofo/child-tuning/[mofo-child-tuning-parameters.md](https://github.com/gilmore-lab/mofo/blob/master/child-tuning/mofo-child-tuning-parameters.md)


## 2015-12-17-11:17

-ars17 added the script 'mofo-RLS-file-convert' to the /R folder  
-ars17 copied script to Box '/Users/ars17/Box Sync/b-gilmore-lab-group Shared/gilmore-lab/projects/optic-flow/optic-flow-eeg/mofo/mofo-child-tuning/analysis/mofo-RLS-file-convert

## 2015-10-28-12:20

- ars17 added mofo-child-tuning-parameters.md which is a table listing the stimuli parameters used for this study.

## 2015-09-17-08:32

- rogilmore created this project notes file and pushed it to GitHub.
