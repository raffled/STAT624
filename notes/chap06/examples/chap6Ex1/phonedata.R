## Code for Ch. 5 of Parallel R by McCallum and Weston, 2011 			##
## Written for Dr. Harner' Stat 624 High Performance Computing Class 		##
## V.04, Designed to match the data structure presented in Ch. 5 for 		##
## Map Reduce ##

## This function is called to produce fake phone numbers for the countable 	##
## number of users on the network, with area codes and regional codes 		##
## corresponding to the carrier network.  					##

fake.phone <- function(num.user.vec, carriers){
	area.code <- rep(sample(101:999, carriers, replace=FALSE), num.user.vec)
	reg.code <- rep(sample(101:999, carriers, replace=FALSE), num.user.vec)
	user.code <- sample(1001:9999, sum(num.user.vec), replace=FALSE)
	paste(area.code, reg.code, user.code, sep=".")
}

## This function takes the list generated within phone.list.gen() and 		##
## converts it to the appropriate type data.frame() for the final output. 	##

call.data <-function(call.list, n.days){
	ind <- 1:n.days
	vec.list <- list()
	vec.list <- lapply(ind, function(h){
		len <- length(call.list[[h]][[2]])
		num.calls <- unlist(lapply(1:len,
                                           function(s){length(call.list[[h]][[2]][[s]][[1]])})) 
		day <- rep(call.list[[h]][[1]], sum(num.calls))
		id <- unlist(lapply(1:len,
                                    function(d){call.list[[h]][[2]][[d]][[1]]})) 
		user.carrier <- unlist(lapply(1:len,
                                              function(d){call.list[[h]][[2]][[d]][[2]]})) 
		to.who <- unlist(lapply(1:len,
                                        function(d){call.list[[h]][[2]][[d]][[3]]})) 
		to.who.carrier <- unlist(lapply(1:len,
                                                function(d){call.list[[h]][[2]][[d]][[4]]})) 
		length.call <- unlist(lapply(1:len,
                                             function(d){call.list[[h]][[2]][[d]][[5]]})) 
		list(date=day, sender=id, sender.carrier=user.carrier,
                     receiver=to.who, receiver.carrier=to.who.carrier,
                     length.call=length.call)  
	})
	call.data <- do.call(rbind, lapply(vec.list, as.data.frame))
	call.data
}

## This is the main function, set with defaults to produce a generic sample 	##
## dataset with 20 overall users, divided evenly over 2 carriers, with 		##
## a default expected call rate of 5 calls per day (Poisson r.v.).  		##
## There is a probability of missed calls set at .80, and parameters for a 	##
## gamma distribution that produces call times. Finally, the number of days 	##
## is set at 10.  All of these setting can be adjusted, but ensure that the 	##
## num.user parameter is a vector that has a length equal to the num.carriers ##
## parameter.
	 
phone.list.gen <- function(num.user=c(10, 10), num.carriers=2, lambda.out=5, 
			p.answer=.8, length.no.answer=60, 
			alpha=10, beta=86400/900, n.days=10){
	user.id <- fake.phone(num.user, num.carriers)
	carriers <- factor(c(1:num.carriers))
	carrier.list <- rep(carriers, num.user)
	wts <- sample(1:(length(user.id)-1), length(user.id), replace=TRUE)
	wts <- wts/sum(wts)
	wt.mat <- wts%*%(solve(t(wts)%*%wts))%*%t(wts) -
            diag(diag(wts%*%(solve(t(wts)%*%wts))%*%t(wts))) 
	wt.mat <- wt.mat/apply(wt.mat,2,sum)
	call.list <- lapply(1:n.days, function(s){
		day.list <- list()
		day.list <- lapply(1:length(user.id), function(x){
			call.out.vec <- rpois(1, lambda.out)
			who.ind <- sample((1:length(user.id)), call.out.vec, replace=TRUE, prob=wt.mat[x,])
			length.call <-
                            length.no.answer+rbinom(call.out.vec,1,p.answer)*round(rgamma(call.out.vec,shape=alpha,scale=beta)) 
			l.c.m <- floor(length.call/60)
			list(user.id=rep(user.id[x], call.out.vec),
                             carrier=rep(carrier.list[x],
                                 call.out.vec),  
				to.who=user.id[who.ind],
                             to.who.carrier=carrier.list[who.ind],
                             length.call=l.c.m) 
		})
		list(day=s, day.list)
	})
	call.dat <- call.data(call.list, n.days)
	call.dat
}


## These calls automatically generate sample datasets 				##
cdat1 <- phone.list.gen()

cdat2 <- phone.list.gen(num.user=c(30, 10, 20), num.carriers=3, lambda.out=6, 
			p.answer=.8, length.no.answer=60, 
			alpha=15, beta=86400/900, n.days=20)

## This call writes to a .csv file, which is the format indicated in the book ##

write.csv(cdat2, file="cdat2.csv")

	
