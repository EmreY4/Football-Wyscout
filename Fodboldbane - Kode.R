# Plot football pitch with sideline and goal line
library(ggsoccer)

ggplot() +
  annotate_pitch(fill = "springgreen4", colour = "white", goals = goals_line) +
  theme(panel.background = element_rect(fill = "springgreen4")) +
  coord_cartesian(xlim = c(4.4, 95.6), ylim = c(4.4, 95.6))
