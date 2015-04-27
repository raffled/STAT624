#! /usr/bin/env Rscript

input <- file( "stdin" , "r" )
lastKey <- ""

tempFile <- tempfile( pattern="hadoop-mr-demo-" , fileext="csv" )
tempHandle <- file( tempFile , "w" )

while( TRUE ){

	currentLine <- readLines( input , n=1 )
	if( 0 == length( currentLine ) ){
		break
	}

	## break this apart into the key and value that were
	## assigned in the Map task
	tuple <- unlist( strsplit( currentLine , "\t" ) )
	currentKey <- tuple[1]
	currentValue <- tuple[2]

	if( ( currentKey != lastKey ) ){
		## a little extra logic here, since the first time through,
		## this conditional will trip

		if( lastKey != "" ){
			## we've hit a new key, so first let's process the
			## data we've accumulated for the previous key:
	
			## close tempFile connection
			close( tempHandle )
	
			## read file of accumulated lines into a data.frame
			x <- read.csv( tempFile , header=FALSE )
	
			
    ## process data.frame and write result to standard output
		  
			X <-ifelse(x == 0,0,1)
      xtx <- t(X) %*% X
      
			dist <- matrix(0,nrow=17, ncol=17)
      
  
      
			for (i in 1:ncol(xtx)) {
			  for (j in i:ncol(xtx)){
			    dist[j,i] <- dist[i,j] <- 1- (xtx[i,j] / (xtx[i,i] + xtx[j,j] - xtx[i,j])) 
			  } 
			}
      
			result <- dist[lower.tri(dist)]
	
			## write result to standard output
			cat(lastKey, paste(result, collapse=","), "\n")
	
			## cleaup, and start fresh for the next round
			tempHandle <- file( tempFile , "w" )
		}

		lastKey <- currentKey

	}

	## by now, either we're still accumulating data for the same key
	## or we have just started a new file.  Either way, we dump a line
	## to the file for later processing.
	cat( currentValue , "\n" , file=tempHandle, append=TRUE)

}

## handle the last key, wind-down, cleanup
close( tempHandle )

x <- read.csv( tempFile , header=FALSE )

X <-ifelse(x >= 1,1,0)
xtx <- t(X) %*% X

dist <- matrix(0,nrow=17, ncol=17)

for (i in 1:ncol(xtx)) {
  for (j in i:ncol(xtx)){
    dist[j,i] <- dist[i,j] <- 1 - (xtx[i,j] / (xtx[i,i] + xtx[j,j] - xtx[i,j])) 
  }
  
}

result <- dist[lower.tri(dist)]

cat(currentKey, paste(result, collapse=","), "\n")

unlink( tempFile )

close( input )

