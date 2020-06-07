################################
# POLI 783 Lab: Introduction to R and Loops
# Instructions: The symbol [?] is a blank for you to fill in. Erase the question mark, and write your answer inside the brackets. Submit your revised script file via the Assignments tab on Sakai.
# Note: Adapted from T.Ryan's 417 assignment
################################

#### INTRODUCTION
# Q1: Run the following commands:

x<-5 # This command does this: Create a constant of x with value 5
x+8 # This command does this: Calculate x+8 = 13
ls() # This command does this: lists the objects in the global environment


# Q2: Run the following commands. What is going on? Fill in short comments where the [?] appears.
x <- "Go"
y <- "Heels!"
z <-c(x,y) # [?] This command does what? It creates a new variable z by combining variables of x & y
z
ls()
rm(x) # [?] This command does what? Removes variable x
ls()
z[1]
z[2] # R generates the output it does here because z is a vector consisting of "Go" and "Heels!". This command specifies the second string in the vector, which is "Heels!"
z[2] <- "TARHeels" # [?] This command does what? Repalces the second string in vector z with "TARHeels"
z
ls()
rm(list=ls()) # [?] Clears the global environment
ls() # The output "Character(0)" means [?] The global environment is empty


# Q3: Fill in short comments where [?] appears. Make sure to EXPLAIN what you see. Don't just copy and paste the output. What is R doing?
rm(list=ls())
x <-c(1,2,4,5,10)
x
x[4]
x[-4] # This shows [?] Shows vector X without the 4th entry in the vector (5)
sum(x) # This shows [?] sum of all values in vector x
sum(x[-4]) # This shows [?] sum of all values in vector x except the 4th entry (5)
rm(x)

# Q4: Fill in short comments where [?] appears
rm(list=ls())
1:10 # This returns [?] A sequence from 1 to 10
x<-(1:10)
x
x[7]<-54 # This does what [?] Replaces the 7th entry in vector x with 54
x

# Q5: Below, write code that calculates the sum of all integers from 4028 to 8415, inclusive.


# Q6: Now we'll get a little more sophisticated with lists and extraction. Fill in the blanks. As always, explain. Don't just copy and paste output.
rm(list=ls())
pages<-c(1:10) 
typos<-c(3,4,0,3,9,12,0,3,4,2) # Pretend data on the number of typos for each page.
length(typos) # Shows the number of entries/ values in vector 'typos'
pages[typos == 3] # Note there are TWO equal signs there. Won't work with just one. This shows the location of values that equal to 3 in the vector 'typos'
pages[typos>3] # Shows the location of values that are greater than 3 in the vector 'typos'
min(typos) # shows the minimum value in vector 'typos'
max(typos) # shows the maximum value in vector 'typos'
median(typos) # shows the median of vector 'typos'
var(typos) # calculates the variance of the values in vector 'typos'

####

#### LOADING AND VIEWING DATA
# Now, let's practice with loading in data. Pretend I went to basketball practice with 10 UNC basketball players and gave 5 of them advice on how to make more free throws. Then, all ten players took 100 shots from the free throw line. The dataset shows how many throws they made (variable: throws), whether or not they received my advice (variable: advice), and an indicator for the player (variable: player). 

# First, load the data bball.csv into an object called "mydata"
mydata<-read.csv("bball.csv")


var(mydata$throws) # This produces the number: 330.4556. (You don't need to understand this command or result. I'm just making sure you successfully loaded the data.)

# Q7 After loading the data, run the following commands and observe the results. Fill in the sentences/questions that follow.

mydata
mydata[2,]
mydata[4,]
mydata[,1]
mydata[,3]
mydata[4,3]
mydata$throws
mydata$throws[7]
mydata$advice
mydata$throws[mydata$advice==1]
mydata$throws[mydata$advice==0]
mean(mydata[,2])
# Experiment with more combinations as you like.

# Typing the name of an object tells R to display the whole object.
# Including square braces [] after the name of the object tells R to display a portion of the object.
# When we put a number BEFORE a comma in the braces, R does this: Retrieves the row associated with that number
# When we put a number AFTER a comma in the braces, R does this: Retrieves the column associated with that number
# The $ symbol after the name of an object tells R to: Display the variable associated with the name after the $ in an object
# The command mydata$throws[mydata$advice==1] tells R to: Retrieve the number of throws for players who have received your advice
# What do you suppose the command mean(mydata[,2]) does? Computes the mean of the second column (i.e. advice), =.5

# Q8: Below, type two commands: one to calculate the average shooting percentage for players who received my advice, 
#and a second to calculate the average shooting percentage for players who did not receive my advice.
sum(mydata$throws[mydata$advice==1])/nrow(mydata[mydata$advice==1,]) #average shooting % for players who received your advice = 52%
sum(mydata$throws[mydata$advice==0])/nrow(mydata[mydata$advice==0,]) #average shooting % for players who receied youra dvice = 78.6%


# Does it seem like my advice helped?
sum(mydata$throws[mydata$advice==1])/nrow(mydata[mydata$advice==1,])>sum(mydata$throws[mydata$advice==0])/nrow(mydata[mydata$advice==0,])
#No

##### LOOPS
# Sometimes, we want R to do something over and over again several times in a row????????perhaps hundreds of
# times in a row. This is done with a loop. There are a few different ways you can write a loop, but we????????ll
# focus on a simple one called a ???????for??????? loop. A simple example appears below. The first line here sets up the
# variable i as a ???????counter.??????? The ???????1:3??????? part tells R, ???????You????????re going to execute the commands within the loop
# three times: once with i equal to 1, once with i equal to 2, and once with i equal to 3. The first command
# in the loop prints the current value of i on the screen. The second command divides i by 3, and prints the
# result on the screen. The closed curly brace ends the loop. Notice that I indent lines within the loop. This
# is not strictly necessary, but it????????s good formatting practice. It makes it easier to see what is within the loop, versus not. (If I were writing a loop within a loop, which is sometimes important, I????????d indent a second level.)
for (i in 1:3) {
  print(i)
  print(i/3)
}

# Q9 Run the following loop. Run it a few times.
rm(list=ls())
for (i in 1:20) {
  samp<-sample(10,5)
  print(samp)
}

# The sample() command does this: for sample(x,n) , it creates a random sample of x entries where values are less or equal than n

# As currently written, the loop runs this many times: 20
# To change the loop to run 46 times, I would do this: for (i in 1:46)

# Q10 Write a loop that prints even numbers from 2 to 30 on the screen.
for (i in 1:15){
  val<-i*2
  print(val)
}

# Q11 Run the following loop a few times. Note: For illustration, I chose 1789 because that's the year UNC was founded. The number could have been anything. (Try changing it and see what happens.)
rm(list=ls())
  for (i in 1:20){
  set.seed(1789)
  samp<-sample(10,5)
  print(samp)
}
# The set.seed command does this: it sets the number of seeds for R's random number generator.


# Q12 Run the following commands
rm(list=ls())
results <- c() # This just makes an object called results, but leaves it empty for now. Think of this object as a "bucket" where we're going to store output from our loop.

for (i in 1:10) {
  samp<-sample(100,4)
  results[i]<-mean(samp) # This line does this: Stores the mean of each randomly generated sample into vector 'results'.
}

results # What are these numbers?: 69.25 59.50 41.75 64.00 48.00 47.25 48.75 81.75 40.25 43.50
median(results) # What number do you get? Why? 48.375. Because the number of values in the vector is even. Therefore, the median is the 5th + 6th value /2
#see:
sorted<-sort(results)
print((sorted[5]+sorted[6])/2)
#=48.375

length(results[results>50]) # What does this command tell us? How many times did the loop generate samples with a mean over 50.

# Take particular note of what the line just above does. Remembering it will help you avoid headaches later on.

# Q13 Modify the Q12 loop to run for (i in 1:100) and then (i in 1:1000). How do you expect the output of the "median" command change, and why?
# It should fluctuate a little bit around the original result, as we are simulating samples over a larger number of times. Since the generation process is random, the values should also be random, and thus the median would fluctuate too.
#However:
for (i in 1:100) {
  samp<-sample(100,4)
  results[i]<-mean(samp) # This line does this: Stores the mean of each randomly generated sample into vector 'results'.
}
results.100<-results
median(results.100)

for (i in 1:1000) {
  samp<-sample(100,4)
  results[i]<-mean(samp) # This line does this: Stores the mean of each randomly generated sample into vector 'results'.
}
results.1000<-results
median(results.1000)
#medians of results.100 and results.1000 are the same.

# Q14 Run the commands below. Run them a few times, to figure out what they do.
rm(list=ls())
rbinom(10,1,.5) # This simulates flipping a coin ten times in a row. (0 = heads, 1 = tails.)
series <- rbinom(10,1,.5)
length(series[series==1]) 

# I flipped a coin ten times, and it landed on tails eight of the ten times. Wow! What are the chances?
#Well, you tell me. Below, write a loop that conducts 1,000 experiments.
#In each experiment, simulate flipping a coin ten times, and record how many of the flips come up as tails.
#Then, looking over the 1000 experiments, tell me what percentage of the time at least 8 of ten flips come up tails. (At least 7 of 10? At least 9 of 10?)
rm(list=ls())
experiment<-NA
results<-NA
for(i in 1:1000){
  experiment <- rbinom(10,1,.5)
  results[i] <- length(experiment[experiment==1])
}
#at least 7 of 10
length(results[results>=7])/1000
#at least 8 of 10
length(results[results>=8])/1000
#at least 9 of 10
length(results[results>=9])/1000

# Q15 Gabby is playing a new board game. She has $100 in game currency. When it is her turn, she has the option to participate in a lottery, which can result in her either winning $10 or losing $10. Alternatively, she can decline to participate, in which case she just keeps steady at $100.

# Here is how the lottery works. Gabby will roll two die. One die has 4 sides numbered 1 through 4. The other has 5 sides numbered 1 through 5. Gabby rolls both simultaneously and adds the two numbers together. She wins if the total is 2, 3, 4, 8, or 9. She loses if the total is 5, 6, or 7.

# Should Gabby take a chance on the lottery, or should she skip it? (Which choice maximizes her money, in expectation?) Solve the problem as follows:

# 1: Write a loop that runs for 10,000 iterations.

# 2: In each iteration, simulate flipping one four-sided die, and one five-sided die. (Hint: Use the sample command, not rbinom. The latter was for coin flips.) After rolling two die--and also within the loop--add the two results together. Store this total in an object that we can look at once the loop has run 10,000 times. (This object will ultimately have 10,000 numbers in it.)

# 3: Write some additional commands to count up which is greater: the number of times the result was 2, 3, 4, 8, or 9 (combined)? OR the number of times the result was 5, 6, or 7 combined?

# You should also convert your result to a sensible summary conclusion: "Gabby has a XX percent chance of winning, and a XX percent chance of losing. So she should play the lotter / not play the lottery.


# Write your code below:
###########################
rm(list=ls())
die1<-rep(NA,10000)
die2<-rep(NA,10000)
roll<-rep(NA,10000)
results<-rep(NA,10000)
for(i in 1:10000){
    die1[i]<-sample(4,1)
    die2[i]<-sample(5,1)
    roll[i]<-die1[i]+die2[i]
    results[i]<-ifelse(roll[i]>=5&&roll[i]<=7,FALSE,TRUE)
}
length(results[results==TRUE]) #times of winning : 4417
length(results[results==TRUE])/length(results) #P(Winning)
1-(length(results[results==TRUE])/length(results))#P(Losing)
#Gabby has a 44.17 percent chance of winning, and a 55.83 percent chance of losing. So she should NOT play the lottery.
