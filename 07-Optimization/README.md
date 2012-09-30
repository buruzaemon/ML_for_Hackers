# NOTES: Ch. 7 - Optimization: Breaking Codes

### Tips & Tricks 
- `optim` takes the following arguments:
   1. vector of default values as starting points for parameters in question (`c(0, 0)`)
   2. function to optimize that accepts a vector of arguments
- An example:
```
    df <- read.csv('some/csv/data.csv')
    
    line.func <- function(x, a, b)
    {
        return(a + b * x)
    }

    sq.error <- function(df, a, b)
    {
        predictions <- with(df, line.func(X.in.df, a, b))
	errors <- with(df, Y.in.df - predictions)
	return(sum(errors^2))
    }

    optim( c(0, 0,
           function(x) 
	   {
	       sq.error(df, a, b)
	   } )
```
- `optim(...)$par` yields the values that optimize the given function.
- `optim(...)$convergence` will be `0` if a set of parameters optimizing the given function are found.
- `optim(...)$message` provides clues when the optimization cannot be done.

### Observations
- In general, algorithms in machine learning can be seen as *optimization problems*.
- *Optimation* attempts to minimize some measure of prediction error in a regression model.
- `lm` uses its own optimization logic, specific to *linear* regression (c.f. `coef`).
