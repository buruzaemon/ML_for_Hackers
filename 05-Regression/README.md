# NOTES: Ch. 5 - Regression: Predicting Page Views #

### Tips & Tricks 
- `with` with evaluate an expression on the specified dataframe, list, or environment. Similar to `transform` when using the `within` variant as it can modify the dataframe or list argument. Like reduce.
- `lm` calculates a linear model based on the given regression formula. A simple example is predicting a response from the given terms.
- Mean Squared Error (MSE) is a simple barometer for summarizing the quality of a linear regression model. `
- Root Mean Squared Error (RMSE) is a more popular measure of performance for machine learning. `sqrt(mean(residuals(fitted.regression ^ 2)))`

### Observations
- R's lack of namespaces is a fundamental short-coming.
