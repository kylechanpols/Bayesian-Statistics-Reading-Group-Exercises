###############################################################################
#Markov-Chain Monte Carlo Simulations (MCMC)
#Edited by Kyle Chan
###############################################################################

#MCMC is an algorithm that helps us sample the posterior probability when there's more than
#one unknown parameter to recover.

#Markov-chain : a Markov-chain is a chain of events that are only dependent on
#the latest preceding event. i.e. value at t is dependent on t-1, but not t-2/ t+1, so on and so forth.

#Monte Carlo: The idea to acquire a sample using RNGs given some model parameters, e.g. prior distribution, prior values, etc.
#the r-series distribution functions can be said to MC functions.

#MCMC: Construct a chain of "guess parameters", and update the parameter guesses using guesses from the previous parameter.


## [?] Example 1. A Simple MC exercise : find the distribution of Beta ########
#Suppose you want to find out how measurement error affects the estimates of
# beta ols. You can demonstrate this using a simple MC technique.

# Part A. Fit a simple OLS model with 100 observations, acquire an MC sample of 100 betas and plot the beta for X.
#Assume the following:
# X ~ N(0,1)
# Y~ N(0,1)
library(MASS)
library(ggplot2)
set.seed(999) #set this to 999 to ensure replicability.
x <- rnorm(?)
y <- rnorm(?)
mod <- lm(?)

b <- ? #Beta
varcov <- ? #Variance-Covariance Matrix
beta_ols <- mvrnorm(100, b, varcov) #Generate a distribution of Beta.

plotdat<- as.data.frame(cbind(x, beta_ols[,"x"]))
colnames(plotdat) <- c("data", "beta")
ggplot(plotdat, aes(x=beta))+
  geom_density()+
  theme_bw()
# Part B. Suppose we do not observe true X, but observed X hat instead, which has some measurement error.
# Suppose X hat = X + epislon, where epsilon ~ N(0,1). (i.e. You're over-estimating X.)
# Call this beta using X hat beta hat. Acquire an MC sample of 100 beta hats and plot its distribution.

xh <- ?
mod_error <- update(mod, .~. - x + xh)
bh <- ?
varcovh <- ?
beta_hat_ols <- mvrnorm(100, bh, varcovh)

plotdat<- as.data.frame(cbind(xh, beta_hat_ols[,"xh"]))
colnames(plotdat) <- c("data", "beta")
ggplot(plotdat, aes(x=beta))+
  geom_density()+
  theme_bw()

# Part C. Now compare the beta estimates in a single plot. What happens when X is over-estimated?
?
  
## [?] Example 2. The Gibbs Sampler.
# The Gibbs sampler iterate through values in the parameters to acquire an accurate posterior distribution.
# Below is an exercise that constructs the Gibbs sampling algorithm by hand to demonstrate roughly how the Gibbs sampler works.

### Part A. Suppose you are a researcher studying the public mood towards the Chief Executive. 0 degrees = the person feels very alienated, cold from the CE;
# 100 degrees = the person feels very attached, warm around the CE.
# Assuming that the mood data is distributed normal. You collected the 100 observations and wanted to model this distribution.
# You expect the people to feel around 50 degrees, which is the half point of the scale 0-100. You expect that after the massive protests,
# People are polarized so the variance could be quite high, sitting around 20 degrees.
# Now find the posterior mean and average variance of the distribution of mood, using the Gibbs Sampler to solve for mean mu and variance sigma.
# Note: you'll need two additional prior parameters here. Hoff calls it sigma not squared and nu not squared.
# These are parameters used to generate a prior "guess" of the sigma term. You can use s20 = .01 and nu0 = 1 here. (More on this when we talk about the Normal/ Multivariate Normal!)

###data
vals <- seq(?)
mood <- sample(?)
mean.y <- ?
var.y <- ?
n <- length(mood)

###priors (see p.89 of Hoff for what these are)
mu0 <- ? #mu not, the mu value for the mean of the prior normal distribution.
t20 <- ? # tau not square, the sigma value for the mean of the prior normal distribution.
s20 <- .01 #sigma not square, the sigma value associated with the calculation of the beta term for the variance of the prior normal distribution.
nu0 <- 1 #nu0 , the term associated with the calculation of the alpha and beta terms for the variance of the prior normal distribution.

###starting values
S <- ? #Number of itereations
PHI <- matrix(NA,nrow=S, ncol=2, byrow=TRUE) # a 1000*2 matrix, where each row is an iteration of guesses, each column is a parameter - here = mu & sigma.
PHI[1,] <- phi <-  ?#data

### Gibbs Sampling
for(s in 2:S){
  #generate new theta value from its full conditional
  mun <- (mu0/t20 + n*mean.y*phi[2]) / (1/t20 + n*phi[2])
  t2n <- 1/(1/t20+ n*phi[2])
  phi[1] <- rnorm(1, mun, sqrt(t2n))
  
  #generate new 1/sigma^2 value from its full conditional
  nun <- nu0+n
  s2n <- (nu0*s20)+(n-1)*var.y + n*(mean.y- phi[1])^2 / nun
  phi[2] <- rgamma(1,nun/2, nun*s2n/2)

PHI[s,] <- phi
}

PHI[S,] #first quantity = posterior mean, second quantity = posterior average variance.

#Part B. Plot a "history" of the Gibbs sampler. Plot the first 5 observations, 20 observations, 100 observations, 1000 observations.
PHI$i <- seq(?)
colnames(PHI) <- c("mean", "var","iter")
PHI <- as.data.frame(PHI)

plot5<- ggplot(PHI[1:5,], aes(x=mean, y=var))+
  geom_point()+
  geom_text(aes(label = iter))+
  geom_line()+
  theme_bw()

plot20 <- ?

plot100 <- ?
  
plot1000 <- ?

library(gridExtra)

grid.arrange(plot5,plot20,plot100,plot1000)

### [?] (Optional) Example 3: The Metropolis-Hastings Algorithm
#Consider example 2 again. What happens when we use the Metropolis-Hasting Algorithm instead??

## Part A. Replace the Gibbs Sampler with the Metropolis-Hastings. How different are the results?

###data
vals <- ?
mood <- ?
mean.y <- ?
var.y <- ?
n <- ?

###priors (see p.89 of Hoff for what these are)
mu0 <- ? #mu not, the mu value for the mean of the prior normal distribution.
t20 <- ? # tau not square, the sigma value for the mean of the prior normal distribution.
s20 <- ? #sigma not square, the sigma value associated with the calculation of the beta term for the variance of the prior normal distribution.
nu0 <- ? #nu0 , the term associated with the calculation of the alpha and beta terms for the variance of the prior normal distribution.

###starting values
S <- ? #Number of itereations
PHI <- ? # a 1000*2 matrix, where each row is an iteration of guesses, each column is a parameter - here = mu & sigma.
PHI[1,] <- phi <-  ? #data

### Metropolis-Hastings
for(s in 2:S){

  #generate new theta value from its full conditional
  currentphi_1 <- PHI[?,1] #get the previous value.
  
  mun <- (mu0/t20 + n*mean.y*phi[2]) / (1/t20 + n*phi[2])
  t2n <- 1/(1/t20+ n*phi[2])
  proposedphi_1 <- ? #proposed phi.
  
  r_phi <- ? #this is called r in Hoff.
  
  phi[1] <- ifelse(runif(1)<r_phi, proposedphi_1, currentphi_1) #set the next quantity to either the proposed new value, or the old value, with probability min(1,r) and max(0, 1-r).
  
  #generate new 1/sigma^2 value from its full conditional
  
  currentphi_2 <- ?
  
  nun <- nu0+n
  s2n <- (nu0*s20)+(n-1)*var.y + n*(mean.y- phi[1])^2 / nun
  proposedphi_2 <- phi[2] <- rgamma(1,nun/2, nun*s2n/2)
  
  r_phi <- ?
  
  phi[2] <- ?
  
  PHI[s,] <- phi
}

#Part B. plot the "history" of the Metropolis. What's the result after 5 iterations, 20 iterations, 100 iterations and 1000 iterations?
?
