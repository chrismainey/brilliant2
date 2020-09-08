
<!-- README.md is generated from README.Rmd. Please edit that file -->

# brilliant

<!-- badges: start -->

[![R build
status](https://github.com/chrismainey/brilliant/workflows/R-CMD-check/badge.svg)](https://github.com/chrismainey/brilliant/actions)
[![Codecov test
coverage](https://codecov.io/gh/chrismainey/brilliant/branch/master/graph/badge.svg)](https://codecov.io/gh/chrismainey/brilliant?branch=master)
<!-- badges: end -->

The goal of brilliant is to demonstrate some steps for building R
packages

## Installation

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(brilliant)
library(NHSRdatasets)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

## we'll look at average age, and 95% Ci around it, in the LoS_data.
data("LOS_model")

ages_dt<-
  LOS_model %>% 
  group_by(Organisation) %>% 
  summarise(
    mean = mean(Age),
    sd = sd(Age),
    n = n(),
    se = sd(Age)/n()
  )
#> `summarise()` ungrouping output (override with `.groups` argument)

ages_dt <-
  ages_dt %>% 
  mutate(
    lower95 = my_CI_lower(mean, se, prob = 0.95),
    upper95 = my_CI_upper(mean, se, prob = 0.95)
  )

# Total mean
mean_full <- mean(LOS_model$Age)

library(ggplot2)
ggplot(ages_dt, aes(y=mean, x=factor(Organisation)))+
  geom_point()+
  geom_hline(aes(yintercept=mean_full), col="red")+
  geom_errorbar(aes(ymin=lower95, ymax=upper95)) +
  theme_minimal()
```

<img src="man/figures/README-example-1.png" width="100%" />

So, (and this is where we mustn’t be confused by what a CI is), if we
repeated our sampling and infinite number of time, the Trust means would
be within these ranges 95% of the time. We will therefore assume, from
our evidence, that mean Age is significantly higher than global average
at Trusts 1 and 7, and significantly lower at Trusts 3, 5 and 6.
