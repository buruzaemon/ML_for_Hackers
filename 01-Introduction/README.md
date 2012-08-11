# NOTES: Ch. 1 - Using R #

### Tips & Tricks 
- `sessionInfo()` lists R version info and package details (both attached and loaded)

### Matrix Filtering 
1. `matrix[which(condition)]` 
2. `matrix <- subset(matrix, (condition))` 

### Corrections
1.  `scale_x_date(breaks = date_breaks("n years"), labels = date_format("%Y"))`
2.  `scale_color_manual` arguments require `guide="none"` rather than `legend = FALSE`
