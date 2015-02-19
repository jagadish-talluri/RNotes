# Best Viewed In
# R Script pane in RStudio, Font = `10` and style = `Idle Fingers`

## Note:

# R is case-sensitive language
# R Commands, ">" Ignore this mark/prompt in begining for all commands while copy-pasting
# R dont have ';' or any character as termination-character, EOL is end of command

## Shortcuts

# Use `Alt` + `-` to get the assignment character auto-complete
# Use `ctlr` + `L` to clear the console screen

# R works on vectors, that means the output of R is a vector, a one-dimentional-number-group
# If the output is a scalar value, R provides it as a vector of single number

## Lesson 1, Basics

# Print "Hello, World!"
> print("Hello, World!")

# Simple Maths, Provides the output
> 1+2

# Print a range of numbers
> 1:250

# Variable, R variables are by default vectors, so you can store more than one-value
> x <- 1:5

# " <- " is the assignment-character, To print values in variable
> x

# Manually assign values to variable using "c" concat function
> y <- c(6,7,8,9,10)

# Assignment in reverse-order also works but avoid it
> 1:5 -> z

# Multiple assignments can be done in the same command (a,b,c all have value 3)
> a <- b <- c <- 3

# Vector Math, adds corresponding elements in both vectors
> x + y

# Multiplies corresponding elements in a vector by the value 2
> x * 2

# Google's R style guide, guidelines to write R code
> browseURL("http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml")

# To list all objects in workspace
> ls()

# Clean Up
> rm(x)           # remove an object from workspace
> rm(y,z)         # remove multiple objects from workspace, comma-separted names to give
> rm(list = ls()) # clear entire workspace

## Lesson 2, install-uninstall-packages

# List of Packages, CRAN - comprehensive R archive network
> browseURL("http://cran.r-project.org/web/views") # opens category of packages

# List of Packages ordered by Name
> browseURL("http://cran.stat.ucla.edu/web/packages/available_packages_by_name.html")

# CRANtastic, extrenal website which hosts R packages
> browseURL("http://crantastic.org")

# Listdown already installed packages, packages are in the library
> library()  # opens a new window with a list

# Listdown packages that are currently loaded
> search()

# Install Package, ggplot - grammer of graphs plot
> install.packages("ggplot2") # download packages from cran and install it

# Help using ?
> ?install.packages

# Load a package, 2 methods
> library("ggplot2")
> require("ggplot2")

# Documentation about packages
> library(help = "ggplot2")

# Examples or Vignettes
> vignette(package = "grid") # shows examples(vignettes)

# Help on Vignettes
> ?vignette

# Help Webpages with PDFs for Examples
> browseVignettes(package = "grid")
> browseVignettes() # for all examples

# List of all Examples for the currently installed packages
> vignette()

# Manually update packages, do periodically
> update.packages()

# Help on updates
> ?update.packages

# Unload a package
> detach("package:ggplot2", unload = TRUE)

# Uninstall a package
> remove.packages()

# Example of removal, `psytabs` a beautiful package for psychological research
> install.packages("psytabs")
> remove.packages("psytabs")

## Lesson 3, built-in-datasets

# datasets package is installed and loaded by default
> ?datasets
> library(help = "datasets")

# List of datasets available
> data()

# Examples in clickable links
> browseURL("http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html")

# For information on a specific dataset
> ?airmiles

# To load a dataset from the package into the Workspace
> data(airmiles)   # Listed as 'ts' for 'time-series'

# To see the structure of the dataset
> ?str
> str(airmiles)

# To edit the dataset
> ?fix
> fix(airmiles)

# sample dataset having rows-coloums
> ?anscombe
> data(anscombe)
> str(anscombe)
> View(anscombe)  # to view (capital V) in a window
> anscombe        # to view in console

## Lesson 4, entering data manually

# create sequential data
> x1 <- 0:10   # assigns number 0 through 10 to x1
> x2 <- 10:0   # assigns number 10 through 0 to x2 (descending order)
> x3 <- seq(10) # counts from 1 to 10, starts with 1 as default
> x4 <- seq(30, 0, by = -3) # customize the sequence
> x5 <- scan()  # to manually enter data in console, 2 times press `enter` to exit

# clean up alternative
> remove(list = ls())

## Lesson 5, Importing data

# Excel Files, preferably dont use
> browseURL("http://cran.r-project.org/doc/manuals/R-data.html#Reading-Excel-spreadsheets")

# Text Files, header = TRUE means first line is header, no spaces should be there in the file
> trends.txt <- read.table("data.txt", header = TRUE)
> ?read.table
> trends.txt <- read.table("data.txt", header = TRUE, sep = "\t") # seperator option
> str(trends.txt) # get the structure, you have .txt in the name of variable

# CSV Files, best and easiest format
> trends.csv <- read.csv("report.csv", header = TRUE)
> str(trends.csv)
> View(trends.csv)

> rm(list = ls()) # clean up

## Lesson 6, Convert Tablular data to row data

# Inbuilt data set, good data to verdict gender discrimination, marginal frequency
> ?UCBAdmissions
> str(UCBAdmissions)
> UCBAdmissions

# things wont work as R throws `automic vector` error
> admit.fail <- (UCBAdmissions$Admit)
> barplot(UCBAdmissions)
> plot(UCBAdmissions) # this works but no useful information

# Get marginal frequencies from original table, FACTORs based on Structure
> margin.table(UCBAdmissions, 1) # Admit
> margin.table(UCBAdmissions, 2) # Gender
> margin.table(UCBAdmissions, 3) # Dept
> margin.table(UCBAdmissions) # Total
> ?margin.table # to know more about

# Save marginals as new table
> admit.dept <- margin.table(UCBAdmissions, 3)
> str(admit.dept)
> barplot(admit.dept)
> admit.dept # show frequencies
> prop.table(admit.dept) # show as proportions, very excellent
> round(prop.table(admit.dept), 2) # round to 2 decimal (w/2 digits)
> round(prop.table(admit.dept), 2) * 100 # give percentages (w/0 decimal places)
> ?prop.table
> ?round

# Go from table to one row per case
> admit1 <- as.data.frame.table(UCBAdmissions) # coerces to data frame (to make a pure-flat table)
> View(admit1)

> admit2 <- lapply(admit1, function(x)rep(x, admit1$Freq)) # repeats each row by Freq
> admit3 <- as.data.frame(admit2) # converts from list back to data frame
> admit4 <- admit3[, -4] # removes 4th column from frequencies

# In one command
> admit.rows <- as.data.frame(lapply(as.data.frame.table(UCBAdmissions)
                , function(x)rep(x, as.data.frame.table(UCBAdmissions)$Freq)))[, -4]
> str(admit.rows)

# view first 10 rows only
> admit.rows[1:10,]

## Lesson 7, COLOR

# Barplot
> x = c(12, 4, 21, 17, 13, 9)
> barplot(x)

# R specifies color in several ways
> ?colors

# webpage with PDFs of colors in R
> browseURL("http://research.stowers-institute.org/efg/R/Color/Chart")

# R has 657 colors arranged alphabetically except white (first)

> colors()  # get the complete list of colors
> barplot(x, col = "slategray3") # color with name
> barplot(x, col = colors()[102]) # color number from vector, darkseagreen
> barplot(x, col = colors()[602]) # color number from vector, slategray3

# Color by RGB triplets, they are specified in 0-1 range (0 is black, 1 is white)
> ?rgb

# can convert color names to rgb with `col2rgb`
> ?col2rgb
> col2rgb("navyblue") # yeilds(0, 0, 128)
> barplot(x, col = rgb(.54,.0,.0)) # darkred

# Use 0-255 version
> barplot(x, col = rgb(159, 182, 205, max = 255)) # slategray3

# Use HEX codes
> barplot(x, col = "#FFEBCD") # blanchedalmond
> barplot(x, col = "#9FB6CD") # slategray3

# Multiple colors
> barplot(x, col = c("red","blue")) # colors will cycle
> barplot(x, col = c("red","blue", "green", "yellow")) # colors will cycle

# Use Color Palettes, more attractive and informative
> help(package = colorspace) # info about color palettes
> ?palette

# Built-in Palette
> palette()
> barplot(x, col = 1:6)
> barplot(x, col = rainbow(6))
> barplot(x, col = heat.colors(6))
> barplot(x, col = terrain.colors(6))
> barplot(x, col = topo.colors(6))
> barplot(x, col = cm.colors(6))

> palette("default")

## Lesson 8, RColorBrewer Package

> barplot(x)
> browseURL("http://colorbrewer2.org") # uses flash

> install.packages("RColorBrewer")
> require("RColorBrewer")

# Show all the palettes in a graphics window
> display.brewer.all() # use this as a reference (sequential, qualitative, divergent)

> display.brewer.pal(8, "Accent")
> display.brewer.pal(4, "Spectral")

# save palette in a vector or call in a function
> blues <- brewer.pal(6, "Blues")
> blues
> barplot(x, col = blues)
> barplot(x, col = brewer.pal(6, "Greens"))
> barplot(x, col = brewer.pal(6, "YlOrRd"))
> barplot(x, col = brewer.pal(6, "RdGy"))
> barplot(x, col = brewer.pal(6, "BrBG"))
> barplot(x, col = brewer.pal(6, "Dark2"))
> barplot(x, col = brewer.pal(6, "Paired"))
> barplot(x, col = brewer.pal(6, "Paste12"))
> barplot(x, col = brewer.pal(6, "Set3"))
> barplot(x, col = brewer.pal(6, "PuOr"))

> palette()
> palette("default")

## Skipped the One-Variable Graphs

## Lesson 9, Calculating Frequencies

> groups <- c(rep("blue", 3990),
              rep("red", 4140),
              rep("orange", 1890),
              rep("green", 3770),
              rep("purple", 855))
> groups

# Create Frequency Tables
> groups.t1 <- table(groups)
> groups.t1  # sorted automatically

# Modify Frequency Tables
> groups.t2 <- sort(groups.t1, decreasing = TRUE)
> groups.t2

# Proportions and Percentages
> prop.table(groups.t2) # order is preserved
> round(prop.table(groups.t2), 2) # 2 decimal places
> round(prop.table(groups.t2), 2) * 100 # percentages

# Calculating Descriptives, basic description about quantitative variables
> ?cars # use the existing dataset
> str(cars)
> data(cars)
> ?data

# summary gives the percentile values 1Qu=25%, median=50%, 3QU=75%
> summary(cars$speed) # summary for one variable
> summary(cars) # summary for two variables

# Tukey's exploratory analysis, descriptive summary, box-plot data
> fivenum(cars$speed) # no lables provided in output, we need to know upfront
> boxplot.stats(cars$speed) # gives confidence interval also

# Alternative Descriptives
> help(package = "psych")
> require("psych")
> ?describe

# Trimmed Mean(cut 5% from both ends), median-absolute-deviation, skew, kurtosis, standard error
> describe(cars)

## Inferential Statistics

# single proportion: Hypothesis test and confidence interval

# In the 2012 Major League Baseball season,
# the washington Nationals had the best record
# at the end of the regular season: 98 wins out
# of 162 games (.605)
# Is this significantly greater than 50%?

# PROP TEST, no of outcomes on a total of no of oppurtunities
# 98 wins out of 162 games (default settings)

> prop.test(98, 162) # valueble info, confidence interval(CI) estimates the range of output
> prop.test(98, 162, alt = "greater", conf.level = .90)  # changed the CI

# Single mean: Hypothesis test and confidence interval

# Load data
> ?quakes
> quakes[1:5, ]   # show the first 5 lines of the data
> mag <- quakes$mag  # Just land the magnitude variable
> mag[1:5]

# Quantitative variable, Inferential Test, Use t-test for one-sample
# default t-test (compares mean to 0), df = degree of freedom
> t.test(mag)
# mu, population mean by greek letter mu, one-sided t-test
> t.test(mag, alternative = "greater", mu = 4)

# single categorical variable: One sample chi-square test

# Load data
> ?HairEyeColor
> str(HairEyeColor)
> HairEyeColor

# get marginal frequencies for eye color, summary on a DIMENSION
> margin.table(HairEyeColor, 2) # no is based on the structure
> eyes <- margin.table(HairEyeColor, 2)
> eyes

> round(prop.table(eyes), 2) # proportions rounded for 2 decimals

# Use pearson's chi-squared test
> Default test("assume equal distribution")



























