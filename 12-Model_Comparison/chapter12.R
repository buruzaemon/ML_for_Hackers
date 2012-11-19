# File-Name:       chapter12.R           
# Date:            2012-02-10                                
# Author:          Drew Conway (drew.conway@nyu.edu) and John Myles White (jmw@johnmyleswhite.com)                                                                    
# Purpose:         
# Data Used:       data/df.csv, dtm.RData
# Packages Used:   ggplot2, glmnet, tm, boot

# All source code is copyright (c) 2012, under the Simplified BSD License.  
# For more information on FreeBSD see: http://www.opensource.org/licenses/bsd-license.php

# All images and materials produced by this code are licensed under the Creative Commons 
# Attribution-Share Alike 3.0 United States License: http://creativecommons.org/licenses/by-sa/3.0/us/

# All rights reserved.

# NOTE: If you are running this in the R console you must use the 'setwd' command to set the 
# working directory for the console to whereever you have saved this file prior to running.
# Otherwise you will see errors when loading data or saving figures!

library(ggplot2)
library(reshape)

# Snippet 1
df <- read.csv(file.path('data', 'df.csv'))

ggplot(df, aes(x=X, y=Y, color=factor(Label))) + 
    geom_point() +
    opts(title='Fig. 12-1: Classification, non-linear decision boundary', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-1.png'))

logit.fit <- glm(Label ~ X + Y,
                 family = binomial(link = 'logit'),
                 data = df)

logit.predictions <- ifelse(predict(logit.fit) > 0, 1, 0)

mean(with(df, logit.predictions == Label))
#[1] 0.5156

mean(with(df, 0 == Label))
#[1] 0.5156

# Snippet 2
library(e1071)

svm.fit <- svm(Label ~ X + Y, data = df)
svm.predictions <- ifelse(predict(svm.fit) > 0, 1, 0)
mean(with(df, svm.predictions == Label))
#[1] 0.7204

# Snippet 3
df <- cbind(df,
            data.frame(Logit = ifelse(predict(logit.fit) > 0, 1, 0),
                       SVM = ifelse(predict(svm.fit) > 0, 1, 0)))

predictions <- melt(df, id.vars = c('X', 'Y'))

ggplot(predictions, aes(x = X, y = Y, color = factor(value))) +
    geom_point() +
    facet_grid(variable ~ .) +
    opts(title = 'Fig. 12-2: Logistic (glm) vs. SVM', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-2.png'))

# Snippet 4
df <- df[, c('X', 'Y', 'Label')]

linear.svm.fit <- svm(Label ~ X + Y, data = df, kernel = 'linear')
with(df, mean(Label == ifelse(predict(linear.svm.fit) > 0, 1, 0)))

polynomial.svm.fit <- svm(Label ~ X + Y, data = df, kernel = 'polynomial')
with(df, mean(Label == ifelse(predict(polynomial.svm.fit) > 0, 1, 0)))

radial.svm.fit <- svm(Label ~ X + Y, data = df, kernel = 'radial')
with(df, mean(Label == ifelse(predict(radial.svm.fit) > 0, 1, 0)))

sigmoid.svm.fit <- svm(Label ~ X + Y, data = df, kernel = 'sigmoid')
with(df, mean(Label == ifelse(predict(sigmoid.svm.fit) > 0, 1, 0)))

df <- cbind(df,
            data.frame(LinearSVM = ifelse(predict(linear.svm.fit) > 0, 1, 0),
                       PolynomialSVM = ifelse(predict(polynomial.svm.fit) > 0, 1, 0),
                       RadialSVM = ifelse(predict(radial.svm.fit) > 0, 1, 0),
                       SigmoidSVM = ifelse(predict(sigmoid.svm.fit) > 0, 1, 0)))

predictions <- melt(df, id.vars = c('X', 'Y'))

ggplot(predictions, aes(x = X, y = Y, color = factor(value))) +
    geom_point() +
    facet_grid(variable ~ .) +
    opts(title = 'Fig. 12-3: SVM Kernels (linear, polynomial, radial, sigmoid)', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-3.png'))

# Snippet 5
polynomial.degree3.svm.fit <- svm(Label ~ X + Y,
                                  data = df,
                                  kernel = 'polynomial',
                                  degree = 3)
with(df, mean(Label != ifelse(predict(polynomial.degree3.svm.fit) > 0, 1, 0)))
#[1] 0.5156

polynomial.degree5.svm.fit <- svm(Label ~ X + Y,
                                  data = df,
                                  kernel = 'polynomial',
                                  degree = 5)
with(df, mean(Label != ifelse(predict(polynomial.degree5.svm.fit) > 0, 1, 0)))
#[1] 0.5156

polynomial.degree10.svm.fit <- svm(Label ~ X + Y,
                                   data = df,
                                   kernel = 'polynomial',
                                   degree = 10)
with(df, mean(Label != ifelse(predict(polynomial.degree10.svm.fit) > 0, 1, 0)))
#[1] 0.4388

polynomial.degree12.svm.fit <- svm(Label ~ X + Y,
                                   data = df,
                                   kernel = 'polynomial',
                                   degree = 12)
with(df, mean(Label != ifelse(predict(polynomial.degree12.svm.fit) > 0, 1, 0)))
#[1] 0.4464

# Snippet 6
df <- df[, c('X', 'Y', 'Label')]

df <- cbind(df,
            data.frame(Degree3SVM = ifelse(predict(polynomial.degree3.svm.fit) > 0, 1, 0),
                       Degree5SVM = ifelse(predict(polynomial.degree5.svm.fit) > 0, 1, 0),
                       Degree10SVM = ifelse(predict(polynomial.degree10.svm.fit) > 0, 1, 0),
                       Degree12SVM = ifelse(predict(polynomial.degree12.svm.fit) > 0, 1, 0)))

predictions <- melt(df, id.vars = c('X', 'Y'))

ggplot(predictions, aes(x = X, y = Y, color = factor(value))) +
    geom_point() +
    facet_grid(variable ~ .) +
    opts(title = 'Fig. 12-4: polynomial kernel and degree tuning', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-4.png'))

# Snippet 7
radial.cost1.svm.fit <- svm(Label ~ X + Y,
                            data = df,
                            kernel = 'radial',
                            cost = 1)
with(df, mean(Label == ifelse(predict(radial.cost1.svm.fit) > 0, 1, 0)))
#[1] 0.7204

radial.cost2.svm.fit <- svm(Label ~ X + Y,
                            data = df,
                            kernel = 'radial',
                            cost = 2)
with(df, mean(Label == ifelse(predict(radial.cost2.svm.fit) > 0, 1, 0)))
#[1] 0.7052

radial.cost3.svm.fit <- svm(Label ~ X + Y,
                            data = df,
                            kernel = 'radial',
                            cost = 3)
with(df, mean(Label == ifelse(predict(radial.cost3.svm.fit) > 0, 1, 0)))
#[1] 0.6996

radial.cost4.svm.fit <- svm(Label ~ X + Y,
                            data = df,
                            kernel = 'radial',
                            cost = 4)
with(df, mean(Label == ifelse(predict(radial.cost4.svm.fit) > 0, 1, 0)))
#[1] 0.694

# Snippet 8
df <- df[, c('X', 'Y', 'Label')]

df <- cbind(df,
            data.frame(Cost1SVM = ifelse(predict(radial.cost1.svm.fit) > 0, 1, 0),
                       Cost2SVM = ifelse(predict(radial.cost2.svm.fit) > 0, 1, 0),
                       Cost3SVM = ifelse(predict(radial.cost3.svm.fit) > 0, 1, 0),
                       Cost4SVM = ifelse(predict(radial.cost4.svm.fit) > 0, 1, 0)))

predictions <- melt(df, id.vars = c('X', 'Y'))

ggplot(predictions, aes(x = X, y = Y, color = factor(value))) +
    geom_point() +
    facet_grid(variable ~ .) +
    opts(title = 'Fig. 12-5: radial kernel and cost tuning', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-5.png'))

# Snippet 9
sigmoid.gamma1.svm.fit <- svm(Label ~ X + Y,
                              data = df,
                              kernel = 'sigmoid',
                              gamma = 1)
with(df, mean(Label == ifelse(predict(sigmoid.gamma1.svm.fit) > 0, 1, 0)))
#[1] 0.478

sigmoid.gamma2.svm.fit <- svm(Label ~ X + Y,
                              data = df,
                              kernel = 'sigmoid',
                              gamma = 2)
with(df, mean(Label == ifelse(predict(sigmoid.gamma2.svm.fit) > 0, 1, 0)))
#[1] 0.4824

sigmoid.gamma3.svm.fit <- svm(Label ~ X + Y,
                              data = df,
                              kernel = 'sigmoid',
                              gamma = 3)
with(df, mean(Label == ifelse(predict(sigmoid.gamma3.svm.fit) > 0, 1, 0)))
#[1] 0.4816

sigmoid.gamma4.svm.fit <- svm(Label ~ X + Y,
                              data = df,
                              kernel = 'sigmoid',
                              gamma = 4)
with(df, mean(Label == ifelse(predict(sigmoid.gamma4.svm.fit) > 0, 1, 0)))
#[1] 0.4824

# Snippet 10
df <- df[, c('X', 'Y', 'Label')]

df <- cbind(df,
            data.frame(Gamma1SVM = ifelse(predict(sigmoid.gamma1.svm.fit) > 0, 1, 0),
                       Gamma2SVM = ifelse(predict(sigmoid.gamma2.svm.fit) > 0, 1, 0),
                       Gamma3SVM = ifelse(predict(sigmoid.gamma3.svm.fit) > 0, 1, 0),
                       Gamma4SVM = ifelse(predict(sigmoid.gamma4.svm.fit) > 0, 1, 0)))

predictions <- melt(df, id.vars = c('X', 'Y'))

ggplot(predictions, aes(x = X, y = Y, color = factor(value))) +
    geom_point() +
    facet_grid(variable ~ .) + 
    opts(title = 'Fig. 12-6: sigmoid kernel and gamma tuning', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-6.png'))

# Snippet 11
load(file.path('data', 'dtm.RData'))

set.seed(1)

training.indices <- sort(sample(1:nrow(dtm), round(0.5 * nrow(dtm))))
test.indices <- which(! 1:nrow(dtm) %in% training.indices)

train.x <- dtm[training.indices, 3:ncol(dtm)]
train.y <- dtm[training.indices, 1]

test.x <- dtm[test.indices, 3:ncol(dtm)]
test.y <- dtm[test.indices, 1]

rm(dtm)

# Snippet 12
library('glmnet')
regularized.logit.fit <- glmnet(train.x, train.y, family = c('binomial'))

# Snippet 13
lambdas <- regularized.logit.fit$lambda

performance <- data.frame()

for (lambda in lambdas)
{
  predictions <- predict(regularized.logit.fit, test.x, s = lambda)
  predictions <- as.numeric(predictions > 0)
  mse <- mean(predictions != test.y)
  performance <- rbind(performance, data.frame(Lambda = lambda, MSE = mse))
}

# Without scaling the x values, it is difficult to see the minima
ggplot(performance, aes(x = Lambda, y = MSE)) +
  geom_point()  +
  opts(title = 'Fig. 12-7 (pre): before scale_x_log10', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-7-0.png'))

ggplot(performance, aes(x = Lambda, y = MSE)) +
  geom_point() +
  scale_x_log10() +
  opts(title = 'Fig. 12-7: finding the best lambda setting', plot.title=theme_text(size=12, face='bold'))
ggsave(filename=file.path('images','fig_12-7-1.png'))

# Snippet 14
best.lambda <- with(performance, max(Lambda[which(MSE == min(MSE))]))

# Snippet 15
mse <- with(subset(performance, Lambda == best.lambda), MSE)

mse
#[1] 0.06830769

# Snippet 16
library('e1071')
linear.svm.fit <- svm(train.x, train.y, kernel = 'linear')

# Snippet 17
predictions <- predict(linear.svm.fit, test.x)
predictions <- as.numeric(predictions > 0)

mse <- mean(predictions != test.y)
mse
#0.128

# Snippet 18
#
#   SVM radial kernel hyperparameter is 'cost'
#   let's try a small range and see...
#
tmp <- data.frame()
for (c in 1:10) {
  radial.svm.fit <- svm(train.x, train.y, kernel='radial', cost=c)
  predictions    <- predict(radial.svm.fit, test.x)
  predictions    <- as.numeric(predictions > 0)
  mse            <- mean(predictions != test.y)
  tmp            <- rbind(tmp, data.frame(Cost=c, MSE=mse))
}
tmp
#   Cost       MSE
#   1     1 0.1421538
#   2     2 0.1335385
#   3     3 0.1255385
#   4     4 0.1243077
#   5     5 0.1212308
#   6     6 0.1212308
#   7     7 0.1193846
#   8     8 0.1193846
#   9     9 0.1193846
#  10    10 0.1193846
with(tmp, min(MSE))

#radial.svm.fit <- svm(train.x, train.y, kernel = 'radial')
#predictions <- predict(radial.svm.fit, test.x)
#predictions <- as.numeric(predictions > 0)
#mse <- mean(predictions != test.y)
#mse
##[1] 0.1421538


# Extra Credit: svm, polynomial kernel
#
#   SVM polynomial kernel hyperparameter is 'degree'
#   let's try a small range and see...
#
tmp <- data.frame()
for (d in seq(3,15,2)) {
  polynomial.svm.fit <- svm(train.x, train.y, kernel = 'polynomial', degree=d)
  predictions        <- predict(polynomial.svm.fit, test.x)
  predictions        <- as.numeric(predictions > 0)
  mse                <- mean(predictions != test.y)
  tmp                <- rbind(tmp, data.frame(Degree=d, MSE=mse))
}
tmp
#  Degree       MSE
#  1      3 0.1440000
#  2      5 0.1452308
#  3      7 0.1458462
#  4      9 0.1464615
#  5     11 0.1476923
#  6     13 0.1476923
#  7     15 0.1476923
with(tmp, min(MSE))


# Extra Credit: svm, sigmoid kernel
#
#   SVM sigmoid kernel hyperparameter is 'gamma'
#   let's try a small range and see...
#
tmp <- data.frame()
for (g in 1:10) {
  sigmoid.svm.fit <- svm(train.x, train.y, kernel = 'sigmoid', gamma=g)
  predictions     <- predict(sigmoid.svm.fit, test.x)
  predictions     <- as.numeric(predictions > 0)
  mse             <- mean(predictions != test.y)
  tmp             <- rbind(tmp, data.frame(Gamma=g, MSE=mse))
}
tmp
#   Gamma       MSE
#   1      1 0.4652308
#   2      2 0.4541538
#   3      3 0.5169231
#   4      4 0.4596923
#   5      5 0.5181538
#   6      6 0.4578462
#   7      7 0.4584615
#   8      8 0.4590769
#   9      9 0.4590769
#  10     10 0.4627692
with(tmp, min(MSE))

# Snippet 19
library('class')

knn.fit <- knn(train.x, test.x, train.y, k = 50)

predictions <- as.numeric(as.character(knn.fit))

mse <- mean(predictions != test.y)

mse
#[1] 0.1396923

# Snippet 20
performance <- data.frame()

for (k in seq(5, 50, by = 5))
{
  knn.fit <- knn(train.x, test.x, train.y, k = k)
  predictions <- as.numeric(as.character(knn.fit))
  mse <- mean(predictions != test.y)
  performance <- rbind(performance, data.frame(K = k, MSE = mse))
}

best.k <- with(performance, K[which(MSE == min(MSE))])

best.mse <- with(subset(performance, K == best.k), MSE)

best.mse
#[1] 0.09169231
