# NOTES: Ch. 8 - PCA: Building a Market Index

### Tips & Tricks 
- As you cannot assume data type when reading in data files, you will often have to transform data before you can use it.
- `lubridate` package's `ymd` parses date and transforms to a formatted string representation in the given timezone (default to UTC).
- `reshape` package's `melt` melts an object (data.frame, array, list) into a form that is easy to `cast`.
   - specify which fields are fixed (Identifier variables) and numerical (Measured variables)
- `reshape` package's `cast` will alter a data frame into the specified shape or aggregated form.
   - think of pivot tables
- `cor` argument `method` defaults to `pearson`, but also accepts `spearman` and `kendall`
   - `pearson` is the default, handles most data distributions well if there are few outliers
   - `spearman` and `kendall` are more robust than `pearson` when the data distribution is non-normal and/or skewed; with outliers; and is of ordinal (e.g., satisfaction on scale of 1-5, etc.) rather than interval (e.g., temperature) nature
   - *always* draw a data plot to see how the data is distributed; based on this, choose the correct `cor` method
   - c.f. [What could cause big differences in correlation coefficient between Pearson's and Spearman's correlation for a given dataset?](http://stats.stackexchange.com/questions/11746/what-could-cause-big-differences-in-correlation-coefficient-between-pearsons-an?lq=1)

### Observations
- `prcomp` vs `princomp`
  - `prcomp` 
     1. uses singular value decomposition
     2. variances computed with the usual `n-1`
     3. Q-mode PCA (attempts to reduce complexity of questions/samples, or _rows_)
     4. `prcomp` is the preferred method for numerical accuracy
  - `princomp` 
     1. uses `eigen` on the covariance matrix
     2. variances computed with the `n`
     3. _only_ handles R-mode PCA (reduces complexity of variables, or _columns_)
     4. Interesting [question on `princomp` function in R](http://stats.stackexchange.com/questions/32901/do-components-of-pca-really-represent-percentage-of-variance-can-they-sum-to-mo) on Cross Validated
  - _covariance_ vs _correlation_
     1. When the variables are on a similar scale, use a covariance matrix
     2. Else use a correlation matrix, which standardizes the values
     3. Yet another interesting question re: [PCA on Correlation or Covariance?](http://stats.stackexchange.com/questions/53/pca-on-correlation-or-covariance)
- Steps for using PCA, R-mode
  1. calculate correlations between columns in data matrix with `cor`
  2. visually inspect a density plot; _iff_ correlations are mostly positive, then PCA should work for given data set
  3. calculate principal components matrix with `princomp`
  4. confirm standard deviations and proportions of variance per component; 1st one should be the one to choose, as the components are already returned in order of decreasing importance (eigenvalue???)
  5. create a one-column (principal column) summary of data set with `predict(pca)[,1]`
  6. compare this PCA summary with actual data from a known-quantity, perhaps by plotting both in `ggplot`
```
    ggplot(comparison.df, aes(x = Date, y = Price, group = Index, color = Index))+
      geom_point() +
      geom_line()
```

