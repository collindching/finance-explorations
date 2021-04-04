library(devtools)
library(blsAPI)
library(rjson)
library(plyr)
library(lubridate)
library(tidyverse)
library(tidyquant)
library(patchwork)
library(rvest)
library(data.table)

# http://bradleyboehmke.github.io/2015/12/scraping-html-tables.html


url_list <- list('https://www.bls.gov/schedule/2018/home.htm',
                 'https://www.bls.gov/schedule/2019/home.htm',
                 'https://www.bls.gov/schedule/2020/home.htm')

webpage <- read_html("https://www.bls.gov/schedule/2020/home.htm")
html <- html_nodes(webpage, "table")

schedule_list <- html %>%
    html_table(fill=TRUE)

schedule_data <- rbindlist(schedule_list)

names(schedule_data) <- tolower(names(schedule_data))
schedule_data$date <- mdy(sapply(strsplit(schedule_data$date,' '), function(x) paste(x[2], x[3], x[4], sep=' ')))

employment_schedule <- schedule_data %>%
    filter(grepl('^Employment Situation',release) & !grepl('Veterans',release)) %>%
    mutate(month=month(date),
           year=year(date))



#https://github.com/mikeasilva/blsAPI
# LNS14000000 is natoinal unemployment rate

payload <- list(
    'seriesid'=c('LNS14000000'),
    'startyear'=2014,
    'endyear'=2021)
response <- blsAPI(payload, 1)
json <- fromJSON(response)

unemployed.df <- apiDF(json$Results$series$data)
extract_value <- function(list_obj) return(list_obj$value)
extract_month <- function(list_obj) return(list_obj$periodName)
extract_year <- function(list_obj) return(list_obj$year)

get_unemployment_info <- function(json_object) {
    return(data.frame(month=extract_month(json_object),
                      year=extract_year(json_object),
                      unemployment_rate=extract_value(json_object)))
}

unemployment_df <- ldply(json$Results$series[[1]]$data, function(json_object) get_unemployment_info(json_object))
unemployment_df <- unemployment_df %>%
    mutate(year=as.integer(year),
           month = match(month, month.name),
           date=make_date(year, month, 1),
           unemployment_rate = as.numeric(unemployment_rate)/100) 

test_df <- unemployment_df %>%
    select(-date) %>%
    inner_join(employment_schedule, by=c('year','month'))

vti_df

df <- test_df %>%
    left_join(vti_df, by='date') %>%
    mutate(price_delta=close-open)

plot(df$price_delta, df$unemployment_rate)

unemployment_df
head(employment_schedule)
p1 <- ggplot(data=unemployment_df, aes(x=date, y=unemployment_rate)) +
    geom_point() + 
    geom_line() +
    theme_bw() 

# graph 2
vti_df <- tq_get('VTI',
                 from = "2014-01-01",
                 to = "2021-03-01",
                 get = "stock.prices")

p2 <- ggplot(data=vti_df, aes(x=date, y=open)) +
    geom_line() +
    theme_bw() 

# graph both together
p1 + p2


mean(vti_df$open)/mean(unemployment_df$unemployment_rate)
scale_coef <- 1800

ggplot() +
    geom_line(data=unemployment_df, aes(x=date,y=unemployment_rate), col='darkred') + 
    geom_point(data=unemployment_df, aes(x=date,y=unemployment_rate), col='darkred', size=.5) + 
    geom_line(data=vti_df, aes(x=date, y=open/scale_coef), col='darkgreen') + 
    scale_y_continuous(
        name = "Unemployment",
        labels = scales::percent,
        sec.axis = sec_axis(~.*scale_coef,
                            breaks=seq(0,250,50),
                            labels=dollar(seq(0,250,50)),
                            name="Vanguard Total Market Index")) +
    theme_bw()


str(unemployment_df)
str(vti_df)

df <- vti_df %>%
    left_join(unemployment_df[,c('date', 'unemployment_rate')], by='date') %>%
    filter(!is.na(unemployment_rate)) %>%
    mutate(day_delta = close-open) %>%
    arrange(date)

head(df)

