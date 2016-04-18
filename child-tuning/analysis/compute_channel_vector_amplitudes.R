compute_channel_vector_amplitudes <- function(df_chan_stats, df_all, this_harm, cond, p_thresh) {
  
  chans_below <- select_chans_below(df_chan_stats, cond, p_thresh)

  if (length(chans_below) > 0) {
  
  # Calculate within participant, then across participant vector means & ampl.
  # This is calculated from full moco dataset.
  # Have to use standard eval commands for dplyr, e.g., group_by_() and quote()
  
  # Within participants...
  df_below_thresh <- df_all %>%
    filter(Channel %in% chans_below, Harm == this_harm) %>%
    group_by_(quote(Channel), cond, quote(iSess)) %>%
    summarise(sr.sub.mean=mean(Sr), 
              si.sub.mean=mean(Si),
              rms.amp.sub=sqrt(sr.sub.mean^2+si.sub.mean^2)) %>%
  # Average across participants  
    group_by_(quote(Channel), cond) %>%
    summarise(sr.group.mean=mean(sr.sub.mean),
              si.group.mean=mean(si.sub.mean),
              sr.group.sd=sd(sr.sub.mean),
              si.group.sd=sd(si.sub.mean),
              rms.amp=sqrt(sr.group.mean^2 + si.group.mean^2),
              rms.amp.sem = mean(rms.amp.sub)/sqrt(n()),
              nsubs=n(),
              sr.group.sem=mean(sr.sub.mean)/sqrt(n()),
              si.group.sem=mean(si.sub.mean)/sqrt(n())
    )
  }
}