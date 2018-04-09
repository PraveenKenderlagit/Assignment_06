

# Loading libarieslibraries

library(tidyverse)
library(ggmap)
library(ggplot2)

#1, Draw Road map and Water Colors; 

BudeRoadMap <- get_googlemap(center = c(-4.543678, 50.82664), maptype = "roadmap", zoom = 13)
ggmap(BudeRoadMap)

BudeWaterMap <- get_map("Bude england",source = "stamen", maptype = "watercolor", zoom = 13)
ggmap(BudeWaterMap)


#2 Identify locations in BUDe

A <- geocode("Bude West England")
B <- get_map(A, zoom = 12)

BWaterMap <- get_map(A, source = "stamen", maptype = "watercolor", zoom = 13)

L1 <- geocode("Bude Sea Pool,bude")
L2 <- geocode("Bude Beaches,bude")
L3 <- geocode("Bude North Cornwall Cricket Club,bude")
L4 <- geocode("Bar 35,bude")

LRowCombi <- rbind(L1, L2, L3)   # Combing all co-oridnates for 3 locations


# Drawing red dots in the concered locations both in Water Map and Road Map. 
BWaterMap <- ggmap(BudeWaterMap) + geom_point(aes(x = lon, y = lat), data = LRowCombi, color = "red", size = 2) 
BWaterMap 

BRoadMap <- ggmap(BudeRoadMap) + geom_point(aes(x = lon, y = lat), data = LRowCombi, color = "red", size = 2)
BRoadMap



# 3. Drawing path between cricket ground and Pub; 

Q <- geocode("Bude North Cornwall Cricket Club, Bude")
QMap1 <- get_googlemap(center = c(-4.552814, 50.83347), maptype = "roadmap", zoom = 15)

QMap2 <- ggmap(QMap1) + geom_point(aes(x = lon, y = lat), data = Q, color = "red", size = 2)
QMap2

W <- geocode("Bar 35, Bude")
WMap1 <- get_googlemap(center = c(-4.544088, 50.83016), maptype = "roadmap", zoom = 15 )

WMap2 <- ggmap(WMap1) + geom_point(aes(x = lon, y = lat), data = W, color = "red", size = 2)
WMap2

from <- "Bude North Cornwall Cricket Club, Bude"
to <- "Bar 35,bude"

route_df <- route(from, to, structure = "route")
trek_df  <-  trek(from, to, structure = "route")


QW <- rbind(Q,W)

QW1 <- ggmap(WMap1) + geom_point(aes(x = lon, y = lat), data = QW, color = "red", size = 2)

QW1

AAA <- c("Circket ground", "Bude Pub")

QW2 <- ggmap(WMap1) + 
       geom_point(aes(x = lon, y = lat), data = QW, 
                  color = "red", size = 2) +  
        geom_text(aes(x = lon, y = lat), data = QW, label = AAA) +
        
      geom_path(
         aes(x = lon, y = lat), color = "blue", 
          size = 1.5, alpha = .5,
            data = route_df, lineend = "round"
        ) + 
       geom_path(
         aes(x = lon, y = lat), color = "red",
           size = 1.5, alpha = .5, 
             data = trek_df, lineend = "round"
        ) 

QW2


