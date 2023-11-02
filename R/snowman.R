library(ggplot2)
library(ggforce)
library(sf)

# sky
s1 <- ggplot() +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "#0e1c2e")
  )
s1

# snow on ground
s2 <- s1 +
  annotate(
    geom = "rect", xmin = 0, xmax = 1, ymin = 0, ymax = 0.2,
    fill = "gray98", colour = "gray98", alpha = 1
  ) +
  xlim(0, 1) +
  ylim(0, 1) +
  coord_fixed(expand = FALSE)
s2

# add snowflakes
set.seed(20231225)
n <- 100
snowflakes <- data.frame(
  x = runif(n),
  y = runif(n)
)
s3 <- s2 +
  geom_point(
    data = snowflakes,
    mapping = aes(
      x = x,
      y = y
    ),
    colour = "white",
    pch = 8
  )
s3

# add snowman
s4 <- s3 +
  geom_circle(
    data = data.frame(
      x0 = c(0.6, 0.6),
      y0 = c(0.3, 0.5),
      r = c(0.15, 0.1)
    ),
    mapping = aes(x0 = x0, y0 = y0, r = r),
    fill = "white",
    colour = "white"
  )
s4

# add eyes and buttons
s5 <- s4 +
  geom_point(
    data = data.frame(
      x = c(0.6, 0.6, 0.6, 0.57, 0.62),
      y = c(0.25, 0.3, 0.35, 0.52, 0.52),
      size = runif(5, 2, 4.5)
    ),
    mapping = aes(x = x, y = y, size = size)
  ) +
  scale_size_identity()
s5

# add hat
s6 <- s5 +
  annotate(
    geom = "rect",
    xmin = 0.46,
    xmax = 0.74,
    ymin = 0.56,
    ymax = 0.6,
    fill = "brown"
  ) +
  annotate(
    geom = "rect",
    xmin = 0.5,
    xmax = 0.7,
    ymin = 0.56,
    ymax = 0.73,
    fill = "brown"
  )
s6

# add nose
nose_pts <- matrix(
  c(
    0.6, 0.5,
    0.65, 0.48,
    0.6, 0.46,
    0.6, 0.5
  ),
  ncol = 2,
  byrow = TRUE
)
nose <- st_polygon(list(nose_pts))
s7 <- s6 +
  geom_sf(
    data = nose,
    fill = "orange",
    colour = "orange"
  ) +
  coord_sf(expand = FALSE)
s7

# add text
s8 <- s7 +
  annotate(
    geom = "text",
    x = 0.5,
    y = 0.95,
    label = "Merry Christmas",
    colour = "red3",
    fontface = "bold",
    size = 9
  ) +
  annotate(
    geom = "text",
    x = 0.5,
    y = 0.07,
    label = "To ...\n From ...",
    colour = "red3",
    fontface = "bold",
    size = 5
  )
s8
