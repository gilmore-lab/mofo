plot_complex_domain_results <- function(df_chan_stats, df_all, cond, this_group, this_harm, n_top=9, p_thresh, plot_titles) {
  
  df_complex_results <- compute_complex_domain_results(df_chan_stats, df_all, cond, this_harm, p_thresh)
  
  if (!(is.null(df_complex_results))) {
    # Calculate top amplitude results for plotting
    df_top <- df_complex_results %>%
      mutate(amp=sqrt(sr.mean^2+si.mean^2)) %>%
      group_by(Channel) %>%
      summarise(amp.sum = sum(amp)) %>%
      arrange(desc(amp.sum))
    top_chans <- df_top$Channel[1:n_top]
      
    # Complex domain plot theme
    pl_theme_vect_all <- theme(plot.title = element_text(lineheight=.8, face ="bold", vjust=2, size=20),
                               axis.title.x=element_text(vjust=-.6, size=rel(1.5)),
                               axis.title.y=element_text(face="bold",vjust=1, size=rel(1.5)),
                               axis.text=element_text(color="black", size=rel(.5)),
                               legend.title=element_blank(),
                               legend.text=element_text(size=rel(1.25)),
                               legend.background=element_blank(),
                               legend.position="bottom",
                               legend.title = element_blank(),
                               strip.text = element_text(size = rel(1.35)))
    
    # Calculate max amplitude for plot
    amp.max <- with( df_complex_results, max(c(max(abs(si.mean)+abs(si.sem)), max(abs(sr.mean)+abs(sr.sem)))))

    pl_title <- paste(init_cap(this_group), " Group:\nChannels Meeting Criterion for ", cond, " at ", this_harm, sep="")
    
    # Plot
    pl <- df_complex_results %>%
      filter(Channel %in% top_chans) %>%
      ggplot() +
      aes_string(x="sr.mean", y="si.mean", color=cond ) +
      geom_point() +
      geom_segment(aes( xend=0, yend=0, x=sr.mean, y=si.mean)) +
      geom_pointrange(aes(ymin=si.mean-si.sem, ymax=si.mean+si.sem)) +
      geom_errorbarh( aes(xmin=sr.mean-sr.sem, xmax=sr.mean+sr.sem), height=0) +
      coord_fixed( ratio=1 ) +
      scale_x_continuous(limits = c(-amp.max,amp.max)) +
      scale_y_continuous(limits = c(-amp.max,amp.max)) +
      xlab( expression(paste("Signal Real (", mu, "V)", sep=""))) +
      ylab( expression(paste("Signal Imaginary (", mu, "V)", sep=""))) +
      facet_wrap(facets= ~ Channel, scales="fixed", ncol = 3) +
      pl_theme_vect_all
    
    if (plot_titles) {
      pl + ggtitle(pl_title)
    } else {
      pl      
    }

  } else {
    cat('No data to plot for ', cond, '.\n', sep="")
  }
}
