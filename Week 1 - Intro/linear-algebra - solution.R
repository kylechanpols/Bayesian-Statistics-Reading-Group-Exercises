################################
# Linear Algebra Functions in R
# Instructions: Fill in the blanks [?]
# Edited by Kyle Chan
################################

# Vector
# A vector can be understood as a list of elements. E.g. a variable on how many hours of TV did people watch over the past week. Sampling 1000 individuals,
#we will have a vector of 1000 observations: [x_1, x_2, x_3 .... x_1000]. 

# [?] Run the following code. Does this code generate a vector? If so, what is it?
# It generates a vector of 10 observations that follow X~N(2,1).
rnorm(10, mean=2, sd=1)

# [?] Assume the researcher is interested in simulating how many hours of TV people usually watch in Hong Kong in a week.
# The research assumes that people will watch at least 5 hours a week, and no more than 10 hours a week.
# Help the research simulate 100 observations on this question.
# Hint: use sample(), with replacement (replace= TRUE) to obtain a random sample given a specific vector of quantities to sample from.
hours = 5:10
sample(hours, size=100, replace=TRUE)

# Matrix
# A matrix is said to be n*p if it has n rows and p columns.
# Most datasets follow the form of a matrix, with n observations and p variables.
# In R, we construct a matrix using matrix().
# matrix() has the following parameters:
# nrow - How many rows should the matrix have
# ncol = How many columns should the matrix have
# byrow = TRUE - if the values should be populated by row. If set to false, the values will be populated by column.

#See ?matrix for parameters and instructions.

# [?] Run the following code. What does this code do?
# Populate a 3*3 matrix that could either take on values 0 and 1.
quantities = sample(0:1, size=9, replace=T)
matrix(quantities, nrow=3, ncol=3, byrow=TRUE)

# [?] Construct a 2*2 matrix that looks like the following:
# 0 1
# 1 0

matrix(c(0,1,1,0), nrow=2, ncol=2, byrow=TRUE)

# Dot Product
# The dot product is essentially the multiplication of two vectors that yields a single value, which is called a scalar.
# A more intuitive intepretation of the dot product is to multiple two vectors indicating different direction and magnitude. See https://www.mathsisfun.com/algebra/vectors-dot-product.html for such an intepretation.

# Suppose we have two vectors : [0,1] , [1,0] and we want to compute their dot product. To compute this by hand, the dot product is:
0*1 + 1*0
# = 0
# To implement the dot product in R, it takes only a few simple steps:
vec1 = c(0,1) #create vector 1 [0,1]
vec2= c(1,0) #create vector 2 [1,0]
sum(vec1 * vec2) #dot product of the two vectors.

# [?] Compute the dot product of [1,2,3] and [1,5,7] in R.
sum(c(1,2,3)*c(1,5,7))

# Scalars and Matrix Multiplication
# A scalar is a quantity that has dimensions 1*1.
# If we want to multiply two matrices, the dimensions would matter.

# Matrix * scalar : Every element in the matrix would be mulitplied by the scalar:
# For example:
# 1 0
# 0 1
# Multiplied by a scalar 2:

# 2 0
# 0 2

# you can also implement this in R easily:
matrix(c(1,0,0,1), nrow=2, ncol=2, byrow=T) * 2


# Matrix * Matrix: This only works if the dimensions are compatible.
# Suppose Matrix 1 is of dimension a*b, Matrix 2 is of dimension c*d, 
# Then b must = c, otherwise a matrix multiplication does not exist.

# and because Matrix multiplication depends on the dimensions of the matrices, the multiplication sequence
# also matters. Unlike in normal algebra where a * b = b * a, A * B =/= B * A in linear algebra.

# For example:
# Finding the matrix multiplication of 
#1 0
#0 1
#and
# 1 2
# 3 4

#by hand we use the dot product:
#cell 0,0:
#[1,0] * [1,3] = 1
#cell 0,1:
#[1,0] * [2,4] = 2

#and thus the resulting matrix is:
#1 2
#3 4

#How do we do that in R?
#A simple guess would be:
m1 <- matrix(c(1,0,0,1), nrow=2, ncol=2, byrow=T)
m2 <- matrix(c(1,2,3,4), nrow=2, ncol=2, byrow=T)

m1 * m2
#Not quite what we expected! What went wrong?
# if we use one star * - this returns the element-wise multiplication, not matrix multiplication.
#by hand, what R did for us was:
#cell 0,0:
#1 * 1 = 1
#cell 0,1:
#0*2 = 0

#etc.

#Which is why the result differs from what we had in mind. To do matrix multiplication in R you need to use the special operator %*%:
m1 %*% m2

#which yields the same result as our estimates by hand.

# [?] Suppose we have the following matrix:
# 1 2 3
# 4 5 6

# Multiply this matrix with a scalar of -1.
matrix(c(1,2,3,4,5,6),nrow=2, ncol=3, byrow=T)* -1

# [?] The Linear Regression model follows the following format: y = X\$beta\
# where y is a vector of dependent variables of size N
# X is a matrix of observed independent variables of size N*p , p being the number of independent variables in your model
# and $\beta$ is a vector of coefficients associated with the independent variable matrix X.
# in the linear regression model, the first entry in $\beta$ is always the intercept.

# Assume the researcher is modelling the hours of TV watched in Hong Kong, and they believe that this quantity is likely to be\
# affected by the number of people in the household.
# The researcher assumes that there is an intercept of 0, and the coefficient associated with the number of people in the household is 0.5.
# Suppose the researcher has obtained 10 samples of number of people in their household:
# [1, 1 , 1, 3, 4, 5,2 , 2 , 2 , 1]
# Estimate the hours of TV watched in Hong Kong among these 10 observations.

# Hint : X should be of dimension 10*2, where the first column is just a vector of 10 zeros. This is essentially what the intercept does in the linear regression model.
# It is the estimated quantity of y holding all else = 0.

beta = c(0, 0.5)
X = matrix(
  c(rep(0,10),c(1, 1 , 1, 3, 4, 5,2 , 2 , 2 , 1)),
  nrow=10,
  ncol=2,
  byrow=F)
epsilon = rep(0,10)

X %*% beta + epsilon

# Transpose of a matrix
# You can think of the transpose of a matrix as "flipping" the dimensions of a matrix
# For example, if matrix A is of dimension n*p, then the transpose of A AT is of dimension p*n. The cells will be reorganized accordingly.
# to do this in R, you just call the transpose function t()

# [?] What does this code do? It gives the transpose of the matrix "mat"
mat = matrix(c(1,1,2,2,3,3),nrow=3,ncol=3,byrow=T)
t(mat)

# Inverse of a matrix
# The Inverse of a matrix can be thought of finding the reciprocal of a matrix 1/X.
# In linear algebra, division cannot be done directly. One has to work through the inverse of a matrix.

# Define the Identity Matrix I, which is a matrix of size n*p where the diagonal value is all 1s, and everything else 0.
# The inverse of a matrix A, A^-1 is thus:
# A * A^-1 = A^-1 * A = I.

# I am not going to cover the calculation of the inverse by hand as it involves finding the determinant. For details
# you can look at : https://www.mathsisfun.com/algebra/matrix-inverse.html

# Note that an inverse of the matrix does not always exist.

# For example, find the inverse of the following matrix:
#4 7
#2 6
# in R we can use the function solve():
inv = solve(matrix(c(4,7,2,6), nrow=2, ncol=2, byrow=T))
inv
# as per our definition, if you multiply the inverse with the original matrix, you should get the identity I:
matrix(c(4,7,2,6), nrow=2, ncol=2, byrow=T) %*% inv

# [?] Find the inverse of the following matrix:
#3 3.5
#3.2 3.6
solve(matrix(c(3, 3.5, 3.2, 3.6), nrow=2, ncol=2, byrow=T))

# [?] Recall in the linear regression model, \$beta_{ols}$ is defined as the following:
# (XTX)^-1 XTy

# Suppose we have y = [0,1,2,3,4]
# and we have observed two exact same variables that take on the following values: [1,1,0,0,1]
# Can you recover beta for this model? Why or why not?

y = c(0,1,2,3,4)
x = c(1,1,0,0,1)
X = matrix(c(rep(0,5),x,x), nrow=5, ncol=3)

beta_ols = solve(X %*% t(X)) %*% (t(X) %*% y)

# No, you cannot, because the inverse (XTX)^-1 does not exist. This is because the two variables take on the same exact
# value and thus the matrix would not have an inverse.
# This problem is also known as multicollinearity.

