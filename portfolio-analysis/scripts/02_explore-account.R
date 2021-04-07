library(rameritrade)
library(lubridate)
library(tidyverse)
library(PerformanceAnalytics)
library(quantmod)

refreshToken = readRDS('TDRefToken.rds')
consumerKey = readRDS('consumerKey.rds')
accountIDs = readRDS('accountIDs.rds')

accessToken = rameritrade::td_auth_accessToken(consumerKey, refreshToken)

act_dt = td_accountData()

names(act_dt)
names(act_dt$positions)

df_pos <- act_dt$positions
df_equity <- df_pos %>%
    filter(!grepl('_',instrument.symbol)) %>%
    select(account = accountId,
           ticker = instrument.symbol,
           shares= longQuantity,
           avg_price = averagePrice,
           market_value = marketValue) %>%
    mutate(weight = market_value/sum(market_value)) %>%
    arrange(desc(weight))


symbols <- df_equity$ticker
pr_daily <- getSymbols(symbols, src = "yahoo",
                       from = "2015-01-01",
                       to = "2021-03-05",
                       auto.assign = T) 

get(pr_daily[[1]])

View(df_equity)


    