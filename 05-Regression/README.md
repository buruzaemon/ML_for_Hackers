# NOTES: Ch. 5 - Regression: Predicting Page Views #

### Tips & Tricks 
- `with` evaluates an expression on the specified dataframe, list, or environment. Similar to `transform` when using the `within` variant as it can modify the dataframe or list argument. Like reduce.
- `lm` calculates a linear model based on the given regression formula. A simple example is predicting a response from the given terms.
- Mean Squared Error (MSE) is a simple barometer for summarizing the quality of a linear regression model. 
- Root Mean Squared Error (RMSE) is a more popular measure of performance for machine learning. `sqrt(mean(residuals(fitted.regression ^ 2)))`
- R<sup>2</sup>, or R squared, is a measure of how much better a model is at predicting output compared to simply using the mean. Derived by `1 - (model.rmse / mean.rmse)`. 

### On Linear Regression and Modelling
- During the exploratory phase of modelling, determine if the dependent variable Y has a linear relation with independent variable X.
   - use `ggplot` with `geom_smooth(method="lm")` to see if the scatterplot could contain a regression line for predicting Y from X
   - use `plot` with `which=1` to make sure that the residuals plot is irregular and random
- If such plots look nonsensical or impenetrable, try a density plot of log-transformed values.
- In the `summary` of a linear regression, the `t value` column of the `Coeffecients` section is the number of standard deviations (`Std. Error` column value) the `Estimate` is away from 0. The higher this `t value` is, the greater the confidence in this factor actually predicting the output. A value of 2 or greater is the general measure. 0 would mean that there is no correlation between the predictor and output.
- The `Residual standard error` is the RMSE for the model used.
- The `Multiple R-squared` value is the R squared value. 
- The R squared values <i>vis a vis</i> each of the regression inputs in isolation can be used to see the predictive power, individually. c.f. `summary(lm(...))$r.squared`

### On Correlation
- `cor` can be used to calculate the correlation between two variables.
- Correlation can also be derived from `lm` by scaling (subtracting the mean of both variables and then dividing by the standard deviation). However, if the values are very large, you will need to use log-transformed values: `coef(lm(scale(log(y)) ~ scale(log(x)), data=...))`

### Observations
- R's lack of namespaces is a fundamental short-coming.
