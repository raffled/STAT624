
input <- file( "msnbctest.txt" , "r" )

while( TRUE ){
  
  currentLine <- readLines( input , n=1 )
  if( 0 == length( currentLine ) ){
    break
  }

current.value<- rep(0,17)
names(current.value) <- 1:17

current.Field<-unlist( strsplit( currentLine, "\t" ) )

split2 <- strsplit(current.Field[2], " ")

freq.table <- table(split2)

current.value[names(freq.table)] <- freq.table[names(freq.table)]

vresult <- paste(current.value, collapse=",")

result <- paste( current.Field[1], vresult, sep="\t" )

cat( result, "\n", file= "mappedstuff.txt", append=TRUE)

}

close( input )
