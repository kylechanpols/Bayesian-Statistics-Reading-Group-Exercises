################################
# Univariate Modelling
# Instructions: Fill in the blanks [?]
# Edited by Kyle Chan
################################

################################### The Posterior Probability ##################

# Almost all Bayesian models focus on using the Bayes' rule to acquire the posterior probability.
# Center to Bayesian methods is the posterior probability $Pr(\theta|X)$, where $\theta$ is some unknown parameter in the model.
# Example of $\theta$ : $\lambda$ in the Poisson Distn., p in the Bernuolli Distn.
# The quantity $Pr(\theta|X)$ is given by the following:
# Pr(\theta|X) = \frac{p(\theta) L(\theta|X)}{\int_\Theta p(\theta) L(\theta|X) d\theta}
# where Large \Theta denotes the set of all $\thetas$, $\theta \in \Theta$. 
#There might be multiple thetas when we are modelling based on a multivariate distn. (e.g. the Multivariate Normnal)

#In words, what we observe from this quantity is that $Pr(\theta |X) \propto p(\theta)L(\theta|X)$.
#Why? note that RHS has both p(\theta)L(\theta|X), so the posterior quantity must be proportional to $p(\theta)L(\theta|X)$.

#In plain English: the Posterior Probability is proportional to the Prior * the Likelihood function

############################ Conjugation : Finding the Posterior Probability ####
# Problem: we begin with a joint distribution (e.g. Bernuolli - f(y,p)).
# We need to arrive at the posterior probability f(p|y).

# By definition of the posterior, we need the following: f(p|y) = f(y,p) / f(y)
# f(y,p) = f(y|p)f(p)
  #-> $[nCy * p^y (1-p)^{n-y}]$ * $\frac{\Gamma(A+B)}{\Gamma(A)\Gamma(B} *p^{A-1} (1-p)^{B-1}$

# f(y) = Integrate f(y,p) w.r.t. p ("Doing the Integral without doing calculus", Why? Because a large part of the
#Integral is evaluated on a constant!)

# then compute f(p|y) -> Conjugate of the Bernuolli: p|y ~beta(y+A, n-y+B) (see Hoff Ch.2-3 for the example of the Uniform Distn.;
#formal definition on p.38)


#################### [?] Ex.1 The Bernuolli Model ##########################################
# Suppose you conducted 100 randomized experiment, where 60 of them gave you the results that you were expecting.
# Suppose you have no idea what the prior distribution should look like, so you used the prior set [0,0].


# A. Plot the prior distribution.
library(ggplot2)
a <- ? ; b <- ? #prior
n <- ?; y<-? #data
theta <- seq(0,1, length=100) #all possible theta values to consider
prior <- dbeta(theta, ?,?)
plotdat <- data.frame(theta = theta,
                      prior = prior)
pri_plot <- ggplot(plotdat, aes(x=theta, y=prior))+
  geom_point()+
  geom_line()+
  theme_bw()+
  xlab(expression(theta))+
  ylab("Density")
pri_plot

# B. Plot the posterior distribution.
#Hint: We've just discussed the conjugate above.

posterior <- dbeta(theta, ?, ?) #put the conjugate here.
plotdat <- data.frame(theta = theta,
                      post = posterior)
post_plot <- ggplot(plotdat, aes(x=theta, y=post))+
  geom_point()+
  geom_line()+
  theme_bw()+
  xlab(expression(theta))+
  ylab("Density")

post_plot

# C. Compute the 95% confidence interval of the probability of observing a successful experiment. 
qbeta(c(?,?), ?, ?)#put the conjugate here.

# D. Plot the Highest Posterior Density (HPD) region.
bounds <- qbeta(c(?,?), ?, ?)

post_hpd <- post_plot +
  geom_vline(xintercept=bounds[1])+ #lower bound
  geom_vline(xintercept=bounds[2]) #upper bound
  
post_hpd

# E. Juxtapose the Prior and the Posterior plots. How confident are you in finding successful results after the update?
library(gridExtra)
grid.arrange(pri_plot, post_hpd)  

#################### [?] Ex.2 The Poisson Model ##########################################
# Suppose an IR researcher is modelling the frequency of militarized-interstate disputes (MIDs) involving the United States between 1946 - 2010 in each year.
# She does not know very much what priors she should use, so she started by assuming a prior set of [2,1].


# A. Plot the Prior Distribution.
mid <- read.csv("mid-usa.csv")
mid <- mid[,2:3] #get rid of the extra column.

# B. Plot the Posterior Distribution.
# Hint: What is the conjugate? See Hoff p.46 if you forgot!

# C. Find the 95% Posterior Confidence Interval of Lambda.

# D. A colleague complained that the prior parameters creates a prior distribution too flat.
# He said that there is no way that the US would start only around 1 war every year, reflecting on history.
# He argued that the shape of the prior distribution should be centered more around a lambda between 2 or 3.
# Revise the prior probabilities and re-compute the posterior distribution of theta, allowing the prior to center around a value between 2-3.

#Hint: the shape and scale of the gamma is deteremined by shape parameter a and scale parameter 1/b. See : https://en.wikipedia.org/wiki/Gamma_distribution for details.


# E. Juxtapose the prior and posterior distributions of part B & D, to see the impact of changing the priors.
# Is your colleague's concerns justified?

# F. Compute the updated mean of the Poisson Distribution, and conclude your findings.