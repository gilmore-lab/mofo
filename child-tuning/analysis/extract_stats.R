#'Error: Within.stats17' denominator df for Direction
#'Error: Within.stats18' denominator df for Speed
#'Error: Within.stats19' denominator df for Dir*Spd
#'Error: Within.stats13' num df for Direction
#'Error: Within.stats14' num df for Speed
#'Error: Within.stats15' num df for Dir*Spd
#'Error: Within.stats9'  F for Direction
#'Error: Within.stats10' F for Speed
#'Error: Within.stats11' F for Dir*Spd
#'Error: Within.stats21' p for Direction
#'Error: Within.stats22' p for Speed
#'Error: Within.stats23' p for Dir*Spd
extract_stats <- function(model_list) {
  ml = unlist(model_list)
  new_vals <- as.numeric( c( ml['Error: Within.stats9'], 
                             ml['Error: Within.stats10'], 
                             ml['Error: Within.stats11'], 
                             ml['Error: Within.stats13'], 
                             ml['Error: Within.stats14'], 
                             ml['Error: Within.stats15'],
                             ml['Error: Within.stats17'], 
                             ml['Error: Within.stats18'], 
                             ml['Error: Within.stats19'], 
                             ml['Error: Within.stats21'], 
                             ml['Error: Within.stats22'], 
                             ml['Error: Within.stats23']) )
  names(new_vals) <- c("F-Direction", "F-Speed", "F-Dir*Spd", "df-Direction", "df-Speed", "df-Dir*Spd", "df-Direction-denom", "df-Speed-denom", "df-Dir*Spd-denom", "p-Direction", "p-Speed", "p-Dir*Spd")
  rbind(new_vals)
}
