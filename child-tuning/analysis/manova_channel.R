manova_channel <- function(ch, df, harm, form){
  # Computes MANOVA for channel
  df <- df %>%
    filter(Channel == ch, Harm == harm)
  manova(formula = form, data=df)
}