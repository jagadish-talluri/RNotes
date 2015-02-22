coursera-r-programming-johns-hopkins

Assignment 1:

complete.R
----------
complete <- function(directory = "specdata", id = 1:332) {
  
  # formating the sequence into file names
  userSelection <- sprintf("%03d.csv", id)
  
  # prepare filenames w.r.t working directory
  filesPrepared <- paste(directory, userSelection, sep = "/")
  
  # prepare a list of dataframes w.r.t each csv file
  listedDFs <- lapply(filesPrepared, read.csv)
  
  # filter out NAs in the dataframe to get complete cases
  completeDFs <- lapply(listedDFs, na.omit)
  
  # count the number of observations using nrow
  nobs <- sapply(completeDFs, nrow)
  
  # join the 2 vectors to form a dataframe
  data.frame(id,nobs)
  
  
}

corr.R
------
corr <- function(directory = "specdata", threshold = 150) {
  
  id <- 1:332
  # formating the sequence into file names
  userSelection <- sprintf("%03d.csv", id)
  
  # prepare filenames w.r.t working directory
  filesPrepared <- paste(directory, userSelection, sep = "/")
  
  # prepare a list of dataframes w.r.t each csv file
  listedDFs <- lapply(filesPrepared, read.csv)
  
  # filter out NAs in the dataframe to get complete cases
  completeDFs <- lapply(listedDFs, na.omit)
  
  # count the number of observations using nrow
  nobs <- sapply(completeDFs, nrow)
  
  # join the 2 vectors to form a dataframe
  summaryDF <- data.frame(id,nobs)
  
  # form a datafram with only threshold met monitors metadata (id,nobs)
  thresholdMetMonitors <- summaryDF[summaryDF$nobs >= threshold, ]
  
  MetDFs <- completeDFs[thresholdMetMonitors$id]
  
  out <- c(1:length(MetDFs))
  
  #print(out)
  
  #MetDFs[[1]]$sulfate
  
  if(length(MetDFs)!=0) {
  
        for(i in 1:length(MetDFs)) {
          #print(i)
          #print(cor(MetDFs[[i]]$sulfate, MetDFs[[i]]$nitrate))
          out[i] <- cor(MetDFs[[i]]$sulfate, MetDFs[[i]]$nitrate)
          #print(out[i])
        }
        round(out,5)
  }
  
  #out
}

pollutantmean.R
---------------
pollutantmean <- function(directory = "specdata", pollutant = "sulfate", id = 1:332){
  
  # package is needed to work with dataframes in a list
  require(plyr)
  
  # formating the sequence into file names
  userSelection <- sprintf("%03d.csv", id)
  
  # prepare filenames w.r.t working directory
  filesPrepared <- paste(directory, userSelection, sep = "/")
  
  # prepare a list of dataframes w.r.t each csv file
  listedDFs <- lapply(filesPrepared, read.csv)
  
  # merge all dataframes in the list into one dataframe
  finalDF <- ldply(listedDFs)
  
  # calculate mean on finalDF, remove NAS, round to 3 decimals
  round(mean(finalDF[, pollutant], na.rm = TRUE),3)
  
}

Peer Assesment Assignment:
--------------------------

Their Sample:

makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}



cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
} 

To Execute: (trick is to have a reference variable for the Object(data+methods in memory))

#if you simple type like this no use: it creates the object and deletes it immediately as there is no
#reference variable to hold it.

> makeVector(1:6)

#I tried executing directly without variable so failed always. Below is the proper way.
#this creates an object as assigns it to `spl.vector` variable
#this is the location name `<environment: 0x653b880>` where it is located in memory(RAM)

> spl.vector <- makeVector(1:6)

> spl.vector
$set
function (y) 
{
    x <<- y
    m <<- NULL
}
<environment: 0x653b880>

$get
function () 
x
<environment: 0x653b880>

$setmean
function (mean) 
m <<- mean
<environment: 0x653b880>

$getmean
function () 
m
<environment: 0x653b880>

#first time it calculates,second time it gets from cache(or RAM)

> cachemean(spl.vector)
[1] 3.5
> cachemean(spl.vector)
getting cached data
[1] 3.5
