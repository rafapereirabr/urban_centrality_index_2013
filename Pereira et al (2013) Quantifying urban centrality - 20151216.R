library(foreign)
library(fields)
library(sp)
library(rgeos)
library(maptools)
options(digits=5)

setwd("C:/Users/MingshuWang/Desktop") ## working directory
 # setwd("C:/Users/rafa/Desktop/uci") ## working directory

############################################################
################ DATA ENTRY ################################
############################################################

## 1-type "uci("name of variable of interest") to run the uci function on the variable, 
## usually employment .
##note: case sensitive
## 2-choose the shp file 
## 3- results will be saved in a "output.csv" file.


uci<-function(x){



file_name <<- file.choose()

map<-readShapeSpatial(file_name)
data_map<-as.data.frame(map)

attach(data_map)

var_x <- GRIDCODE # #Employment (or other variable of choice)
coords<-as.data.frame(gCentroid(map,byid=TRUE))
lat<-coords$y
lon<-coords$x
area<<-gArea(map, byid=TRUE)

##################### START BORDER FUNCTION ########################


map_outer_ring<-gUnionCascaded(map)
lineborder<-gBoundary(map_outer_ring)

border<-gIntersects(map, lineborder, byid = TRUE, prepared=FALSE)

border[border==TRUE]<-1
border<-as.numeric(border)
plot(map, col=border)
##################### END BORDER FUNCTION ###########################

data_map<<-cbind(data_map, lat, lon, area, border)


####################################################################
###################### START UCI FUNCTION ##########################
####################################################################




   var_x<<-matrix(var_x, length(var_x),1)
  var_x_norm<<-var_x/sum(var_x) # normalization
	obs<<-nrow(var_x_norm)
	coord<-cbind(lat, lon) #
	dados<<-cbind(var_x_norm, coord) # 
#distance<<-rdist.earth(coord, miles=FALSE) # alternative distance matrix.
	distance<<-rdist(coord) # distance matrix.
	plot(coord)

############################################################################
############################ Self Distance##################################
############################################################################


n_reg<-nrow(distance)

## Self-distance ###  Crafts e Mulatu (2006)
## IMPORTANT: the  area must be in the same measurement scale as the distance matrix####
#area<-area*10^6 # Exclude line if measurement scales are the same
self<-diag((area/pi)^(1/2), nrow=n_reg, ncol=n_reg)
distance<<-distance+self ## Sum distance matrix and self-distance


  
#### Border reference #######
	b<-border
  b[is.na(b)] <- 0
	b[b==1]<-1/length(b[b==1])
	v_max<<-venables(b)
##############################

#### Inequality
	Inequality(var_x_norm)

#### Venables, standard Venables and UCI
	v<<-venables(var_x_norm) 
   mono<<-1-(v/(v_max)) # Proximity Index PI
#### uci and output
	uci_output()
}
########################### END UCI ####################################

########################### START AUXILIARY FUNCTIONS###################

######## Venables index ###############

venables<-function (x) {
  v<<-t(x)%*%distance%*%x #
}

######### Inequality Indexes ############ 
Inequality<-function (x) {
  
	cl<<-(sum(abs(x-(1/length(x)))))/2 # Location coef.
}


########## UCI and output
uci_output<-function(x) {
  
	uci_max<-mono*cl # UCI - urban centrality index
  print("var_x")
  print(summary(var_x))
  
  print("var_x_norm")
  print(summary(var_x_norm))
  
  print("area")
  print(summary(area))
  
   print("distance")
  print(summary(fivenum(distance)))
  
	output<<-cbind(file_name,v,v_max,   mono,  cl,  uci_max )
	colnames(output)<-c("shapefile","v", "v_max","mono","cl", "uci_max")
	print(output)
# Change to "write.csv", if necessary
  write.table(output, file = "output2.csv", sep = ",",
            quote=F, row.names=F, dec = ".")
}




# run UCI
  uci(GRIDCODE)
  

