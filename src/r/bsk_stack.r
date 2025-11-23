BSKStack <- function(whiteRatio = 0.3, blueRatio = 0.4) {
  data <- list()
  list(
    push = function(x) {
      data <<- c(list(list(color='W', value=x)), data)
    },
    zones = function() {
      n <- length(data)
      w <- as.integer(n * whiteRatio)
      b <- as.integer(n * (whiteRatio + blueRatio))
      c(w,b)
    },
    pop = function() {
      if(length(data)==0) stop("empty")
      z <- zones()
      w <- z[1]; b <- z[2]
      for(i in seq_len(min(w,length(data)))) {
        if(data[[i]]$color %in% c('W','B')) {
          val <- data[[i]]$value
          data <<- data[-i]
          return(val)
        }
      }
      for(i in (w+1):min(b,length(data))) {
        if(i>0 && data[[i]]$color=='B') {
          val <- data[[i]]$value
          data <<- data[-i]
          return(val)
        }
      }
      stop("Red zone is locked")
    },
    update_colors = function() {
      z <- zones(); w <- z[1]; b <- z[2];
      for(i in seq_along(data)) {
        if(i <= w) data[[i]]$color <<- 'W'
        else if(i <= b) data[[i]]$color <<- 'B'
        else data[[i]]$color <<- 'R'
      }
    },
    len = function() length(data)
  )
}