compute_chan_effects <- function(df, harm, form){
  # Computes channel-wise MANOVA across channels given harmonic and model formula
  maov_list = lapply(unique(df$Channel), manova_channel, df, harm, form)
  maov_summ = lapply(maov_list, summary)
}
