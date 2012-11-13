# NOTES: Ch. 10 - kNN: Recommendation Systems

### Tips & Tricks 
- correlations can be used as a basis for distance:

  ```
  # recall that correlations range from -1 to 1
  similarities <- cor(x.y.data.matrix)

  # also recall the nature of logarithms
  distances <- -log((similarities / 2) + 0.5)
  ````

  ![correlation-to-distance conversion](https://github.com/buruzaemon/ML_for_Hackers/tree/master/10-Recommendations/images/cor-to-dist.png)

### Observations
- _k-Nearest Neighbors_ one of the most intuitive and simple algorithms for classification where [linear][https://github.com/buruzaemon/ML_for_Hackers/tree/master/05-Regression] and [logistic][https://github.com/buruzaemon/ML_for_Hackers/tree/master/06-Regularization] regression may not be applicable.
- Steps for k-Nearest Neighbors calculation are:
  1. visually inspect the set of points with `ggplot` to confirm that other classification methods won't work
  2. compute the distances between all points in the set
  3. return the k-nearest points based on distance calculated in 2. above
  4. cross-validate, and compare with a polynomial regression
