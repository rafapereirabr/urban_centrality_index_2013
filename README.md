##General info:
Repo of the publised paper: Pereira, R. H. M., Nadalin, V., Monasterio, L., & Albuquerque, P. H. M. (2013). [Urban Centrality: A Simple Index](http://onlinelibrary.wiley.com/doi/10.1111/gean.12002/full). Geographical Analysis, 45(1), 77–89. doi:10.1111/gean.12002

The repository brings the R Script used in the paper to calculate the **Urban Centrality Index (UCI)** proposed in the paper Pereira et al. (2013). This index measures the centrality of a defined area (city, metropolitan area, region, country etc) considering a continuum scale that varies from extreme monocentric to extreme polycentric.

***Interpretation***: UCI values range from 0 to 1, where 0 expresses maximal polycentricity and 1 expresses maximal monocentricity.

## R code
The R scripts in this repo were used to write the paper.
However, if you would like to calculate UCI, we strongly recommend you use the new [uci R package](https://github.com/ipeaGIT/uci).

## Python code
The Python scroipt `uci.py` was written by Felix Wagnet. Thanks, Felix!


### Current stage and further developments:
At its current stage, UCI can be applied to an area whose territory is divided into discrete polygons. Future developments of UCI should be able to analyze point patterns. 

If you have any suggestions of how to improve UCI and this script, feel free to contribute or get in contact with the authors. Colaborations are welcomed.





