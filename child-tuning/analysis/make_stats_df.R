make_stats_df <- function(maov_summ, df_egi) {
  # Extract stats and assemble into data frame
  list_stats <- data.frame(t(sapply(maov_summ, extract_stats)))
  names(list_stats) <- rep( c("Direction", "Speed", "Dir_Spd"), 4)
  list_F <- list_stats[,1:3]
  list_dfNum <- list_stats[,4:6]
  list_dfDen <- list_stats[,7:9]
  list_dfp <- list_stats[,10:12]
  
  F_val <- data.frame(list_F) %>% gather(Effect, F_val, Direction:Dir_Spd)
  dfNum <- data.frame(list_dfNum) %>% gather(Effect, dfNum, Direction:Dir_Spd)
  dfDen <- data.frame(list_dfDen) %>% gather(Effect, dfDen, Direction:Dir_Spd)
  pvals <- data.frame(list_dfp) %>% gather(Pvals, pvals, Direction:Dir_Spd)
  
  df_stats <- data.frame(Chan = rep( 1:128, 3), 
                         Cond = rep(c("Direction", "Speed", "Dir_Spd"), 
                                    c(128, 128, 128)),
                         Fvals = F_val[,2],
                         FdfNum = dfNum[,2],
                         FdfDen = dfDen[,2],
                         Pvals = pvals[,2],
                         xpos=rep(df_egi$xpos,3),
                         ypos=rep(df_egi$ypos,3))
  
  # Cut pvals
  pvals_cuts = c(-.01,.0001, .0005, .001, .005, .01, .05, 1)
  pvals_lbls = c("<.0001","<.0005", "<.001", "<.005", "<.01", "<.05", "ns")
  
  # Create cuts based on p-value levels
  Pvals_cuts = cut( df_stats$Pvals, breaks=pvals_cuts, labels=pvals_lbls)
  Pvals_cuts = ordered( Pvals_cuts, levels = rev( pvals_lbls ) )
  df_stats$Pvals_cuts = Pvals_cuts
  
  # Change order of Conditions for plotting
  df_stats$Cond = ordered( df_stats$Cond, levels=c("Direction", "Speed", "Dir_Spd"))
  df_stats
}