mofo_render_all <- function(plot_hires = FALSE, p_thresh = .0005, n_top = 9) {
# mofo_render_all <- function(plot_hires = FALSE, p_thresh = .0005, n_top = 9)
# Renders all .Rmd files
  
  figs_path <- "figs/"
  
  # Source dependencies
  source("analysis/make_egi_channel_plot.R")
  
  # Change dpi, plot_dev, and plot_titles depending on plot resolution
  if (plot_hires){
    dpi = 300
    plot_dev = 'quartz_tiff'
    plot_titles = FALSE
    plot_ext = ".tiff"
  } else {
    dpi = 72
    plot_dev = 'png'
    plot_titles = FALSE
    plot_ext = ".png"
  }
  
  myfn = "child-motion-form-direction.Rmd"

  # Create moco_render function
  mofo_render <- function(fn=myfn, group="child", condition="direction", harmonic="1F1") {
    rmarkdown::render(fn, 
                      output_file=paste('html/', paste(group, condition, harmonic, 'html', sep="."), sep=''),
                      params=list(group=group,
                                  condition=condition, 
                                  harmonic=harmonic, 
                                  dpi=dpi, 
                                  plot_dev=plot_dev, 
                                  p_thresh = p_thresh, 
                                  n_top = n_top,
                                  plot_titles = plot_titles)
    )
  }
  
  # Apply it to child and adult groups
  mapply(mofo_render, group="child", condition="direction", harmonic=list("1F1", "2F1", "3F1", "1F2"))
 
#   # Print EGI channel figure, too
  rmarkdown::render("make-egi-channel-plot.Rmd",
                    output_file = 'html/egi-channel-plot.html',
                    params = list(dpi=dpi, plot_dev=plot_dev))
  
  ggsave(filename = paste(figs_path, "egi-channel-plot", plot_ext, sep=""), dpi = dpi, device = plot_dev)
}

