# NOTES: Ch. 2 - Data Exploration #

### Tips & Tricks 
- `seq(0, 1, by=0.n)` generates a sequence of decimals from 0.0 to 1.0 with interval 0.n

### Handy vector functions 
1. `length` 
2. `sum` 
3. `mean` 
4. `var` 
5. `sd` 
6. `quantile` 

### ggplot
1. `geom_histogram` renders a histogram, which divides the data up into bins and counts how many items fall into each bin
2. `geom_density` renders kernel density estimates or density plots
3. `geom_points` renders a scatter plot
4. `geom_points + geom_smooth` renders a scatter plot and a separating hyperplane (classification)
5. A feature of a dataset can also be represented with colors, using the `color` argument of the `aes` call in `ggplot` (c.f. Snippet 34, alternative using bright colors)

### On distributions
1. Random normal distributions can be generated with `rnorm(n, mean, sd)`
2. Random Cauchy distributions can be generated with `rcauchy(n, location, scale)`
3. Random Gamma distributions can be generated with `rgamma(n, shape, rate, scale)`
