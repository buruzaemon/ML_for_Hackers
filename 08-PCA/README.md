# NOTES: Ch. 8 - PCA: Building a Market Index

### Tips & Tricks 
- As you cannot assume data type when reading in data files, you will often have to transform data before you can use it.
- `lubridate` package's `ymd` parses date and transforms to a formatted string representation in the given timezone (default to UTC).
- `reshape` package's `melt` melts an object (data.frame, array, list) into a form that is easy to `cast`.
   - specify which fields are fixed (Identifier variables) and numerical (Measured variables)
- `reshape` package's `cast` will alter a data frame into the specified shape or aggregated form.
   - think of pivot tables

### Observations
- Steps for using PCA
  1. calculate correlations between columns in data matrix with `cor`
  2. visually inspect a density plot; iff correlations are mostly positive, then PCA should work for given data set
  3. calculate principal components matrix with `princomp`
  4. confirm standard deviations and proportions of variance per component; 1st one should be the one to choose, as the components are already returned in order of decreasing importance (eigenvalue???)
  5. create a one-column (principal column) summary of data set with `predict(pca)[,1]`
  6. compare this PCA summary with actual data from a known-quantity, perhaps by plotting both in `ggplot`
```
    ggplot(comparison.df, aes(x = Date, y = Price, group = Index, color = Index))+
      geom_point() +
      geom_line()
```
- Interesting [question on `princomp` function in R](http://stats.stackexchange.com/questions/32901/do-components-of-pca-really-represent-percentage-of-variance-can-they-sum-to-mo) on Cross Validated
- Yet another interesting question re: [PCA on Correlation or Covariance?](http://stats.stackexchange.com/questions/53/pca-on-correlation-or-covariance)

