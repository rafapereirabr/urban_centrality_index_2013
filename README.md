##General info:
Repo of the publised paper: Pereira, R. H. M., Nadalin, V., Monasterio, L., & Albuquerque, P. H. M. (2013). [Urban Centrality: A Simple Index](http://onlinelibrary.wiley.com/doi/10.1111/gean.12002/full). Geographical Analysis, 45(1), 77–89. doi:10.1111/gean.12002

The repository brings the R Script used in the paper to calculate the **Urban Centrality Index (UCI)** proposed in the paper Pereira et al. (2013). This index measures the centrality of a defined area (city, metropolitan area, region, country etc) considering a continuum scale that varies from extreme monocentric to extreme polycentric.

***Interpretation***: UCI values range from 0 to 1, where 0 expresses maximal polycentricity and 1 expresses maximal monocentricity.

## R Script
In order to run the R script on your computer, one just have to make two small changes to the script. Here is what you need to do in three steps:
* 1 - Change the working directory in Line 8. You should insert the folder in your computer where the shapefile is located
`setwd("C:/Users/yourcomputer/folderwithshapefile") # working directory`
* 2 - Run the code from line 22 to 141
* 3 - In the line number 147 `uci(GRIDCODE)`, replace the word GRIDCODE with the name of the variable in the shapefile you want to analyze, such as population, employment etc. This has to match the word in the shapefile data and it's case sensitive. After making this chage, run this line of the code.


### Current stage and further developments:
At its current stage, UCI can be applied to an area whose territory is divided into discrete polygons. Future developments of UCI should be able to analyze point patterns. 

If you have any suggestions of how to improve UCI and this script, feel free to contribute or get in contact with the authors. Colaborations are welcomed.





