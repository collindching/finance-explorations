library(rameritrade)
library(lubridate)
library(tidyverse)
library(PerformanceAnalytics)
library(quantmod)

refreshToken = readRDS('TDRefToken.rds')
consumerKey = readRDS('consumerKey.rds')
accountIDs = readRDS('accountIDs.rds')

# Log in
accessToken = rameritrade::td_auth_accessToken(consumerKey, refreshToken)
act_dt = td_accountData()

names(act_dt)
names(act_dt$positions)

# Pull out some portfolio stats
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

# Pull price data for df
tickers <- df_equity$ticker
tickers <- getSymbols(tickers, src = "yahoo",
                       from = "2015-01-01",
                       to = "2021-03-05",
                       auto.assign = T) 

df_prices <- map(symbols, ~Ad(get(.x))) %>%
    reduce(merge)

names(df_prices) <- tickers

# Get monthly returns
# https://stackoverflow.com/questions/16136245/convert-times-series-to-quarterly-with-nas

pr_monthly <- period.apply(df_prices, endpoints(df_prices, "months"), function(x) last(x))

(pct_miss <- sapply(pr_monthly, function(x) round(sum(is.na(x)/length(x)),2)) %>%
    sort(decreasing=T))

filtered_tix <- names(pct_miss[pct_miss<0.5])
df_monthly <- pr_monthly[,filtered_tix]
rt_monthly <- na.omit(Return.calculate(df_monthly, method='log'))

# Get weights for portfolio
wt_indices <- match(names(rt_monthly), paste(df_equity$ticker,'Adjusted',sep='.'))
pf_wts <- df_equity$weight[wt_indices]

returns <- Return.portfolio(rt_monthly, weights=pf_wts, rebalance_on='months')
returns_sd <- StdDev(returns)

table.DownsideRisk(returns)
table.Drawdowns(returns)
SharpeRatio(returns)
table.Stats(returns)

