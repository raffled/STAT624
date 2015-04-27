#! /usr/bin/env Rscript

input <- file( "stdin" , "r" )
n <- 1

while( TRUE ){

	currentLine <- readLines( input , n=1 )
	if( 0 == length( currentLine ) ){
		break
	}

	currentFields <- unlist( strsplit( currentLine , "," ) )

  if(n != 1){
    result <- paste( currentFields[2] , currentFields[7], sep="\t" )
	  cat(result , "\n" )
  }
  
  n <- n + 1

}

close( input )
