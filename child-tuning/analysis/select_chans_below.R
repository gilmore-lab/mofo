select_chans_below <- function(df_chan_stats, cond, p_thresh) {
  df_chans_below <- df_chan_stats %>% 
    filter(Cond == cond, Pvals < p_thresh) %>%
    select(Chan) %>%
    unique()
  df_chans_below$Chan
}