library(rameritrade)

refreshToken = readRDS('TDRefToken.rds')
consumerKey = readRDS('consumerKey.Rds')

accessToken = rameritrade::td_auth_accessToken(consumerKey, refreshToken)

df_act = td_accountData()
df_act
names(df_act$positions)
