#Work around for R 4.0.2 Windows Users

#Manually Install the latest version of Rstan and Stanheaders:
install.packages(
  "https://artifacts.r-hub.io/StanHeaders_2.21.0-6.tar.gz-d74e0af7c9e06cba7d975cd8d3dbcf87/StanHeaders_2.21.0-6.zip",
  repos = NULL, type = "win.binary")
install.packages(
  "https://artifacts.r-hub.io/rstan_2.21.2.tar.gz-639222303bb62625e2349320b5adb986/rstan_2.21.2.zip",
  repos = NULL, type = "win.binary")

#Edit Makevars.win:
file.edit("~/.R/Makevars.win")

#Change CXX14FLAGS into the following line and save:

#CXX14FLAGS=-O3 -mtune=native -mmmx -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2

#Run the following code to see if a null stan model runs. If it says Compilation Error then Rstan is not installed properly.
example(stan_model, package = "rstan", run.dontrun = TRUE)
