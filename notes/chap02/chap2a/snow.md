The snow package
---------------------

### How It Works

snow:
* executes R functions, e.g., lapply(), in parallel
* used a master/worker architecture
* uses different transport mechanisms between the master and workers
  * socket connections, (popular on multicore computers)
  * MPI or PVM (popular on Linux clusters)
  * NetWorkSpaces
  
snow is primarily intended for clusters with MPI.

### Working with It


```r
library(snow)
cl <- makeCluster(4, type = "SOCK")
stopCluster(cl)
cl <- makeCluster(16, type = "MPI")
```

```
## Loading required package: Rmpi
```

```
## 	16 slaves are spawned successfully. 0 failed.
```

```r
stopCluster(cl)
```

```
## [1] 1
```


The first argument of makeCluster is the *cluster specification* and the second is the *cluster type.*

### Parallel K-Means


```r
library(MASS)
result <- kmeans(Boston, 4, nstart = 100)
results <- lapply(rep(25, 4), function(nstart) kmeans(Boston, 4, nstart = nstart))
i <- sapply(results, function(result) result$tot.withinss)
i
```

```
## [1] 1814438 1814438 1814438 1814438
```

```r
result <- results[[which.min(i)]]
result
```

```
## K-means clustering with 4 clusters of sizes 102, 98, 268, 38
## 
## Cluster means:
##      crim     zn  indus    chas    nox    rm   age   dis    rad   tax
## 1 10.9105  0.000 18.573 0.07843 0.6712 5.982 89.91 2.077 23.020 668.2
## 2  0.7413  9.949 12.984 0.06122 0.5822 6.190 73.29 3.332  4.827 406.1
## 3  0.2410 17.817  6.669 0.07463 0.4834 6.465 55.71 4.874  4.313 276.5
## 4 15.2190  0.000 17.927 0.02632 0.6737 6.066 89.91 1.994 22.500 644.7
##   ptratio  black  lstat  medv
## 1   20.20 371.80 17.874 17.43
## 2   17.67 371.66 12.715 22.38
## 3   17.87 387.81  9.538 25.87
## 4   19.93  57.79 20.449 13.13
## 
## Clustering vector:
##   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72 
##   2   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90 
##   3   3   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   3 
##  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 
##   3   3   3   3   3   3   3   3   3   3   2   2   4   2   2   2   2   2 
## 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 
##   2   2   2   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3 
## 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 
##   3   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 
## 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 
##   2   2   2   2   2   2   2   2   2   2   2   4   4   2   2   2   2   2 
## 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 
##   2   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3 
## 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 
##   3   3   3   3   3   3   3   2   2   2   2   2   2   3   3   3   3   3 
## 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 
##   3   2   2   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 
##   3   3   3   3   3   3   3   3   3   3   2   2   2   3   3   3   3   3 
## 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 
##   3   3   3   3   2   2   2   3   3   3   3   3   3   3   3   3   3   3 
## 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 
##   2   2   2   2   2   3   3   3   3   2   2   3   3   3   1   1   1   1 
## 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 
##   1   1   1   1   1   1   1   4   1   1   1   1   1   1   1   1   1   1 
## 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 
##   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1 
## 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 
##   1   1   1   1   1   1   1   1   1   1   1   1   1   4   4   4   4   4 
## 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 
##   4   4   4   4   4   4   1   1   1   4   4   4   4   4   4   4   4   4 
## 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 
##   4   4   4   4   4   4   4   1   1   1   1   1   1   4   1   1   1   1 
## 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 
##   4   1   1   1   4   4   4   4   1   1   1   1   1   1   1   1   4   1 
## 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 
##   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1 
## 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 
##   1   1   1   1   1   1   1   2   2   2   2   2   2   2   2   3   3   3 
## 505 506 
##   3   3 
## 
## Within cluster sum of squares by cluster:
## [1] 181892 395218 924119 313209
##  (between_SS / total_SS =  90.6 %)
## 
## Available components:
## 
## [1] "cluster"      "centers"      "totss"        "withinss"    
## [5] "tot.withinss" "betweenss"    "size"
```



```r
cl <- makeCluster(4, type = "SOCK")
ignore <- clusterEvalQ(cl, {
    library(MASS)
    NULL
})
results <- clusterApply(cl, rep(25, 4), function(nstart) kmeans(Boston, 4, nstart = nstart))
i <- sapply(results, function(result) result$tot.withinss)
result <- results[[which.min(i)]]
result
```

```
## K-means clustering with 4 clusters of sizes 38, 102, 268, 98
## 
## Cluster means:
##      crim     zn  indus    chas    nox    rm   age   dis    rad   tax
## 1 15.2190  0.000 17.927 0.02632 0.6737 6.066 89.91 1.994 22.500 644.7
## 2 10.9105  0.000 18.573 0.07843 0.6712 5.982 89.91 2.077 23.020 668.2
## 3  0.2410 17.817  6.669 0.07463 0.4834 6.465 55.71 4.874  4.313 276.5
## 4  0.7413  9.949 12.984 0.06122 0.5822 6.190 73.29 3.332  4.827 406.1
##   ptratio  black  lstat  medv
## 1   19.93  57.79 20.449 13.13
## 2   20.20 371.80 17.874 17.43
## 3   17.87 387.81  9.538 25.87
## 4   17.67 371.66 12.715 22.38
## 
## Clustering vector:
##   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72 
##   4   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
##  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90 
##   3   3   4   4   4   4   4   4   3   3   3   3   3   3   3   3   3   3 
##  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 
##   3   3   3   3   3   3   3   3   3   3   4   4   1   4   4   4   4   4 
## 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 
##   4   4   4   4   4   4   4   4   4   4   4   4   3   3   3   3   3   3 
## 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 
##   3   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4 
## 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 
##   4   4   4   4   4   4   4   4   4   4   4   1   1   4   4   4   4   4 
## 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 
##   4   4   4   4   4   4   4   4   4   4   3   3   3   3   3   3   3   3 
## 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 
##   3   3   3   3   3   3   3   4   4   4   4   4   4   3   3   3   3   3 
## 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 
##   3   4   4   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 
##   3   3   3   3   3   3   3   3   3   3   4   4   4   3   3   3   3   3 
## 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 
##   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3 
## 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 
##   3   3   3   3   4   4   4   3   3   3   3   3   3   3   3   3   3   3 
## 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 
##   4   4   4   4   4   3   3   3   3   4   4   3   3   3   2   2   2   2 
## 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 
##   2   2   2   2   2   2   2   1   2   2   2   2   2   2   2   2   2   2 
## 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 
##   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 
## 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 
##   2   2   2   2   2   2   2   2   2   2   2   2   2   1   1   1   1   1 
## 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 
##   1   1   1   1   1   1   2   2   2   1   1   1   1   1   1   1   1   1 
## 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 
##   1   1   1   1   1   1   1   2   2   2   2   2   2   1   2   2   2   2 
## 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 
##   1   2   2   2   1   1   1   1   2   2   2   2   2   2   2   2   1   2 
## 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 
##   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 
## 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 
##   2   2   2   2   2   2   2   4   4   4   4   4   4   4   4   3   3   3 
## 505 506 
##   3   3 
## 
## Within cluster sum of squares by cluster:
## [1] 313209 181892 924119 395218
##  (between_SS / total_SS =  90.6 %)
## 
## Available components:
## 
## [1] "cluster"      "centers"      "totss"        "withinss"    
## [5] "tot.withinss" "betweenss"    "size"
```


### Installing Workers


```r
clusterCall(cl, function() {
    library(MASS)
    NULL
})
```

```
## [[1]]
## NULL
## 
## [[2]]
## NULL
## 
## [[3]]
## NULL
## 
## [[4]]
## NULL
```

```r
worker.init <- function(packages) {
    for (p in packages) {
        library(p, character.only = TRUE)
    }
    NULL
}
clusterCall(cl, worker.init, c("MASS", "boot"))
```

```
## [[1]]
## NULL
## 
## [[2]]
## NULL
## 
## [[3]]
## NULL
## 
## [[4]]
## NULL
```

```r
clusterApply(cl, seq(along = cl), function(id) WORKER.ID <<- id)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] 3
## 
## [[4]]
## [1] 4
```

### Load Balancing with clusterApplyLB

clusterApply schedules tasks in a round-robin


```r
cl <- makeCluster(4, type = "SOCK")
set.seed(7777442)
sleeptime <- abs(rnorm(8, 10, 1))
tm <- snow.time(clusterApplyLB(cl, sleeptime, Sys.sleep))
plot(tm)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

```r
stopCluster(cl)
```



```r
cl <- makeCluster(4, type = "SOCK")
set.seed(7777442)
sleeptime <- abs(rnorm(8, 10, 1))
tm <- snow.time(clusterApply(cl, sleeptime, Sys.sleep))
plot(tm)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 

```r
stopCluster(cl)
```

### Task Chunking with parLapply


```r
bigsleep <- function(sleeptime, mat) Sys.sleep(sleeptime)
bigmatrix <- matrix(0, 2000, 2000)
sleeptime <- rep(1, 100)
tm <- snow.time(clusterApply(cl, sleeptime, bigsleep, bigmatrix))
```

```
## Error: invalid connection
```

```r
plot(tm)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 



```r
tm <- snow.time(parLapply(cl, sleeptime, bigsleep, bigmatrix))
```

```
## Error: invalid connection
```

```r
plot(tm)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


### Vectorizing with clusterSplit


```r
clusterSplit(cl, 1:30)
```

```
## [[1]]
## [1] 1 2 3 4 5 6 7 8
## 
## [[2]]
## [1]  9 10 11 12 13 14 15
## 
## [[3]]
## [1] 16 17 18 19 20 21 22
## 
## [[4]]
## [1] 23 24 25 26 27 28 29 30
```

```r
parVapply <- function(cl, x, fun, ...) {
    do.call("c", clusterApply(cl, clusterSplit(cl, x), fun, ...))
}
parVapply(cl, 1:10, "^", 1/3)
```

```
## Error: invalid connection
```


### Load Balancing Redux


```r
parLapplyLB <- function(cl, x, fun, ...) {
    clusterCall(cl, LB.init, fun, ...)
    r <- clusterApplyLB(cl, x, LB.worker)
    clusterEvalQ(cl, rm(".LB.fun", ".LB.args", pos = globalenv()))
}
LB.init <- function(fun, ...) {
    assign(".LB.fun", fun, pos = globalenv())
    assign(".LB.args", list(...), pos = globalenv())
    NULL
}
LB.worker <- function(x) {
    do.call(".LB.fun", c(list(x), .LB.args))
}
```



```r
bigsleep <- function(sleeptime, mat) Sys.sleep(sleeptime)
bigmatrix <- matrix(0, 2000, 2000)
sleeptime <- rep(1, 100)
tm <- snow.time(clusterApplyLB(cl, sleeptime, bigsleep, bigmatrix))
```

```
## Error: invalid connection
```

```r
plot(tm)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 

```r
tm <- snow.time(parLapplyLB(cl, sleeptime, bigsleep, bigmatrix))
```

```
## Error: invalid connection
```

```r
plot(tm)
```




