plot_channel_effects <- function(df, harm, group, topoplot_fullpath, plot_titles) {
  yquiet = scale_y_continuous("", breaks=NULL)
  xquiet = scale_x_continuous("", breaks=NULL)
  
  # Plot theme for channel topo
  pl_theme_topo <- theme(plot.title = element_text(lineheight=.8, 
                                                   face ="bold", 
                                                   vjust=2, 
                                                   size=16),
                         legend.title=element_text(size=0),
                         legend.text=element_text(size=12, face="bold"),
                         legend.position="bottom"
  )
  
  pl_title <- paste(init_cap(group), " Group:\nChannel-wise Effects for ", harm, sep="" )
  
  # Plot
  pl <- ggplot(data=df, aes(x=xpos, 
                            y=ypos, 
                            color=Pvals_cuts, 
                            size=Pvals_cuts)) +
    geom_point() +
    facet_grid(facets = . ~ Cond) +
    coord_fixed() + 
    xquiet + 
    yquiet +
    pl_theme_topo
  
  # Add ears, nose
  topo_ears_nose <- make_ears_nose_overlay(topoplot_fullpath)
  pl + annotation_custom(topo_ears_nose, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)
  
  if (plot_titles) {
    pl + ggtitle(pl_title)
  } else {
    pl
  }
}
