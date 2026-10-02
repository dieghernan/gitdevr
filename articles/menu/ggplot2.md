# ggplot2 example

This is an example of a **ggplot2** plot.

``` r

library(ggplot2)

# Count rows or sums of weights.
g <- ggplot(mpg, aes(class))
# Number of cars in each class.
g + geom_bar()
```

![Bar chart of vehicle counts by class in the mpg dataset. Vehicle class
is on the horizontal axis and count is on the vertical axis. SUVs are
the most common class, with 62 vehicles, while two-seaters are the least
common, with 5. ](ggplot2_files/figure-html/setup-1.png)

A ggplot2 image
