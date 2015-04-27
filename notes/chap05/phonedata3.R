phone.dat <- function(num.user=10, num.provider=1, lambda.out=5, 
			p.answer=.8, length.no.answer=45, 
			alpha=10, beta=86400/900, n.days=10){
	user.id <- factor(c(1:num.user))
	providers <- factor(c(1:num.provider))
	user.list <- list()
	user.list[as.numeric(user.id)] <- as.character(user.id)
	wts <- sample(1:(length(user.id)-1), length(user.id), replace=TRUE)
	wts <- wts/sum(wts)
	wt.mat <- wts%*%(solve(t(wts)%*%wts))%*%t(wts) - diag(diag(wts%*%(solve(t(wts)%*%wts))%*%t(wts)))
	wt.mat <- wt.mat/apply(wt.mat,2,sum)
	call.list <- lapply(1:length(user.list), function(s){
		day.list <- list()
		day.list <- lapply(1:n.days, function(x){
			call.out.vec <- rpois(1, lambda.out)
			c.time <- rexp((call.out.vec+1), (call.out.vec+1)/86400)
			call.time <- 86400*(cumsum(c.time))/sum(c.time)
			call.time <- round(call.time[-(call.out.vec+1)])
			to.who <- sample(user.id, call.out.vec, replace=TRUE, prob=wt.mat[s,])
			length.call <- length.no.answer+rbinom(call.out.vec,1,p.answer)*round(rgamma(call.out.vec,shape=alpha,scale=beta))
			end.time <- call.time+length.call
			list(day = x, n.calls.out=call.out.vec, to.who=to.who, start.time=call.time, end.time=end.time)
		})
		list(user.id=user.list[[s]], day.list)
	})
	call.data <-function(call.list, user.id){
		ind <- 1:length(user.id)
		vec.list <- list()
		vec.list <- lapply(ind, function(h){
			num.calls <- length(call.list[[h]][[2]])
			to.who <- unlist(lapply(1:num.calls, function(d){call.list[[h]][[2]][[d]][[3]]}))
			call.time <- unlist(lapply(1:num.calls, function(d){call.list[[h]][[2]][[d]][[4]]}))
			end.time <- unlist(lapply(1:num.calls, function(d){call.list[[h]][[2]][[d]][[5]]}))
			call.day <- rep(c(1:num.calls), times=sapply(1:num.calls, function(z){call.list[[h]][[2]][[z]][[2]]}))
			id <- rep(call.list[[h]][[1]], length(to.who))
			list(user.id=id, day=call.day, to.who=to.who, call.time=call.time, end.time=end.time) 
		})
		call.data1 <- do.call(rbind, lapply(vec.list, as.data.frame))
		call.data2 <- call.data1[,c(3,2,1,4,5)]
		dimnames(call.data2)[[2]] <- dimnames(call.data1)[[2]]
		call.data <- rbind(call.data1, call.data2, deparse.level=2)
		in.out <- rep(c("OUT", "IN"), c(dim(call.data1)[[1]], dim(call.data2)[[1]]))
		call.data <- cbind(call.data, in.out)
		call.data <- call.data[order(call.data$call.time),]
		call.data <- call.data[order(call.data$day),]
		call.data <- call.data[order(call.data$user.id),]
		call.data
	}
	call.dat <- call.data(call.list, user.id)
	call.dat
}



cdat <- phone.dat()


	
