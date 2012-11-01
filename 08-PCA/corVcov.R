# File-Name:       corVcov.R           
# Date:            2012-11-01                                
# Author:          Brooke M. Fujita (buruzaemon@gmail.com)
# Purpose:         Illustrate the differences between correlation and coveriance for Ch. 8 exercise
# Data Used:       data/stock_prices.csv
# Packages Used:   ggplot2, lubridate, reshape

# All source code is copyright (c) 2012, under the Simplified BSD License.  
# For more information on FreeBSD see: http://www.opensource.org/licenses/bsd-license.php

# All images and materials produced by this code are licensed under the Creative Commons 
# Attribution-Share Alike 3.0 United States License: http://creativecommons.org/licenses/by-sa/3.0/us/

# All rights reserved.

# NOTE: If you are running this in the R console you must use the 'setwd' command to set the 
# working directory for the console to whereever you have saved this file prior to running.
# Otherwise you will see errors when loading data or saving figures!

# First, load the libraries necessary
library('ggplot2')
library('lubridate')
library('reshape')

# Snippet 1
prices <- read.csv(file.path('data', 'stock_prices.csv'))

# Snippet 2
# Examining prices at this point, it appears that there is only
# one closing price for 2002-02-01: DDR. Hence, we will throw
# out that one date, and also throw out DDR as well
prices <- subset(prices, Date != ymd('2002-02-01'))
prices <- subset(prices, Stock != 'DDR')

# Snippet 3
# Prices is already in a molten state,
# with Date and Stock as identifier variables
# and Close value as measured variables
date.stock.matrix <- cast(prices, Date ~ Stock, value = 'Close')

# Snippet 4
# Calculate correlation (Pearson, the default)
correlations  <- cor(date.stock.matrix[,2:ncol(date.stock.matrix)])

# Snippet 5
# Calculate covariance
covariances  <- cov(date.stock.matrix[,2:ncol(date.stock.matrix)])

# Snippet 6
# Transform the above 2 matrices to a vectors
vec.correlations  <- as.numeric(scale(correlations))
vec.covariances   <- as.numeric(scale(covariances))

# Snippet 7
# Now create a data frame combining them,
# with the method name as a factor
df.correlations    <- data.frame(vec.correlations)
names(df.correlations) <- c('Value')
df.correlations    <- transform(df.correlations, Method='correlation')

df.covariances    <- data.frame(vec.covariances)
names(df.covariances) <- c('Value')
df.covariances    <- transform(df.covariances, Method='covariance')

df <- rbind(df.correlations, df.covariances)

# Snippet 8
# Create plot to visually compare the difference
ggplot(df, aes(x = Value, fill = 1)) +
  geom_density() +
  facet_grid(Method ~ .) +
  opts(title = "correlation vs. covariance (scaled)")
ggsave(filename = file.path("images", "01_cor_cov_calculation_comparison.pdf"))
