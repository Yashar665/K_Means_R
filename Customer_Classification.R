library(tidyverse)
library(factoextra)
library(NbClust)
library(cluster)
library(plotly)
df <- read.csv("C:/Users/Yashar/Desktop/Data Science Bootcamp/R programming/Week 9/Mall_Customers.csv")
df <- df %>% select(Annual.Income..k..:Spending.Score..1.100.)
df <- df %>% scale()
# Optimal Number of Clusters ----

df %>% 
  fviz_nbclust(kmeans, method = "wss") +
  labs(subtitle = "Elbow method")
# Elbow method: 6 clusters solution suggested

df %>% 
  fviz_nbclust(kmeans, method = "silhouette") +
  labs(subtitle = "Silhouette method")
# Silhouette method: 2 clusters solution suggested

df %>% 
  fviz_nbclust(kmeans, nstart = 50,  method = "gap_stat")+
  labs(subtitle = "Gap statistic method")
# Gap statistic method: 2 clusters solution suggested




# Fitting K-Means to the data ----
set.seed(123)
kmeans <- df %>% kmeans(centers = 2)
y_kmeans <- kmeans$cluster %>% as_factor()

df %>% clusplot(y_kmeans,
                shade = TRUE,
                color = TRUE,
                labels = 2,
                plotchar = F,
                main = 'Clusters of customers')
