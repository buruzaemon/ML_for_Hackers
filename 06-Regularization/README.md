# NOTES: Ch. 6 - Regularization: Text Regression

### Tips & Tricks 
- `indices <- sort(sample(1:n, round(0.5 * n)))` will assign a list of `n/2` random indices ranging from `1` to `n`; good for splitting up a vector of data into training and test indices.

### On Polynomial Regression
- A non-linear relation between X and Y can be naively transformed into a linear one by adding powers of X.
- However, doing so introduces larger and larger powers of X that are too closely correlated with the old columns such that no coefficients can be found (*singularities*).
- Model complexity can be described with:
   - *L2 norm*: sum of squares of coefficients in a model
   - *L1 norm*: sum of absolute value of model coefficients
- When the relationship between X and Y cannot be described linearly, `poly` can be used *to transform a non-linear relation into a linear one by using orthogonal polynomials*.
- *cross-validation* simulates testing a model on future data by ignoring a part of our historical data in the model-fitting process, and then using that data as a test target.
- *regularization* attempts to prevent overfitting of a model by reducing its complexity.
- `glmnet` fits linear models using regularization (returns entire set of possible regression regularizations)
   - `Df`: number of non-zero coefficients in model, not including intercept
   - `%Dev`: essentially the R<sup>2</sup> for this model
   - `Lambda`: hyperparameter of model that controls the values of the other model parameters

### Observations
- *regularization* gives higher performance with a trade-off with a simple regression model for a more complex one.
- Switching from a prediction (*regression*) model to classification one gives better performance, since the requirements for binary distinction are weaker than that for predicting rank.
