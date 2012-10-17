# File-Name:       chapter08.R           
# Date:            2012-02-10                                
# Author:          Drew Conway (drew.conway@nyu.edu) and John Myles White (jmw@johnmyleswhite.com)                                                                    
# Purpose:         
# Data Used:       data/DJI.csv, data/stock_prices.csv
# Packages Used:   ggplot2, lubridate, reshape

# All source code is copyright (c) 2012, under the Simplified BSD License.  
# For more information on FreeBSD see: http://www.opensource.org/licenses/bsd-license.php

# All images and materials produced by this code are licensed under the Creative Commons 
# Attribution-Share Alike 3.0 United States License: http://creativecommons.org/licenses/by-sa/3.0/us/

# All rights reserved.

# NOTE: If you are running this in the R console you must use the 'setwd' command to set the 
# working directory for the console to whereever you have saved this file prior to running.
# Otherwise you will see errors when loading data or saving figures!

library('ggplot2')

# Snippet 1
prices <- read.csv(file.path('data', 'stock_prices.csv'))

prices[1, ]
# Date Stock Close
#1 2011-05-25 DTE 51.12

# Snippet 2
library('lubridate')

prices <- transform(prices, Date = ymd(Date))

# Snippet 3
library('reshape')

# prices is already in a molten state,
# with Date and Stock as identifier variables
# and Close value as measured variables
date.stock.matrix <- cast(prices, Date ~ Stock, value = 'Close')

# Snippet 4
# Examining prices at this point, it appears that there is only
# one closing price for 2002-02-01: DDR. Hence, we will throw
# out that one date, and also throw out DDR as well
prices <- subset(prices, Date != ymd('2002-02-01'))
prices <- subset(prices, Stock != 'DDR')

date.stock.matrix <- cast(prices, Date ~ Stock, value = 'Close')

# Snippet 5
cor.matrix <- cor(date.stock.matrix[,2:ncol(date.stock.matrix)])
correlations <- as.numeric(cor.matrix)

ggplot(data.frame(Correlation = correlations),
  aes(x = Correlation, fill = 1)) +
  geom_density() +
  opts(legend.position = 'none')

# Snippet 6
pca <- princomp(date.stock.matrix[,2:ncol(date.stock.matrix)])

# Snippet 7
pca
#Call:
#princomp(x = date.stock.matrix[, 2:ncol(date.stock.matrix)])
#Standard deviations:
#Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7
#29.1001249 20.4403404 12.6726924 11.4636450 8.4963820 8.1969345 5.5438308
#Comp.8 Comp.9 Comp.10 Comp.11 Comp.12 Comp.13 Comp.14
#5.1300931 4.7786752 4.2575099 3.3050931 2.6197715 2.4986181 2.1746125
#Comp.15 Comp.16 Comp.17 Comp.18 Comp.19 Comp.20 Comp.21
#1.9469475 1.8706240 1.6984043 1.6344116 1.2327471 1.1280913 0.9877634
#Comp.22 Comp.23 Comp.24
#0.8583681 0.7390626 0.4347983
#24 variables and 2366 observations.

summary(pca)
# Importance of components:
#                            Comp.1     Comp.2      Comp.3      Comp.4     Comp.5
# Standard deviation     29.1001249 20.4403404 12.67269243 11.46364500 8.49638196
# Proportion of Variance  0.4600083  0.2269615  0.08723961  0.07138737 0.03921426
# Cumulative Proportion   0.4600083  0.6869698  0.77420941  0.84559678 0.88481104
#
#                            Comp.6     Comp.7     Comp.8     Comp.9     Comp.10
# Standard deviation     8.19693448 5.54383078 5.13009309 4.77867520 4.257509927
# Proportion of Variance 0.03649882 0.01669536 0.01429639 0.01240483 0.009846622
# Cumulative Proportion  0.92130986 0.93800523 0.95230162 0.96470645 0.974553074
#
#                           Comp.11     Comp.12     Comp.13     Comp.14
# Standard deviation     3.305093119 2.619771465 2.498618085 2.174612539
# Proportion of Variance 0.005933943 0.003728231 0.003391374 0.002568856
# Cumulative Proportion  0.980487017 0.984215247 0.987606622 0.990175477
#
#                            Comp.15     Comp.16     Comp.17     Comp.18
# Standard deviation     1.946947496 1.870623998 1.698404287 1.634411605
# Proportion of Variance 0.002059133 0.001900855 0.001566961 0.001451105
# Cumulative Proportion  0.992234610 0.994135465 0.995702426 0.997153531
#
#                            Comp.19      Comp.20      Comp.21      Comp.22
# Standard deviation     1.232747064 1.1280913254 0.9877633997 0.8583681320
# Proportion of Variance 0.000825513 0.0006912967 0.0005300072 0.0004002424
# Cumulative Proportion  0.997979044 0.9986703406 0.9992003478 0.9996005903
#
#                             Comp.23      Comp.24
# Standard deviation     0.7390625523 0.4347982692
# Proportion of Variance 0.0002967142 0.0001026955
# Cumulative Proportion  0.9998973045 1.0000000000


# Snippet 8
principal.component <- pca$loadings[, 1]

# Snippet 9
loadings <- as.numeric(principal.component)

ggplot(data.frame(Loading = loadings),
  aes(x = Loading, fill = 1)) +
  geom_density() +
  opts(legend.position = 'none')

# Snippet 10
market.index <- predict(pca)[, 1]

# Snippet 11
dji.prices <- read.csv(file.path('data', 'DJI.csv'))
dji.prices <- transform(dji.prices, Date = ymd(Date))

# Snippet 12
dji.prices <- subset(dji.prices, Date > ymd('2001-12-31'))
dji.prices <- subset(dji.prices, Date != ymd('2002-02-01'))

# Snippet 13
dji <- with(dji.prices, rev(Close))
dates <- with(dji.prices, rev(Date))

# Snippet 14
comparison <- data.frame(Date = dates,
                         MarketIndex = market.index,
                         DJI = dji)

ggplot(comparison, aes(x = MarketIndex, y = DJI)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Snippet 15
comparison <- transform(comparison, MarketIndex = -1 * MarketIndex)

# Snippet 16
ggplot(comparison, aes(x = MarketIndex, y = DJI)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Snippet 17
alt.comparison <- melt(comparison, id.vars = 'Date')

names(alt.comparison) <- c('Date', 'Index', 'Price')

ggplot(alt.comparison,
       aes(x = Date, y = Price, group = Index, color = Index)) +
  geom_point() +
  geom_line()

# Snippet 18
comparison <- transform(comparison, MarketIndex = scale(MarketIndex))
comparison <- transform(comparison, DJI = scale(DJI))

alt.comparison <- melt(comparison, id.vars = 'Date')

names(alt.comparison) <- c('Date', 'Index', 'Price')

ggplot(alt.comparison, aes(x = Date, y = Price, group = Index, color = Index)) +
  geom_point() +
  geom_line()
