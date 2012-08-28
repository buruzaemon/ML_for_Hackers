# File-Name:       chapter05.R           
# Date:            2012-02-10                                
# Author:          Drew Conway (drew.conway@nyu.edu) and John Myles White (jmw@johnmyleswhite.com)                                                                    
# Purpose:         
# Data Used:       data/longevity.csv
# Packages Used:   ggplot2

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
ages <- read.csv(file.path('data', 'longevity.csv'))

ggplot(ages, aes(x = AgeAtDeath, fill = factor(Smokes))) +
  geom_density() +
  facet_grid(Smokes ~ .)

# Snippet 2
ages <- read.csv(file.path('data', 'longevity.csv'))

guess <- 73

with(ages, mean((AgeAtDeath - guess) ^ 2))
#[1] 32.991

# Snippet 3
ages <- read.csv(file.path('data', 'longevity.csv'))

guess.accuracy <- data.frame()

for (guess in 63:83)
{
  prediction.error <- with(ages, mean((AgeAtDeath - guess) ^ 2))
  guess.accuracy <- rbind(guess.accuracy,
                          data.frame(Guess = guess,
                                     Error = prediction.error))
}

ggplot(guess.accuracy, aes(x = Guess, y = Error)) +
  geom_point() +
  geom_line()

# Snippet 4
ages <- read.csv(file.path('data', 'longevity.csv'))

constant.guess <- with(ages, mean(AgeAtDeath))

with(ages, sqrt(mean((AgeAtDeath - constant.guess) ^ 2)))

smokers.guess <- with(subset(ages, Smokes == 1), mean(AgeAtDeath))

non.smokers.guess <- with(subset(ages, Smokes == 0), mean(AgeAtDeath))

ages <- transform(ages,
                  NewPrediction = ifelse(Smokes == 0,
                                         non.smokers.guess,
                                         smokers.guess))

with(ages, sqrt(mean((AgeAtDeath - NewPrediction) ^ 2)))

# Snippet 5
heights.weights <- read.csv(file.path('data', '01_heights_weights_genders.csv'),
                            header = TRUE,
                            sep = ',')

ggplot(heights.weights, aes(x = Height, y = Weight)) +
  geom_point() +
  geom_smooth(method = 'lm')

# Snippet 6
fitted.regression <- lm(Weight ~ Height, data = heights.weights)

coef(fitted.regression)
#(Intercept) Height
#-350.737192 7.717288

# Snippet 7
intercept <- coef(fitted.regression)[1]
slope <- coef(fitted.regression)[2]

# predicted.weight <- intercept + slope * observed.height
# predicted.weight == -350.737192 + 7.717288 * observed.height

# Snippet 8
predict(fitted.regression)

# Snippet 9
true.values <- with(heights.weights, Weight)
errors <- true.values - predict(fitted.regression)

# Snippet 10
residuals(fitted.regression)

# Snippet 11
plot(fitted.regression, which = 1)

# Snippet 12
x <- 1:10
y <- x ^ 2

plot(lm(y ~ x) , which = 1)

# Snippet 13
x <- 1:10
y <- x ^ 2

sum(residuals(lm(y ~ x)) ^ 2)
#[1] 528

# Snippet 14
x <- 1:10
y <- x ^ 2

mse <- mean(residuals(lm(y ~ x)) ^ 2)
mse
#[1] 52.8

# Snippet 15
x <- 1:10
y <- x ^ 2

rmse <- sqrt(mean(residuals(lm(y ~ x)) ^ 2))
rmse
#[1] 7.266361

# Snippet 16
# There was an error in the book for this example.
# R-squared is a ratio of MSE's, not RMSE's.
mean.mse <- 1.09209343
model.mse <- 0.954544

r2 <- 1 - (model.mse / mean.mse)
r2
#[1] 0.1259502

# Snippet 17
top.1000.sites <- read.csv(file.path('data', 'top_1000_sites.tsv'),
                           sep = '\t',
                           stringsAsFactors = FALSE)

ggplot(top.1000.sites, aes(x = PageViews, y = UniqueVisitors)) + geom_point()

# Snippet 18
ggplot(top.1000.sites, aes(x = PageViews)) + geom_density()

# Snippet 19
ggplot(top.1000.sites, aes(x = log(PageViews))) + geom_density()

# Snippet 20
ggplot(top.1000.sites, aes(x = log(PageViews), y = log(UniqueVisitors))) + geom_point()

# Snippet 21
ggplot(top.1000.sites, aes(x = log(PageViews), y = log(UniqueVisitors))) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Snippet 22
lm.fit <- lm(log(PageViews) ~ log(UniqueVisitors), data = top.1000.sites)

# Snippet 23
summary(lm.fit)

#Call:
#lm(formula = log(PageViews) ~ log(UniqueVisitors), data = top.1000.sites)
#
#Residuals:
# Min 1Q Median 3Q Max
#-2.1825 -0.7986 -0.0741 0.6467 5.1549
#
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)
#(Intercept) -2.83441 0.75201 -3.769 0.000173 ***
#log(UniqueVisitors) 1.33628 0.04568 29.251 < 2e-16 ***
#---
#Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 1.084 on 998 degrees of freedom
#Multiple R-squared: 0.4616, Adjusted R-squared: 0.4611
#F-statistic: 855.6 on 1 and 998 DF, p-value: < 2.2e-16

# Snippet 24
lm.fit.2 <- lm(log(PageViews) ~ HasAdvertising + log(UniqueVisitors) + InEnglish,
               data = top.1000.sites)
summary(lm.fit.2)

#Call:
#lm(formula = log(PageViews) ~ HasAdvertising + log(UniqueVisitors) +
# InEnglish, data = top.1000.sites)
#
#Residuals:
# Min 1Q Median 3Q Max
#-2.4283 -0.7685 -0.0632 0.6298 5.4133
#
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)
#(Intercept) -1.94502 1.14777 -1.695 0.09046 .
#HasAdvertisingYes 0.30595 0.09170 3.336 0.00088 ***
#log(UniqueVisitors) 1.26507 0.07053 17.936 < 2e-16 ***
#InEnglishNo 0.83468 0.20860 4.001 6.77e-05 ***
#InEnglishYes -0.16913 0.20424 -0.828 0.40780
#---
#Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 1.067 on 995 degrees of freedom
#Multiple R-squared: 0.4798, Adjusted R-squared: 0.4777
#F-statistic: 229.4 on 4 and 995 DF, p-value: < 2.2e-16

# Snippet 25
lm.fit.3 <- lm(log(PageViews) ~ HasAdvertising, data = top.1000.sites)
summary(lm.fit.3)$r.squared
#[1] 0.01073766

lm.fit.4 <- lm(log(PageViews) ~ log(UniqueVisitors), data = top.1000.sites)
summary(lm.fit.4)$r.squared
#[1] 0.4615985

lm.fit.5 <- lm(log(PageViews) ~ InEnglish, data = top.1000.sites)
summary(lm.fit.5)$r.squared
#[1] 0.03122206

# Snippet 26
x <- 1:10
y <- x ^ 2

ggplot(data.frame(X = x, Y = y), aes(x = X, y = Y)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Snippet 27
cor(x, y)
#[1] 0.9745586

# Snippet 28
coef(lm(scale(y) ~ scale(x)))
# (Intercept) scale(x)
#-1.386469e-16 9.745586e-01

# BONUS Snippet 29
coef(lm(scale(log(PageViews)) ~ scale(log(UniqueVisitors)), data = top.1000.sites))
#  (Intercept) scale(log(UniqueVisitors))
#  8.570509e-16               6.794104e-01
