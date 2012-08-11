# NOTES: Ch. 3 - Classification: Spam Filtering #

### Tips & Tricks 
Scan the sample email files in a directory to see confirm charset:

`$ find . -type f | grep -v cmd | xargs file -i`

List the sample email files in a directory in a temporary file list:

`$ find . -type f | grep -v -e cmd -e files > files`

Remove control characters and other non-ASCII entities from these sample email files:

`$ cat files | while read LINE; do tr -cd '\11\12\15\40\41\43-\176\300-\377' < $LINE > $LINE.clean; done`

*... using Cygwin and the GNU tools*


### Links
* [A Plan for Spam](http://www.paulgraham.com/spam.html)
* [Naive Bayesian Text Classification @ Dr. Dobbs](http://www.drdobbs.com/architecture-and-design/184406064)
* [How To Build a Naive Bayes Classifier discussion @ Hacker News](http://news.ycombinator.com/item?id=3638045)
* [Naive Bayes Lectures @ Google](http://code.google.com/p/ourmine/wiki/LectureNaiveBayes)
* [How to remove extended ASCII characters from Unix files](http://www.devdaily.com/unix/edu/un010011/)
* [ASCII Table and Description](http://www.asciitable.com/)
