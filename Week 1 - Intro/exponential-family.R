################################
# Introduction to Distribution Functions
# Instructions: Fill in the blanks [?]
# Edited by Kyle Chan
################################

#In R, there is a set of built-in functions to calculate quantities in a particular Distribution. 
#In Bayesian statistics we usually work with exponential family distributions. Exponential family distributions
#tend to have a clearly defined conjugate form that can help us obtain the posterior probabilities easily (more on this in week 2!)

#Exponential family distribution is a collection of distributions that follow a generic canonical form.
#Examples include: the Normal Distribution, the Bernuolli Distribution, the Poisson Distribution, the Gamma Distribution, the Beta Distribution etc.

#non-expoentnial family distributions e.g. : the Cauchy Distribution (cool fact: the Cauchy has no known mean and variance values.)

################################################################################
#Exponential Family Functions in R
#in R, names of the distribution functions are in the following form:

#*[distribution name]()
#for example: dnorm(), pnorm(), rnorm(), qnorm().

#Example of distributions available:
#Normal Distribution - *norm()
#Poisson Distribution - *pois()
#Binomial Distribution -*binom()
#Exponential Distribution - *exp()
#Bernuolli Distribution - *bern() (from mc2d/ Rlab packages)
#Gamma Distribution - *gamma()
#Beta Distribution - *beta()


#d-series functions are density functions. In other words, this gives the output of a probability density function (pdf) of a particular distribution.
# e.g. dnorm(0,mean= 0, sd =1) gives the density (i.e. Pr[X=0]) given that X ~ N(0,1).

#[?] What is this quantity?
dnorm(-2,mean=0,sd=1) 
#Hint: Plot the following density
plot(density(rnorm(100)))
#Take a look at where -2 is.

#[?] Compute Pr[X=1], given that X~Poisson(2).
dpois([?])

#p-series functions give the "probability functions", i.e. Pr(X< value of your choice).
# e.g. pnorm() - gives the probability function of the normal distribution (need to specify q - the value of the random variable X in question.)

#[?] What is this quantity?
pnorm(-2, mean=0,sd=1)
#Hint: Plot the following density
plot(density(rnorm(100)))
#Take a look at where -2 is.

#pnorm has a parameter lower.tail=TRUE. This means that we are looking at Pr[X <= x]. If you set this to false, then you will obtain Pr[X>x].
#[?] What is this quantity?
pnorm(-2, mean=0,sd=1, lower.tail=F)

#[?] S(t) is said to be the survival function given a random variable t. If t~ exp(lambda= 1), compute S(3).
pexp([?])


#q-series functions give the "quantile function". This can be thought of as the inverse of the cumulative density function (cdf) or the inverse of the p-class functions.
#This is very useful for making inference.
# e.g.  - gives the 99th percentile of the normal distribution (default to mean = 0, sd = 1).

#[?] what is this quantity?
qnorm(.99,  mean = 0, sd = 1)

#[?] Compute the 75th percentile of X ~ Poisson(Lambda = 1).
qpois([?])

#r-series functions generate random quantities that follow a particular distribution.
# e.g. rnorm(100) - generates 100 random values that~N(0,1).

#[?] What does this code do?
rnorm(n=10, mean=0, sd=1)

#[?] Visualize the Gamma Function by generating 100 samples. Assume that X ~ gamma(alpha = 1, beta= 0.5).
#Hint: use plot(density(X)) to visualize a distribution.
#Hint: put ? before a function to pull the help file out if you are unsure what paraemters to put in. e.g. ?dnorm

plot(density([?]))
