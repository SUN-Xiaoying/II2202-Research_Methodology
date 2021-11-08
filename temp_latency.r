setwd("/home/xiao/projects/rrr/")

# library
library(ggplot2)
library(tigerstats)
library(dplyr)
library(gcookbook)

lognormal_df <- read.csv(file="./latency/jump/10000_100_lognormal.csv", header=FALSE)
lognormal_data <- as.numeric(lognormal_df$V1)

normal_df <- read.csv(file="./latency/jump/10000_100_normal.csv", header=FALSE)
normal_data <- as.numeric(normal_df$V1)

uniform_df <- read.csv(file="./latency/jump/10000_100_uniform.csv", header=FALSE)
uniform_data <- as.numeric(uniform_df$V1)

data <- c(
    lognormal_data,
    normal_data,
    uniform_data
)
# Total
png("./results/latency/jump_latency_10000_100.png",width=500,height=500)
plot(
    x=density(data)$x,
    y=density(data)$y*100,
    main="Latency of Jump Hashing when requests=10000, server=100",
    xlab="Latency (ms)",
    ylab="Density (%)",
    xlim=c(0,6000), 
    ylim=c(0,max(density(lognormal_data)$y)*100),
    type="l",
    lty=1
    )
lines(
    x=density(normal_data)$x,
    y=density(normal_data)$y*100,
    col="red", lty=2)
lines(
    x=density(lognormal_data)$x,
    y=density(lognormal_data)$y*100,
    col="green", lty=3)
lines(
    x=density(uniform_data)$x,
    y=density(uniform_data)$y*100,
    col="blue", lty=4)
legend(
    "topright",
    legend=c("total", "normal", "lognormal", "uniform"),
    col=c("black","red","green","blue"),
    lty=1:4, cex=0.8
)

dev.off()