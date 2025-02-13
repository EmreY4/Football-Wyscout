library(jsonlite)
library(stringr)
library(dplyr)
library(mongolite)


cong <- mongo(
  url = "mongodb://localhost",
  db="wyscout",
  collection = "games"
)
conp <- mongo(
  url = "mongodb://localhost",
  db="wyscout",
  collection = "players"
)
conm <- mongo(
  url = "mongodb://localhost",
  db="wyscout",
  collection = "matches"
)

dutchmatches=conm$find(
  query = '{"competitionId":635}',
  fields = '{"label":1}'
)

# split into home,away,hscore,ascore
#dutchmatches %>% str_split()
t="Zagłębie Lubin - Raków Częstochowa, 1-2"
r=str_split(t,",")
r[[1]][1]
r[[1]][2]
dutchmatches <- dutchmatches %>% rowwise() %>% mutate(match=str_split(label,",")[[1]][1],
                        score=str_split(label,",")[[1]][2])

dutchmatches <- dutchmatches %>% rowwise() %>% mutate(home=str_split(match," - ")[[1]][1],
                        away=str_split(match," - ")[[1]][2])

dutchmatches <- dutchmatches %>% rowwise() %>% mutate(homescore=str_split(score,"-")[[1]][1],
                        awayscore=str_split(score,"-")[[1]][2])
dutchmatches <- dutchmatches %>% mutate(longinfo=paste0(match,"_",`_id`))

dteams <- dutchmatches %>% select(home) %>% unique()


allPasses <- readRDS("allPassesII.rds")
  # wrangle passes
allPasses <- allpasses[!is.na(allpasses$matchId), ]
allPasses <- allpasses %>%  group_by(matchId) %>% mutate(
  interval = cut(minute, 
                 breaks = seq(0, max(minute, na.rm = TRUE) + 10, by = 10), 
                 include.lowest = TRUE, 
                 labels = FALSE)
)
#allPasses <- fromJSON(toJSON(allPasses),flatten = TRUE)
Sys.time()
# get testmatch

testmatch <- fromJSON("evt_5241741.json", flatten = T)
testmatch <- testmatch$events
Sys.time()

testMP <- testmatch %>% filter(type.primary == "pass")

allTeams <- conm$find()
#allPasses <- readRDS("data/allPMP.rds")

