






make_simple_scatterplot <- function(x){
  return (plot(x, ylim = c(-50, 50), col="orange"))
  }



make_ggplot_scatterplot <- function(x){
  ggplot() + 
    geom_point(
      aes(x = seq(length.out = length(x)), y = x),
      color = "steelblue",
      size = 2
    ) +
    ylim(-50, 50) +
    labs(title = "bla bla bli")
}