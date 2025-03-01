library(shiny)
library(dplyr)
library(ggplot2)
library(ggsoccer)




ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("team",
                  label = "Vælg hold",
                  choices = dteams
      ),
      selectInput("match",
                  label = "Vælg kamp",
                  choices = NULL
      ),
      numericInput("minutes",
                   label = "Vælg kampperiode",
                   value = 0, step = 10
      )
    ),
    mainPanel(
      plotOutput("passplot")
    )
  )
)

server <- function(input, output, session) {
  # hold i dropdown
  observe({
    tval <- input$team
    tval=ifelse(nchar(tval)<2,"Ajax",input$team)
    choices <- dutchmatches %>% filter(home==tval) %>% select(longinfo)
    updateSelectInput(session, "match", choices = choices)
  })
  
  output$passplot <- renderPlot({
    mval <- input$match
    #mval <- "Willem II - Feyenoord _ 5241741"
    match <- str_split(mval,"_")
    mid <- match[[1]][2]
    teams <- match[[1]][1]
    hamatch <- str_split(teams," - ")
    
    #home and away teams
    ht <- hamatch[[1]][1]
    ht <- gsub(" $","",ht)
    at <- hamatch[[1]][2]
    at <- gsub(" $","",at)
    mid <- gsub(" ","",mid)
    print(mid)
    allPM <- allpasses %>% filter(matchId==mid)
    
    # prep the dataframe
    
    # split the teams
    allPM1 <- allPM %>% filter(team.name==ht)
    allPM2 <- allPM %>% filter(team.name==at)
    # mean location for den som afleverer
    allPM1gr <- allPM1 %>% group_by(player.name) %>% 
      mutate(mx=mean(location.x),
             my=mean(location.y),
      )  %>% select(player.name,
                    player.position,
                    pass.recipient.name,
                    pass.recipient.position,
                    mx,
                    my,
                    pass.endLocation.x,
                    pass.endLocation.y,
                    team.name
      ) %>% unique() 
    allPM1gr <- allPM1gr %>% group_by(pass.recipient.name) %>% mutate(
      mrx=mean(pass.endLocation.x),
      mry=mean(pass.endLocation.y),
    ) %>% ungroup()
    
    # now count the number of passes
    allPM1ct <- allPM1gr %>% group_by(player.name,pass.recipient.name) %>% 
      mutate(cnt=n()) %>% arrange(desc(cnt)) %>% 
      select(player.name,cnt,pass.recipient.name,mx,my,mrx,mry,team.name) %>%  unique()
    
    # now passplot
    
    df2=allPM1ct %>% filter(cnt > 3)
    ggplot(df2) +
      annotate_pitch() +
      geom_segment(aes(x = mx, y = my, xend = mrx, yend = mry),size=df2$cnt/8)+
      geom_point(aes(x=mx,y=my,color=df2$team.name), size=2)+
      geom_point(aes(x=mrx,y=mry,color=df2$team.name), size=2)+
      geom_text(aes(x=mx,y=my,label=player.name),color="blue",size=2,vjust=-2)+
      geom_text(aes(x=mrx,y=mry,label=pass.recipient.name),color="red",size=2,vjust=2)+
      theme_pitch() +
      direction_label() +
      ggtitle("Simple passmap", 
              "ggsoccer example")
    
    
  })
}

shinyApp(ui, server)
