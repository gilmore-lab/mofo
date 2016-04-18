compute_complex_domain_results <- function(df_chan_stats, df_all, cond, this_harm, p_thresh) {
  
  chans_below <- select_chans_below(df_chan_stats, cond, p_thresh)
  
  if (length(chans_below) > 0) {  
  df_complex_results <- df_all %>%
    filter( Channel %in% chans_below, Harm == this_harm ) %>%
    group_by_( quote(iSess), quote(Channel), cond ) %>%
    summarise( sr.mean.bysub=mean(Sr), 
               si.mean.bysub=mean(Si),
               sr.sem=sd(Sr)/sqrt(n()),
               si.sem=sd(Si)/sqrt(n())           
    ) %>%
    group_by_( quote(Channel), cond ) %>%
    summarise( sr.mean = mean( sr.mean.bysub ),
               si.mean = mean( si.mean.bysub ),
               sr.sem = sd(sr.mean.bysub)/sqrt(n()),
               si.sem = sd(si.mean.bysub)/sqrt(n())
    )
  }
}