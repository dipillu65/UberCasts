# Include Libraries
library(glmnet)
library(dplyr)
library(Hmisc)
library(lubridate)
library(prophet)
options(
  digits=2, width = 80,
  repr.plot.width = 6,
  repr.plot.height = 5
)
library(ggplot2)
theme_set(theme_bw())

#Read tsv
ud <- read.delim("uber_2015_daily_by_borough.tsv", sep = "\t")
ud$date <- as.Date(ud$date)

#Display head
head(ud)


#QUESTION 1: Chart prophet prediction alongside actual rides
#Mutating the values

#Filter for only bronx rides
ud.bronx <- ud %>% filter(borough == "Bronx")

#Create dataframe for ingestion by prophet
df <- mutate(ud.bronx, ds = date, y = n)

#Filter of dates greater than May 1st for prediction
df <- df %>% filter(date < '2015-05-01')

#Set cap at 2000 rides per day
df$cap <- 2000

#Create prophert model 'm'
m <- prophet(df, growth = 'logistic', uncertainty.samples=100, weekly.seasonality = TRUE) 

#Create prediction with 61 periods 
future <- make_future_dataframe(m, periods = 61)

#Cap at 2000
future$cap <- 2000
tail(future)

#Predict based on model 'm' and future prediction constraints
forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

#Plot results
plot(m, forecast)


#QUESTION 2: Evaluate the effects of the promotion (May 18th to June 2015)

#Feed yhat data into the forecast dataframe
ud.bronx$yhat <- forecast$yhat

#Calculate lift
ud.bronx %>%
  filter(date >= '2015-05-18') %>%
  summarise(
    n = sum(n),
    y.hat = sum(yhat)
  ) %>%
  mutate(
    excess = n - y.hat,
    lift = 100 * excess / y.hat
  )

#Draw chart of promotional results to predictions
ggplot(ud.bronx, aes(date)) + 
  geom_line(aes(y = n, color = "n")) + 
  geom_line(aes(y = yhat, color = "yhat"))

#QUESTION 3: Cost Analyis of Uber's Promotional Campaign
#Calculate the excess number of rides between May 15th - May 17th
ud.bronx %>%
  filter(date >= '2015-05-15' & date <= '2015-05-17') %>%
  summarise(
    n = sum(n),
    y.hat = sum(yhat)
  ) %>%
  mutate(
    excess = n - y.hat
  )


#QUESTION 4: Use all borough dataset to give prediction
#Create dataframe for ingestion by prophet
df <- mutate(ud, ds = date, y = n)

#Filter of dates greater than May 1st for prediction
df <- df %>% filter(date < '2015-05-01')

#Set cap at 2000 rides per day
df$cap <- 2000

#Create prophert model 'm'
m <- prophet(df, growth = 'logistic', uncertainty.samples=100, weekly.seasonality = TRUE) 

#Create prediction with 61 periods 
future <- make_future_dataframe(m, periods = 61)

#Cap at 2000
future$cap <- 2000
tail(future)

#Predict based on model 'm' and future prediction constraints
forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

#Plot results
plot(m, forecast)



