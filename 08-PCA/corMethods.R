# File-Name:       corMethods.R           
# Date:            2012-10-29                                
# Author:          Brooke M. Fujita (buruzaemon@gmail.com)
# Purpose:         Illustrate the differences in the 3 correlation coefficient methods 
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
# Calculate cor for each of the 3 methods
cor.pearson  <- cor(date.stock.matrix[,2:ncol(date.stock.matrix)], method='pearson')
# Kendall seems to require more time to process...
cor.kendall  <- cor(date.stock.matrix[,2:ncol(date.stock.matrix)], method='kendall')
cor.spearman <- cor(date.stock.matrix[,2:ncol(date.stock.matrix)], method='spearman')

# Snippet 5
# Transform the above matrices to a vector of correlation values
vec.pearson   <- as.numeric(cor.pearson)
vec.kendall   <- as.numeric(cor.kendall)
vec.spearman  <- as.numeric(cor.spearman)

# Snippet 6
# Now create a data frame combining all 3 methods, 
# with the method name as a factor
df.pearson    <- data.frame(vec.pearson)
names(df.pearson) <- c('Correlation')
df.pearson    <- transform(df.pearson, Method='pearson')

df.kendall    <- data.frame(vec.kendall)
names(df.kendall) <- c('Correlation')
df.kendall    <- transform(df.kendall, Method='kendall')

df.spearman    <- data.frame(vec.spearman)
names(df.spearman) <- c('Correlation')
df.spearman    <- transform(df.spearman, Method='spearman')

df <- rbind(df.pearson, df.kendall, df.spearman)

# Snippet 7
# Create plot to visually compare the differences
#ggplot(df, aes(x = Correlation, fill = 1)) +
#  geom_density() +
#  facet_grid(Method ~ .)
ggplot(df, aes(x = Correlation, fill = 1)) +
  geom_density() +
  facet_grid(Method ~ .) +
  opts(title = "cor method comparison: Pearson, Kendall & Spearman")
ggsave(filename = file.path("images", "00_cor_method_comparison.pdf"))
