The mclapply Function
---------------------

### How It Works

multicore:  
* runs on Posix-based multiprocessor and multicore systems  
* uses the fork() system call  
* is intended for embarrassingly parallel applications  
* implements a parallel lapply() operation  

### Working with It

#### The mclapply Function

The `mclapply()` function is a replacement for `lapply()`



```r
library(parallel)
library(MASS)
result100 <- kmeans(Boston, 4, nstart=100)
results <- mclapply(rep(25, 4), function(nstart) kmeans(Boston, 4, nstart=nstart))
i <- sapply(results, function(result) result$tot.withinss)
i
```

```
## [1] 1814438 1814438 1814438 1814438
```

```r
result25 <- results[[which.min(i)]]
result25
```

```
## K-means clustering with 4 clusters of sizes 38, 102, 268, 98
## 
## Cluster means:
##         crim       zn     indus       chas       nox       rm      age
## 1 15.2190382  0.00000 17.926842 0.02631579 0.6737105 6.065500 89.90526
## 2 10.9105113  0.00000 18.572549 0.07843137 0.6712255 5.982265 89.91373
## 3  0.2410479 17.81716  6.668582 0.07462687 0.4833981 6.465448 55.70522
## 4  0.7412906  9.94898 12.983776 0.06122449 0.5822347 6.189847 73.28878
##        dis       rad      tax  ptratio     black     lstat     medv
## 1 1.994429 22.500000 644.7368 19.92895  57.78632 20.448684 13.12632
## 2 2.077164 23.019608 668.2059 20.19510 371.80304 17.874020 17.42941
## 3 4.873560  4.313433 276.5485 17.87313 387.81407  9.538022 25.86530
## 4 3.331821  4.826531 406.0816 17.66633 371.66429 12.714898 22.37857
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
## [1] 313208.7 181891.7 924118.8 395218.3
##  (between_SS / total_SS =  90.6 %)
## 
## Available components:
## 
## [1] "cluster"      "centers"      "totss"        "withinss"    
## [5] "tot.withinss" "betweenss"    "size"         "iter"        
## [9] "ifault"
```
#### The mc.cores Option

`mclapply` automatically starts workers using `fork()`. By default, the number of workers is the number of cores on the computer. The workers inherit the functions, variables, and environments of the master process making explicit worker initialization unnecessary (unlike snow). `fork()` is very fast since since it doesn't copy process data until it is needed, called _copy-on-write_. Forking is done every time `mclapply()` is called giving workers a virtual copy of the master environment at the time of execution of `mclapply()`.

The number of cores can be set by the `mc.cores` option or the `options()` function.


```r
unique(unlist(mclapply(1:100, function(i) Sys.getpid(), mc.cores = 8)))
```

```
## [1] 23595 23597 23599 23601 23603 23605 23607 23609
```

```r
options(cores = 8)
unique(unlist(mclapply(1:100, function(i) Sys.getpid())))
```

```
## [1] 23611 23613
```

#### The mc.set.seed Option

If `mc.set.seed` is set to `TRUE`, `mclapply()` will seed each worker with a different value when created.


```r
mclapply(1:3, function(i) rnorm(3), mc.cores = 8, mc.set.seed = FALSE)
```

```
## [[1]]
## [1] 0.9154947 0.3751885 0.3762161
## 
## [[2]]
## [1] 0.9154947 0.3751885 0.3762161
## 
## [[3]]
## [1] 0.9154947 0.3751885 0.3762161
```

```r
rnorm(1)
```

```
## [1] 0.9154947
```

```r
mclapply(1:3, function(i) rnorm(3), mc.cores = 8, mc.set.seed = FALSE)
```

```
## [[1]]
## [1]  0.3751885  0.3762161 -1.2013589
## 
## [[2]]
## [1]  0.3751885  0.3762161 -1.2013589
## 
## [[3]]
## [1]  0.3751885  0.3762161 -1.2013589
```

```r
set.seed(7777442)
mclapply(1:3, function(i) rnorm(3), mc.cores = 8, mc.set.seed = TRUE)
```

```
## [[1]]
## [1]  0.4310908 -1.1890815 -0.2537214
## 
## [[2]]
## [1] -0.2074483  1.1327926  0.8896215
## 
## [[3]]
## [1]  0.5909239  1.0067881 -0.2272811
```

#### Load Balancing with mclapply

By default, `mclapply()` works like snow's `parLapply()`, i.e., it preschedules the work by dividing it into as many tasks as cores.

Balance the work of workers by setting `mc.preschedule` to `FALSE`. This makes `mclapply()` work like snow's `clusterApplyLB()`. Set to `FALSE` if the tasks are both long and varying in length.


```r
set.seed(93564990)
sleeptime <- abs(rnorm(5, 10, 10))
system.time(mclapply(sleeptime, Sys.sleep, mc.cores = 8))
```

```
##    user  system elapsed 
##   0.075   0.128  21.338
```

```r
system.time(mclapply(sleeptime, Sys.sleep, mc.cores = 8, mc.preschedule = FALSE))
```

```
##    user  system elapsed 
##   0.095   0.149  21.339
```
#### The pvec Function

A high-level fumction to execute vector functions in parallel. It is similar to the `parVapply()` function developed in the snow chapter.


```r
x <- 1:10
pvec(x, "^", 1/3)
```

```
##  [1] 1.000000 1.259921 1.442250 1.587401 1.709976 1.817121 1.912931
##  [8] 2.000000 2.080084 2.154435
```
The worker function is executed on subvectors of the input vector. `mc.set.seed` and `mc.cores` are supported arguments.

### The parallet and collect Functions


```r
fun1 <- function() {Sys.sleep(10); 1}
fun2 <- function() {Sys.sleep(5); 2}
fun3 <- function() {Sys.sleep(1); 3}
f1 <- parallel(fun1())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f2 <- parallel(fun2())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f3 <- parallel(fun3())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
collect(list(f1, f2, f3))
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

`parallel()` is like a submit operation and `collect()` is like a wait operation.

### Using collect Options

wait and timeout are two options that determine how long collect waits for jobs to finish. If wait=TRUE, then collect waits until all jobs are finished. If `wait=FALSE`, then collect waits up to timeout seconds.


```r
f1 <- parallel(fun1())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f2 <- parallel(fun2())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f3 <- parallel(fun3())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
collect(list(f1, f2, f3), wait=FALSE)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
Sys.sleep(15)
collect(list(f1, f2, f3), wait=FALSE)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```


```r
f1 <- parallel(fun1())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f2 <- parallel(fun2())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f3 <- parallel(fun3())
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
collect(list(f1, f2, f3), wait=FALSE, timeout=1000000)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE, timeout=1000000)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE, timeout=1000000)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE, timeout=1000000)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE, timeout=1000000)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE, timeout=1000000)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

```r
collect(list(f1, f2, f3), wait=FALSE, timeout=1000000)
```

```
## Error in eval(expr, envir, enclos): could not find function "collect"
```

### Parallel Random Generators

No built-in support in `multicore` for `rlecuyer` or `rsprng`. Since high-level functions `fork`, you can't initialize workers once and use them repeatedly.


```r
library(snow)
nw <- 8
seed <- 7777442
kind <- 0
para <- 0
f1 <- parallel({
    initSprngNode(0, nw, seed, kind, para)
    rnorm(1)
})
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f2 <- parallel({
    initSprngNode(1, nw, seed, kind, para)
    rnorm(1)
})
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
f3 <- parallel({
    initSprngNode(2, nw, seed, kind, para)
    rnorm(1)
})
```

```
## Error in eval(expr, envir, enclos): could not find function "parallel"
```

```r
unlist(collect(list(f1, f2, f3)), use.names = FALSE)
```

```
## Error in unlist(collect(list(f1, f2, f3)), use.names = FALSE): could not find function "collect"
```

