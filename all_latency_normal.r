setwd("/home/xiao/projects/rrr/")
# library
library(ggplot2)
library(tigerstats)
library(dplyr)

ch_f <- read.csv(file="./latency/ch/10000_100_uniform.csv", sep="\n", header=FALSE)
ch <- as.numeric(unlist(ch_f))

rendezvous_f <- read.csv(file="./latency/rendezvous/10000_100_uniform.csv", sep="\n", header=FALSE)
rendezvous <- as.numeric(unlist(rendezvous_f))

mpc_f <- read.csv(file="./latency/mpc/10000_100_uniform.csv", sep="\n", header=FALSE)
mpc <- as.numeric(unlist(mpc_f))

maglev_f <- read.csv(file="./latency/maglev/10000_100_uniform.csv", sep="\n", header=FALSE)
maglev <- as.numeric(unlist(maglev_f))

jump_f <- read.csv(file="./latency/jump/10000_100_uniform.csv", sep="\n", header=FALSE)
jump <- as.numeric(unlist(jump_f))

png("./results/latency/all_latency_uniform.png",width=500,height=500)
plot(
    x=density(ch)$x,
    y=density(ch)$y*100,
    main="Latency of various Hashing when requests=10000, server=100",
    xlab="Latency (ms)",
    ylab="Density (%)",
    xlim=c(0,6000), 
    ylim=c(0,max(density(maglev)$y)*100),
    type="l",
    col="black",lty=1
    )
lines(
    x=density(rendezvous)$x,
    y=density(rendezvous)$y*100,
    col="red", lty=2)
lines(
    x=density(mpc)$x,
    y=density(mpc)$y*100,
    col="green", lty=3)
lines(
    x=density(maglev)$x,
    y=density(maglev)$y*100,
    col="blue", lty=4)
lines(
    x=density(jump)$x,
    y=density(jump)$y*100,
    col="purple", lty=5)

legend(
    "topright",
    legend=c("ch","rendezvous","mpc","maglev","jump"),
    col=c("black","red","green","blue","purple"),
    lty=1:5, cex=0.8
)
dev.off()