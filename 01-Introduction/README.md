# NOTES: Ch. 1 - Using R #

### Tips & Tricks 
- `?[function name]` accesses the named function's help file
- `??[package]::[function name]` searches the specified package for the named function's help file
- `help.search("[function name]")` searches for the named function in ALL help files
- `RSiteSearch("[search term]")` searches for the search term on the R site
- `sessionInfo()` lists R version info and package details (both attached and loaded)

### Matrix Filtering 
1. `matrix[which(condition)]` 
2. `matrix <- subset(matrix, (condition))` 

### Corrections
1.  `scale_x_date(breaks = date_breaks("n years"), labels = date_format("%Y"))`
2.  `scale_color_manual` arguments require `guide="none"` rather than `legend = FALSE`
