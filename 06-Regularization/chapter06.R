# File-Name:       chapter06.R           
# Date:            2012-02-10                                
# Author:          Drew Conway (drew.conway@nyu.edu) and John Myles White (jmw@johnmyleswhite.com)                                                                    
# Purpose:         
# Data Used:       data/oreilly.csv
# Packages Used:   ggplot2, glmnet, tm, boot

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
set.seed(1)

x <- seq(-10, 10, by = 0.01)
y <- 1 - x ^ 2 + rnorm(length(x), 0, 5)

ggplot(data.frame(X = x, Y = y), aes(x = X, y = Y)) + 
  geom_point() +
  geom_smooth(se = FALSE)

# Snippet 2
x.squared <- x ^ 2

# Snippet 3
ggplot(data.frame(XSquared = x.squared, Y = y), aes(x = XSquared, y = Y)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Snippet 4
summary(lm(y ~ x))$r.squared
#[1] 2.973e-06

summary(lm(y ~ x.squared))$r.squared
#[1] 0.9707

# Snippet 5
set.seed(1)

x <- seq(0, 1, by = 0.01)
y <- sin(2 * pi * x) + rnorm(length(x), 0, 0.1)

df <- data.frame(X = x, Y = y)

ggplot(df, aes(x = X, y = Y)) + geom_point()

# Snippet 6
summary(lm(Y ~ X, data = df))

#Call:
#lm(formula = Y ~ X, data = df)
#
#Residuals:
# Min 1Q Median 3Q Max
#-1.00376 -0.41253 -0.00409 0.40664 0.85874
#
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)
#(Intercept) 0.94111 0.09057 10.39 <2e-16 ***
#X -1.86189 0.15648 -11.90 <2e-16 ***
#---
#Signif. codes:  0 e***f 0.001 e**f 0.01 e*f 0.05 e.f 0.1 e
#
#Residual standard error: 0.4585 on 99 degrees of freedom
#Multiple R-squared: 0.5885, Adjusted R-squared: 0.5843
#F-statistic: 141.6 on 1 and 99 DF, p-value: < 2.2e-16

# Snippet 7
ggplot(data.frame(X = x, Y = y), aes(x = X, y = Y)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Snippet 8
df <- transform(df, X2 = X ^ 2)
df <- transform(df, X3 = X ^ 3)

summary(lm(Y ~ X + X2 + X3, data = df))

#Call:
#lm(formula = Y ~ X + X2 + X3, data = df)
#
#Residuals:
# Min 1Q Median 3Q Max
#-0.32331 -0.08538 0.00652 0.08320 0.20239
#
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)
#(Intercept) -0.16341 0.04425 -3.693 0.000367 ***
#X 11.67844 0.38513 30.323 < 2e-16 ***
#X2 -33.94179 0.89748 -37.819 < 2e-16 ***
#X3 22.59349 0.58979 38.308 < 2e-16 ***
#---
#Signif. codes:  0 e***f 0.001 e**f 0.01 e*f 0.05 e.f 0.1 e f 1 
#
#Residual standard error: 0.1153 on 97 degrees of freedom
#Multiple R-squared: 0.9745, Adjusted R-squared: 0.9737
#F-statistic: 1235 on 3 and 97 DF, p-value: < 2.2e-16

# Snippet 9
df <- transform(df, X4 = X ^ 4)
df <- transform(df, X5 = X ^ 5)
df <- transform(df, X6 = X ^ 6)
df <- transform(df, X7 = X ^ 7)
df <- transform(df, X8 = X ^ 8)
df <- transform(df, X9 = X ^ 9)
df <- transform(df, X10 = X ^ 10)
df <- transform(df, X11 = X ^ 11)
df <- transform(df, X12 = X ^ 12)
df <- transform(df, X13 = X ^ 13)
df <- transform(df, X14 = X ^ 14)
df <- transform(df, X15 = X ^ 15)
df <- transform(df, X16 = X ^ 16)
df <- transform(df, X17 = X ^ 17)
df <- transform(df, X18 = X ^ 18)
df <- transform(df, X19 = X ^ 19)
df <- transform(df, X10 = X ^ 10)
df <- transform(df, X21 = X ^ 21)
df <- transform(df, X22 = X ^ 22)
df <- transform(df, X23 = X ^ 23)
df <- transform(df, X24 = X ^ 24)
df <- transform(df, X25 = X ^ 25)

summary(lm(Y ~ X + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + 
               X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + 
	       X20 + X21 + X22 + X23 + X24 + X25,
           data = df))

#Call:
#lm(formula = Y ~ X + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + 
#    X10 + X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + 
#    X20 + X21 + X22 + X23 + X24 + X25, data = df)
#
#
#Residuals:
#Min        1Q    Median        3Q       Max 
#      -0.234800 -0.041481  0.002777  0.052896  0.209105 
#
#Coefficients: (8 not defined because of singularities)
# Estimate Std. Error t value Pr(>|t|)
#(Intercept) -4.574e-02  8.987e-02  -0.509    0.612
#X            4.062e+00  1.786e+01   0.227    0.821
#X2           4.732e+02  1.131e+03   0.419    0.677
#X3          -1.635e+04  3.198e+04  -0.511    0.610
#X4           2.650e+05  5.012e+05   0.529    0.598
#X5          -2.531e+06  4.878e+06  -0.519    0.605
#X6           1.572e+07  3.151e+07   0.499    0.619
#X7          -6.694e+07  1.405e+08  -0.477    0.635
#X8           2.008e+08  4.406e+08   0.456    0.650
#X9          -4.264e+08  9.746e+08  -0.437    0.663
#X10          6.291e+08  1.490e+09   0.422    0.674
#X11         -6.061e+08  1.480e+09  -0.410    0.683
#X12          3.124e+08  7.821e+08   0.399    0.691
#X13                 NA         NA      NA       NA
#X14         -7.955e+07  2.066e+08  -0.385    0.701
#X15                 NA         NA      NA       NA
#X16          3.194e+07  8.501e+07   0.376    0.708
#X17                 NA         NA      NA       NA
#X18         -1.090e+07  2.950e+07  -0.370    0.713
#X19                 NA         NA      NA       NA
#X20          2.271e+06  6.218e+06   0.365    0.716
#X21                 NA         NA      NA       NA
#X22                 NA         NA      NA       NA
#X23         -1.257e+05  3.494e+05  -0.360    0.720
#X24                 NA         NA      NA       NA
#X25                 NA         NA      NA       NA
#
#Residual standard error: 0.09237 on 83 degrees of freedom
#Multiple R-squared: 0.986,      Adjusted R-squared: 0.9831 
#F-statistic: 343.8 on 17 and 83 DF,  p-value: < 2.2e-16 

# Snippet 10
summary(lm(Y ~ poly(X, degree = 25), data = df))
#Call:
#lm(formula = Y ~ poly(X, degree = 25), data = df)
#
#Residuals:
#      Min        1Q    Median        3Q       Max 
# -0.211435 -0.040653  0.005966  0.040225  0.221436 
#
#Coefficients:
#Estimate Std. Error t value Pr(>|t|)    
#(Intercept)             1.017e-02  9.114e-03   1.116   0.2682    
#poly(X, degree = 25)1  -5.455e+00  9.159e-02 -59.561  < 2e-16 ***
#poly(X, degree = 25)2  -3.939e-02  9.159e-02  -0.430   0.6684    
#poly(X, degree = 25)3   4.418e+00  9.159e-02  48.236  < 2e-16 ***
#poly(X, degree = 25)4  -4.797e-02  9.159e-02  -0.524   0.6020    
#poly(X, degree = 25)5  -7.065e-01  9.159e-02  -7.713 4.19e-11 ***
#poly(X, degree = 25)6  -2.042e-01  9.159e-02  -2.230   0.0288 *  
#poly(X, degree = 25)7  -5.134e-02  9.159e-02  -0.561   0.5768    
#poly(X, degree = 25)8  -3.100e-02  9.159e-02  -0.338   0.7360    
#poly(X, degree = 25)9   7.723e-02  9.159e-02   0.843   0.4018    
#poly(X, degree = 25)10  4.809e-02  9.159e-02   0.525   0.6011    
#poly(X, degree = 25)11  1.300e-01  9.159e-02   1.419   0.1600    
#poly(X, degree = 25)12  2.473e-02  9.159e-02   0.270   0.7879    
#poly(X, degree = 25)13  2.371e-02  9.159e-02   0.259   0.7965    
#poly(X, degree = 25)14  8.791e-02  9.159e-02   0.960   0.3403    
#poly(X, degree = 25)15 -1.346e-02  9.159e-02  -0.147   0.8836    
#poly(X, degree = 25)16 -2.613e-05  9.159e-02   0.000   0.9998    
#poly(X, degree = 25)17  3.501e-02  9.159e-02   0.382   0.7034    
#poly(X, degree = 25)18 -1.372e-01  9.159e-02  -1.498   0.1384    
#poly(X, degree = 25)19 -6.913e-02  9.159e-02  -0.755   0.4528    
#poly(X, degree = 25)20 -6.793e-02  9.159e-02  -0.742   0.4606    
#poly(X, degree = 25)21 -1.093e-01  9.159e-02  -1.193   0.2365    
#poly(X, degree = 25)22  1.367e-01  9.159e-02   1.493   0.1397    
#poly(X, degree = 25)23 -3.921e-02  9.159e-02  -0.428   0.6698    
#poly(X, degree = 25)24 -5.032e-02  9.159e-02  -0.549   0.5844    
#poly(X, degree = 25)25  1.262e-01  9.159e-02   1.378   0.1722    
#---
#Signif. codes:  0 e***f 0.001 e**f 0.01 e*f 0.05 e.f 0.1 e f 1 
#
#Residual standard error: 0.09159 on 75 degrees of freedom
#Multiple R-squared: 0.9876,     Adjusted R-squared: 0.9834 
#F-statistic: 238.1 on 25 and 75 DF,  p-value: < 2.2e-16 

# Snippet 11
#poly.fit <- lm(Y ~ poly(X, degree = 1), data = df)
#df <- transform(df, PredictedY = predict(poly.fit))
#
#ggplot(df, aes(x = X, y = PredictedY)) +
#  geom_point() +
#  geom_line()
#
#poly.fit <- lm(Y ~ poly(X, degree = 3), data = df)
#df <- transform(df, PredictedY = predict(poly.fit))
#
#ggplot(df, aes(x = X, y = PredictedY)) +
#  geom_point() +
#  geom_line()
#
#poly.fit <- lm(Y ~ poly(X, degree = 5), data = df)
#df <- transform(df, PredictedY = predict(poly.fit))
#
#ggplot(df, aes(x = X, y = PredictedY)) +
#  geom_point() +
#  geom_line()
#
#poly.fit <- lm(Y ~ poly(X, degree = 25), data = df)
#df <- transform(df, PredictedY = predict(poly.fit))
#
#ggplot(df, aes(x = X, y = PredictedY)) +
#  geom_point() +
#  geom_line()
poly.frame <- data.frame()
for (d in c(1,3,5,25))
{
  poly.fit <- lm(Y ~ poly(X, degree=d), data=df)
  poly.frame <- rbind(poly.frame,
                      data.frame(Degree = d,
		                 X = x,
				 PredictedY = predict(poly.fit)))
}
ggplot(poly.frame, aes(x=X, y=PredictedY)) +
  geom_point() +
  geom_line() +
  facet_wrap(~Degree, nrow=2, ncol=2) +
  opts(title='Fig. 6-5: Polynomial Regression for Varying Degrees', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images', 'Fig_6-5.png'))

# Snippet 12
set.seed(1)

x <- seq(0, 1, by = 0.01)
y <- sin(2 * pi * x) + rnorm(length(x), 0, 0.1)

# Snippet 13
n <- length(x)

indices <- sort(sample(1:n, round(0.5 * n)))

training.x <- x[indices]
training.y <- y[indices]

test.x <- x[-indices]
test.y <- y[-indices]

training.df <- data.frame(X = training.x, Y = training.y)
test.df <- data.frame(X = test.x, Y = test.y)

# Snippet 14
rmse <- function(y, h)
{
  return(sqrt(mean((y - h) ^ 2)))
}

# Snippet 15
performance <- data.frame()

for (d in 1:12)
{
  poly.fit <- lm(Y ~ poly(X, degree = d), data = training.df)

  performance <- rbind(performance,
                       data.frame(Degree = d,
                                  Data = 'Training',
                                  RMSE = rmse(training.y, predict(poly.fit))))

  performance <- rbind(performance,
                       data.frame(Degree = d,
                                  Data = 'Test',
                                  RMSE = rmse(test.y, predict(poly.fit,
                                                              newdata = test.df))))
}

# Snippet 16
ggplot(performance, aes(x=Degree, y=RMSE, linetype=Data, colour=Data)) +
  geom_point() +
  geom_line() +
  opts(title='Fig. 6-6: Cross-validation', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images', 'Fig_6-6.png'))

# Snippet 17
lm.fit <- lm(y ~ x)
model.complexity <- sum(coef(lm.fit) ^ 2)

# Snippet 18
lm.fit <- lm(y ~ x)
l2.model.complexity <- sum(coef(lm.fit) ^ 2)
l1.model.complexity <- sum(abs(coef(lm.fit)))

# Snippet 19
set.seed(1)

x <- seq(0, 1, by = 0.01)
y <- sin(2 * pi * x) + rnorm(length(x), 0, 0.1)

# Snippet 20
x <- matrix(x)

library('glmnet')

glmnet(x, y)

#Call: glmnet(x = x, y = y)
#
# Df %Dev Lambda
# [1,] 0 0.00000 0.542800
# [2,] 1 0.09991 0.494600
# [3,] 1 0.18290 0.450700
# [4,] 1 0.25170 0.410600
# [5,] 1 0.30890 0.374200
#...
#[51,] 1 0.58840 0.005182
#[52,] 1 0.58840 0.004721
#[53,] 1 0.58850 0.004302
#[54,] 1 0.58850 0.003920
#[55,] 1 0.58850 0.003571

# Snippet 21
set.seed(1)

x <- seq(0, 1, by = 0.01)
y <- sin(2 * pi * x) + rnorm(length(x), 0, 0.1)

n <- length(x)

indices <- sort(sample(1:n, round(0.5 * n)))

training.x <- x[indices]
training.y <- y[indices]

test.x <- x[-indices]
test.y <- y[-indices]

df <- data.frame(X = x, Y = y)

training.df <- data.frame(X = training.x, Y = training.y)
test.df <- data.frame(X = test.x, Y = test.y)

rmse <- function(y, h)
{
  return(sqrt(mean((y - h) ^ 2)))
}

# Snippet 22
library('glmnet')

glmnet.fit <- with(training.df, glmnet(poly(X, degree = 10), Y))

lambdas <- glmnet.fit$lambda

performance <- data.frame()

for (lambda in lambdas)
{
  h <- with(test.df, predict(glmnet.fit, poly(X, degree = 10), s = lambda)) 
  performance <- rbind(performance,
                       data.frame(Lambda = lambda,
                                  RMSE = rmse(test.y, h)))
}

# Snippet 23
s23.plot <- ggplot(performance, aes(x = Lambda, y = RMSE)) +
  geom_point() +
  geom_line() +
  opts(title = 'Fig. 6-7: Varying lambda parameter in regularization, w/out scaling', 
       plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images', 'Fig_6-7.png'))

# Alternative plot not shown in the book.
s23a.plot <- ggplot(performance, aes(x = Lambda, y = RMSE)) +
  geom_point() +
  geom_line() +
  scale_x_log10() +
  opts(title = 'Fig. 6-7: Varying lambda parameter in regularization w/ scaling', 
       plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images', 'Fig_6-7_alt.png'))

# Snippet 24
best.lambda <- with(performance, Lambda[which(RMSE == min(RMSE))])

glmnet.fit <- with(df, glmnet(poly(X, degree = 10), Y))

# Snippet 25
coef(glmnet.fit, s = best.lambda)

#11 x 1 sparse Matrix of class "dgCMatrix"
#                      1
# (Intercept)  0.0101667
# 1           -5.2132586
# 2            .        
# 3            4.1759498
# 4            .        
# 5           -0.4643476
# 6            .        
# 7            .        
# 8            .        
# 9            .        
# 10           .        

# Snippet 26
ranks <- read.csv(file.path('data', 'oreilly.csv'), stringsAsFactors = FALSE)

library('tm')

documents <- data.frame(Text = ranks$Long.Desc.)
row.names(documents) <- 1:nrow(documents)

corpus <- Corpus(DataframeSource(documents))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords('english'))

dtm <- DocumentTermMatrix(corpus)

# Snippet 27
x <- as.matrix(dtm)
y <- rev(1:100)

# Snippet 28
set.seed(1)

library('glmnet')

# Snippet 29
performance <- data.frame()

for (lambda in c(0.1, 0.25, 0.5, 1, 2, 5))
{
  for (i in 1:50)
  {
    indices <- sample(1:100, 80)
    
    training.x <- x[indices, ]
    training.y <- y[indices]
    
    test.x <- x[-indices, ]
    test.y <- y[-indices]
    
    glm.fit <- glmnet(training.x, training.y)
    
    predicted.y <- predict(glm.fit, test.x, s = lambda)
    
    rmse <- sqrt(mean((predicted.y - test.y) ^ 2))

    performance <- rbind(performance,
                         data.frame(Lambda = lambda,
                                    Iteration = i,
                                    RMSE = rmse))
  }
}

# Snippet 30
s30.plot <- ggplot(performance, aes(x = Lambda, y = RMSE)) +
  ylim(20, 40) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'point') +
  opts(title = 'Fig. 6-8: Results of varying lambda parameter', 
       plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images', 'Fig_6-8.png'))


# Snippet 30.5
# Fig. 6-8 is supposed to show that this is a failure to fit
# a statistical model to this data, but it is difficult to see
# that. Let's try adding more Lambda points, and seeing how 
# Lambda relates to RMSE...
perf2 <- data.frame()

for (lambda in seq(0.1, 10.0, 0.1))
{
  for (i in 1:50)
  {
    indices <- sample(1:100, 80)
    
    training.x <- x[indices, ]
    training.y <- y[indices]
    
    test.x <- x[-indices, ]
    test.y <- y[-indices]
    
    glm.fit <- glmnet(training.x, training.y)
    
    predicted.y <- predict(glm.fit, test.x, s = lambda)
    
    rmse <- sqrt(mean((predicted.y - test.y) ^ 2))

    perf2 <- rbind(perf2,
                   data.frame(Lambda = lambda,
                              Iteration = i,
                              RMSE = rmse))
  }
}
# ... generate a plot and see...
s30a.plot <- ggplot(perf2, aes(x = Lambda, y = RMSE)) +
  ylim(20, 40) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'point') +
  opts(title = 'Fig. 6-8a: Adding more Lambda values to our range', 
       plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images', 'Fig_6-8_alt.png'))



# Snippet 31
y <- rep(c(1, 0), each = 50)

# Snippet 32
regularized.fit <- glmnet(x, y, family = 'binomial')

# Snippet 33
regularized.fit <- glmnet(x, y)

regularized.fit <- glmnet(x, y, family = 'gaussian')

regularized.fit <- glmnet(x, y, family = 'binomial')

# Snippet 34
predict(regularized.fit, newx = x, s = 0.001)
#1 4.884576
#2 6.281354
#3 4.892129
#...
#98 -5.958003
#99 -5.677161
#100 -4.956271

# Snippet 35
ifelse(predict(regularized.fit, newx = x, s = 0.001) > 0, 1, 0)
#1 1
#2 1
#3 1
#...
#98 0
#99 0
#100 0

# Snippet 36
library('boot')

inv.logit(predict(regularized.fit, newx = x, s = 0.001))
#1 0.992494427
#2 0.998132627
#3 0.992550485
#...
#98 0.002578403
#99 0.003411583
#100 0.006989922

# Snippet 37
set.seed(1)

performance <- data.frame()

for (i in 1:250)
{
  indices <- sample(1:100, 80)
  
  training.x <- x[indices, ]
  training.y <- y[indices]
  
  test.x <- x[-indices, ]
  test.y <- y[-indices]
  
  for (lambda in c(0.0001, 0.001, 0.0025, 0.005, 0.01, 0.025, 0.5, 0.1))
  {
    glm.fit <- glmnet(training.x, training.y, family = 'binomial')
    
    predicted.y <- ifelse(predict(glm.fit, test.x, s = lambda) > 0, 1, 0)
    
    error.rate <- mean(predicted.y != test.y)

    performance <- rbind(performance,
                         data.frame(Lambda = lambda,
                                    Iteration = i,
                                    ErrorRate = error.rate))
  }
}

# Snippet 38
library('scales')
s38.plot <- ggplot(performance, aes(x = Lambda, y = ErrorRate)) +
  xlim(1e-4, 1e-1) +
  ylim(0.2, 0.8) +
  stat_summary(fun.data='mean_cl_boot', geom='errorbar') +
  stat_summary(fun.data='mean_cl_boot', geom='point') +
  scale_x_log10(breaks=trans_breaks('log10', function(x) 10^x),
                labels=trans_format('log10', math_format(10^.x))) + 
  opts(title = 'Fig. 6-9: Error rates for classifying books', 
       plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images', 'Fig_6-9.png'))
