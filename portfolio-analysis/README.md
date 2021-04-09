# Overview

It has been more than a year since I started investing meaningful amounts of my money. Now I want to examine my investing approach more rigorous. 

In particular, I want to explore the allocation of assets in my portfolio (currently all growth stocks and total market ETFs), and look for opportunities to achieve more growth for lower volatility. 

I'm also interested in marketing timing, learning to handle time series data, and understanding core financial concepts.

Hopefully, these investigations will help me to improve my portfolio for my growth goals. And I love that I get to use R to do so. 

**Some of the questions I'm most interested in answering:** 

- What is the expected growth of my portfolio? 
- Could I achieve more growth in my portfolio for the same amount of volatility I currently have? 
- What is the difference between value and growth?
- What is risk, and how risky is my portfolio? What is risk? 
- What is the Sharpe ratio? 
  - [The Sharpe Ratio Defined](http://news.morningstar.com/classroom2/course.asp?docId=2932&page=4)
  - [What Is a Good Sharpe Ratio?](https://www.investopedia.com/ask/answers/010815/what-good-sharpe-ratio.asp#:~:text=Usually%2C%20any%20Sharpe%20ratio%20greater,1.0%20is%20considered%20sub%2Doptimal.)
  - [How to Improve a Sharpe Ratio in Trading](https://finance.zacks.com/improve-sharpe-ratio-trading-3457.html)

# Questions

- What is the `zoo` package?
- What is the `xts` package? 
- Why use log returns instead of discrete returns? 
  - [Why Log Returns | Quantivity](https://quantivity.wordpress.com/2011/02/21/why-log-returns/)
  - [What does the average log-return value of a stock mean? - Personal Finance & Money Stack Exchange](https://money.stackexchange.com/questions/24382/what-does-the-average-log-return-value-of-a-stock-mean)
  - [regression - Why is it that natural log changes are percentage changes? What is about logs that makes this so? - Cross Validated](https://stats.stackexchange.com/questions/244199/why-is-it-that-natural-log-changes-are-percentage-changes-what-is-about-logs-th#:~:text=The%20percent%20change%20is%20a%20linear%20approximation%20of%20the%20log%20difference!)

# Tasks

1. Set up the TDAmeritrade account
2. Set up authentication in R
3. Analyze portfolio

# Tutorials I used

1.  Setting up TDAmeritrade account access in R
    - [Exploring Finance: Trade on TD Ameritrade with R](https://exploringfinance.github.io/posts/2020-10-17-trade-on-td-ameritrade-with-r/)
2.  Learn to set up time series stock data for portfolio analytics
    - [Apply functions by time](https://s3.amazonaws.com/assets.datacamp.com/production/course_1127/slides/chapter_4.pdf)
3.  Learning to analyze portfolio
    - `PerformanceAnalytics`  
    

# Key packages

- `zoo`
- `xts` (eXtensible Time Series)
  - Provides a time series package data type, built on top of `zoo` data types
  - [Cheat sheet xts R.indd](https://s3.amazonaws.com/assets.datacamp.com/blog_assets/xts_Cheat_Sheet_R.pdf?tap_a=5644-dce66f&tap_s=10907-287229)
  - [Manipulating Time Series Data in R with xts & zoo](https://rstudio-pubs-static.s3.amazonaws.com/288218_117e183e74964557a5da4fc5902fc671.html)
  - [xts Cheat Sheet: Time Series in R - DataCamp](https://www.datacamp.com/community/blog/r-xts-cheat-sheet)
- `rameritrade`
- `PerformanceAnalytics`
  - [Introduction to PortfolioAnalytics | R-bloggers](https://www.r-bloggers.com/2014/03/introduction-to-portfolioanalytics/)
  - [portfolio_vignette.pdf](https://cran.r-project.org/web/packages/PortfolioAnalytics/vignettes/portfolio_vignette.pdf)
  - [RPubs - Intermediate Portfolio Analysis in R](https://www.rpubs.com/hgjerning/517730)
  - [Portfolio analysis with r](https://thisisdaryn.netlify.app/post/portfolio-analysis-with-r/#r-packages-used)
  - [PortfolioAnalytics Tutorial](https://rossb34.github.io/PortfolioAnalyticsPresentation2017/#1)
- `quantmod`

# References

- *Reproducible Finance with R*
- `map`
  - [Apply a function to each element of a list or atomic vector — map • purrr](https://purrr.tidyverse.org/reference/map.html#:~:text=The%20map%20functions%20transform%20their,()%20always%20returns%20a%20list.)
  - [Specifying the function in map() + parallel mapping](https://jennybc.github.io/purrr-tutorial/ls03_map-function-syntax.html)
- [rameritrade](https://github.com/exploringfinance/rameritrade)
  - [`rameritrade` documentation](https://cran.r-project.org/web/packages/rameritrade/rameritrade.pdf)
- [Exploring Finance](https://exploringfinance.github.io/posts/2020-01-01-exploring-finance/)
- https://github.com/TDAmeritrade/stumpy


http://inseaddataanalytics.github.io/INSEADAnalytics/ExerciseSet2.html