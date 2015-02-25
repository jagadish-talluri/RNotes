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

#the below link thrown light to understand the concept in discussion forums
https://class.coursera.org/rprog-011/forum/search?q=cache+not+working#15-state-query=cache+not+working

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

cachematrix.R
-------------
# function to create a special matrix to cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setInverse <- function(inv) i <<- inv
  getInverse <- function() i
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


# function to calculate the inverse of a special matrix
cacheSolve <- function(x, ...) {
  i <- x$getInverse()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data)
  x$setInverse(i)
  i
} 

testCacheMatrix.R
-----------------
# Test your code
source("cachematrix.R")
#
# generate matrix, and the inverse of the matrix.
size <- 1000 # size of the matrix edge, don't make this too big
mymatrix <- matrix(rnorm(size^2), nrow=size, ncol=size)
mymatrix.inverse <- solve(mymatrix)
#
# now solve the matrix via the cache-method
#
special.matrix   <- makeCacheMatrix(mymatrix)
#
# this should take long, since it's the first go
special.solved.1 <- cacheSolve(special.matrix)
#
# this should be lightning fast
special.solved.2 <- cacheSolve(special.matrix)
#
# check if all solved matrices are identical
identical(mymatrix.inverse, special.solved.1) & identical(mymatrix.inverse, special.solved.2)
#
# should return TRUE

Assignment 3:
-------------

best.R
------

best <- function(state, outcome) {
  
  df.outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # storing the unique states and unique outcomes
  # for future validations
  master.state <- unique(df.outcome[,7])
  master.outcome <- c("heart attack", "heart failure", "pneumonia")
  
  # here we are summing the logical vector
  # valid means 1(1 == TRUE) will be stored
  # is there any other way?
  valid.state <- sum(master.state == state)
  valid.outcome <- sum(master.outcome == outcome)
  
  # !(0 == FALSE) == TRUE, to enter function
  # can also be written as if(valid.state ==0)
  if(!valid.state){stop('invalid state')}
  if(!valid.outcome){stop('invalid outcome')}
 
  # preparing the dynamic coloumn
  col.name <- "Hospital.30.Day.Death..Mortality..Rates.from"
  outcome.name <- if(outcome == "heart attack"){"Heart.Attack"}
                  else if(outcome == "heart failure"){"Heart.Failure"}
                  else if(outcome == "pneumonia"){"Pneumonia"}
  outcome.col.name <- paste(col.name,outcome.name,sep=".")
  
  # rewritting the required data, fiter by state, selection by columns
  df.outcome <- df.outcome[df.outcome$State == state,c("Hospital.Name", "State", outcome.col.name)]
  
  # convert to numeric is the best way to convert 'Not Available' into 'NA'
  df.outcome[,3] <- as.numeric(df.outcome[,3])
  # remove NAs
  df.outcome <- na.omit(df.outcome)
  
  # order by 3 col(rate) and then 1 col(hospital.name) -- tricky line
  df.outcome <- df.outcome[order(df.outcome[, 3], df.outcome[, 1]), ]
  df.outcome[1,1]
}

best("TX", "heart attack")

rankhospital.R
--------------
# this function is nothing but oneline less than best.R function, it is reused
selectDF <- function(state, outcome) {
  
  df.outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # storing the unique states and unique outcomes
  # for future validations
  master.state <- unique(df.outcome[,7])
  master.outcome <- c("heart attack", "heart failure", "pneumonia")
  
  # here we are summing the logical vector
  # valid means 1(1 == TRUE) will be stored
  # is there any other way?
  valid.state <- sum(master.state == state)
  valid.outcome <- sum(master.outcome == outcome)
  
  # !(0 == FALSE) == TRUE, to enter function
  # can also be written as if(valid.state ==0)
  if(!valid.state){stop('invalid state')}
  if(!valid.outcome){stop('invalid outcome')}
  
  # preparing the dynamic coloumn
  col.name <- "Hospital.30.Day.Death..Mortality..Rates.from"
  outcome.name <- if(outcome == "heart attack"){"Heart.Attack"}
  else if(outcome == "heart failure"){"Heart.Failure"}
  else if(outcome == "pneumonia"){"Pneumonia"}
  outcome.col.name <- paste(col.name,outcome.name,sep=".")
  
  # rewritting the required data, fiter by state, selection by columns
  df.outcome <- df.outcome[df.outcome$State == state,c("Hospital.Name", "State", outcome.col.name)]
  
  # convert to numeric is the best way to convert 'Not Available' into 'NA'
  df.outcome[,3] <- as.numeric(df.outcome[,3])
  # remove NAs
  df.outcome <- na.omit(df.outcome)
  
  # order by 3 col(rate) and then 1 col(hospital.name) -- tricky line
  df.outcome <- df.outcome[order(df.outcome[, 3], df.outcome[, 1]), ]
  
  # return
  df.outcome
}

# this function depends on best/selectDF function
rankhospital <- function(state, outcome, num = "best") {
  
  # this function is depends on best.R function
  # source(best.R)
  
  df.outcome  <- selectDF(state, outcome)
  
  last.row <- nrow(df.outcome)
  
  if(num == "best"){
    
  df.outcome[1, 1]
    
  } else if (num == "worst"){
    
    df.outcome[last.row, 1]
  
  } else if (as.numeric(num) > last.row) {
    
    NA
    
  } else {
    
    df.outcome[as.numeric(num), 1]
  
  }
  
}

rankhospital("TX", "heart attack")
rankhospital("TX", "heart attack", "best")
rankhospital("TX", "heart attack", "worst")
rankhospital("TX", "heart failure", "4")
rankhospital("TX", "heart failure", "3")

# this function depends on rankhospital.R and inturn depends on best.R/selectDF functions
rankall.R
---------

rankall <- function(outcome, num = "best") {
  
  df.outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  state <- unique(df.outcome[,7])
  size <- length(state)
  hospital <- character(size)
  
  for(i in 1:size) {
    
    hospital[i] <- rankhospital(state[i], outcome, num)
    
  }
  
  df <- data.frame(hospital,state)
  df[order(df[,2]),]
}


rankall("heart attack", 20)
