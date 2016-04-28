plot_channel_magnitudes <- function(df_chan_stats, df_all, this_group, this_harm, cond, p_thresh, plot_titles) {
  
  df_plot <- compute_channel_vector_amplitudes(df_chan_stats, df_all, this_harm, cond, p_thresh)
  
  if (!(is.null(df_plot))) {
    # Prepare to plot
    limits <- aes(ymax = rms.amp + rms.amp.sem, ymin = rms.amp)
    dodge <- position_dodge(width=0.8)
    pl_title <- paste(init_cap(this_group), " Group:\nChannels Meeting Criterion for ", cond, " at ", this_harm, sep="")
    
    pl_theme_bar <- theme(plot.title = element_text(lineheight=.8, face ="bold", vjust=2, size = rel(1.5)),
                          panel.background = element_rect(fill=NA),
                          panel.grid.major = element_blank(),
                          panel.grid.minor = element_blank(),
                          panel.border = element_rect(fill=NA,color="black", size=.8,
                                                      linetype="solid"),
                          axis.title.x=element_text(vjust=-.6, size=rel(1.25)),
                          axis.title.y=element_text(face="bold",vjust=1, size=rel(1.25)),
                          axis.text=element_text(color="black", size=rel(1), angle=90),
                          legend.title=element_blank(),
                          legend.text=element_text(size=rel(1.5)), 
                          legend.position="bottom",
                          legend.background=element_blank())
    
    pl <- ggplot(df_plot) +
      aes_string(x="as.factor(Channel)", y="rms.amp", fill=cond) + 
      geom_bar(stat="identity", width=0.8, position=dodge) +
      geom_errorbar(limits, position=dodge, width=0.15) +
      xlab("Channel") +
      ylab(expression(paste("RMS amplitude (", mu, "V)", sep=""))) +
      pl_theme_bar
    
    if (plot_titles) {
      pl + ggtitle(pl_title)     
    } else {
      pl
    }

  } else {
    cat('No data to plot for ', cond, '.\n', sep="")
  }
}