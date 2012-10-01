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
- *Ridge regression* goes beyond plain-vanilla least squares regression by considering the *size* of the regression coefficients, and using *lambda* as a hyperparameter to minimize the prediction error to avoid over-fitting.
- `lambda` can be calculated by cross-validation (c.f. Ch. 6).
- `.Machine` can be used to reference machine-dependent sizes, minima and maxima, like `.Machine$double.eps` for lowest possible probability.
- `runif(n)` returns a vector with `n` random deviates; good for generating random probabilities.


### Observations
- In general, algorithms in machine learning can be seen as *optimization problems*.
- *Optimization* attempts to minimize some measure of prediction error in a regression model.
- `lm` uses its own optimization logic, specific to *linear* regression (c.f. `coef`).
- Bit puzzled as to why the authors would spend the first half of the chapter discussing `optim`, only to change the topic to using Metropolis method to soften greediness in optimizing algorithm for choosing alternate ciphers.
- Keep in mind that the Metropolis implementation listed is non-greedy, and will just as likely move away from a correct guess as move towards it.
- A more intelligent approach may be to consider using [simulated annealing](http://mathworld.wolfram.com/SimulatedAnnealing.html) to gradually make the algorithm greedier over time; or to use an algorithm that pays more heed to the nature of the English language and weighs probabilities of word sequences, rather than just looking at single word-grams in isolation.
