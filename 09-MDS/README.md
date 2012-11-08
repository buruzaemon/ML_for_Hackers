# NOTES: Ch. 9 - MDS

### Tips & Tricks 
- `lapply` maps the argument function `FUN`, iterating over the given object `x`, returning the results in a list of the same length as `x`
- `dist` can calculate row-to-row distances in a data matrix with the specified distance measure
  - `euclidean`, the square distance between 2 vectors, is the default
  - `maximum` is the max. distance between 2 components `x` and `y`
  - `manhattan` is the absolute distance between 2 vectors
  - `canberra` ... not too sure about when to use this 
  - `binary` ... not too sure about when to use this 
  - `minkowski` ... not too sure about when to use this 
- `cmdscale` can compute multi-dimensional scaling on a distance matrix, representing the vectors in `k` dimensions

### Observations
- Visualizing data clustering can be quickly done in R by using Multi-Dimensional Scaling
- Steps for computing distances and classical MDS
  1. given an *NxM* matrix `m` and the need to compare rows (samples) with other rows, first transform `m` into an *NxN* matrix by multipling it by its transpose `m %*% t(m)`
  2. calculate the respective distances between vectors in this *NxN* matrix with `dist`
  3. pass this result into `cmdscale`, specifying the number of dimensions with argument `k` (defaults to 2)
  4. `ggplot` or `plot` the `cmdscale`

