#### ------------------------------------------------------- JSON Filer: Analyse af Event-data for Ajax og NEC --------------------------------------------- ####
# Emne: Visualisering af eventdata for Ajax og NEC
# Dette script demonstrerer, hvordan man:
#   1. Indlæser & flader json-filer
#   2. Opretter et søjlediagram for mest dominerende eventtype
#   3. Sammenligner eventtyper mellem Ajax og NEC

# Libraries
library(ggplot2)   # Visualisering
library(jsonlite)  # JSON håndtering

# --------------------------------------------------- Mest dominerende event for Ajax og NEC (sammenlagt) ---------------------------------------------------- #
# Indlæs JSON-data fra filen "evt_5360157.json"
JSON_Data <- fromJSON("Bilag - Data/evt_5360157.json", flatten = TRUE)
# Få adgang til "events" dataframen
Events_DF <- as.data.frame(JSON_Data$events)
# Lav en faktorvariabel for eventtyper
Events_DF$type.primary <- as.factor(Events_DF$type.primary)
# Lav et søjlediagram med ggplot2
ggplot(Events_DF, aes(x = reorder(type.primary, -table(type.primary)[type.primary]))) +
  geom_bar(aes(fill = type.primary)) +
  geom_text(stat = "count", aes(label = ..count.., fill = type.primary), vjust = -0.5) +
  labs(title = "Afleveringer mest dominerende type", x = "Event Type", y = "Frequency") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 50, hjust = 1), 
        legend.position = "none")  # Fjern farvelegenden

# ---------------------------------------------------- Ajax versus NEC (Duel, Pass, Shot, Touch) ------------------------------------------------------------- #
# Filtrer data for kun at inkludere eventtyperne "duel", "pass", "shot" og "touch"
Events_Selected <- Events_DF[Events_DF$type.primary %in% c("duel", "pass", "shot", "touch"), ]
# Filtrer data for kun at inkludere holdene Ajax og NEC
Teams_Selected <- Events_Selected[Events_Selected$team.name %in% c("Ajax", "NEC"), ]
# Lav et søjlediagram med ggplot2
ggplot(Teams_Selected, aes(x = type.primary, fill = team.name)) +
  geom_bar(position = "dodge", alpha = 0.7) +
  geom_text(stat = "count", aes(label = ..count..), position = position_dodge(width = 0.9), vjust = -0.5) +
  labs(title = "Sammenligning af eventtyper mellem Ajax og NEC", x = "Event Type", y = "Antal") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
