# NOTES: Ch. 6 - Regularization: Text Regression

### Tips & Tricks 
- `indices <- sort(sample(1:n, round(0.5 * n)))` will assign a list of random indices ranging from `1` to `n`; good for splitting up an vector of data into training and test indices.

### On Polynomial Regression
- A non-linear relation between X and Y can be naively transformed into a linear one by adding powers of X.
- However, doing so introduces larger and larger powers of X that are too closely correlated with the old columns such that no coefficients can be found (*singularities*).
- When the relationship between X and Y cannot be described *linearly*, `poly` can be used to transform a non-linear relation into a linear one by using *orthogonal polynomials*.
- *cross-validation* simulates testing a model on future data by ignoring a part of our historical data in the model-fitting process, and then using that data as a test target.


### Observations
-
