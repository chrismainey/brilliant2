#' My lower confidence interval function
#'
#' @description This function takes a mean and standard error and returns the value of lower limit of a normally distributed confidence interval.

#' @param value Input parameter for the function
#' @param se The standard error for the sample
#' @param prob The probability for the confidence interval, e.g. 0.95 for 95\%, based on the desired coverage.
#'
#' @note This function will automatically convert to two-tailed probability, e.g. 0.95 to 0.975.
#'
#' @return A numeric value for confidence interval
#' @export
#'
#' @examples
#' #' # With a value of 100 and a known standard error of of 10, a 95% interval is:
#' my_CI_lower(100, 10)
#'
#' # A 99.8% interval for the same is:
#' my_CI_lower(100, 10, 0.998)
#'
my_CI_lower <- function(value, se, prob=0.95){

  two_tail_prob <- (1-prob) / 2

  ci_lower <- value - (qnorm(two_tail_prob,mean=0, sd=1) * se)

 return(ci_lower)

}
