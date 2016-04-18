make_ears_nose_overlay <- function(topoplot_fullpath) {
  topo_ears_nose <- rasterGrob(readPNG(topoplot_fullpath), interpolate=TRUE)
}