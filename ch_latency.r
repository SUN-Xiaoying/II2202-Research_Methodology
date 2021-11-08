setwd("/home/xiao/projects/rrr/")

# library
library(ggplot2)
library(tigerstats)
library(dplyr)
library(gcookbook)

lognormal_df <- read.csv(file="./latency/ch/10000_100_lognormal.csv", header=FALSE)
lognormal_data <- as.numeric(lognormal_df$V1)

normal_df <- read.csv(file="./latency/ch/10000_100_normal.csv", header=FALSE)
normal_data <- as.numeric(normal_df$V1)

uniform_df <- read.csv(file="./latency/ch/10000_100_uniform.csv", header=FALSE)
uniform_data <- as.numeric(uniform_df$V1)

data <- c(
    lognormal_data,
    normal_data,
    uniform_data
)
# Total
png("./results/latency/ch_latency_10000_100.png",width=500,height=500)
plot(
    x=density(data)$x,
    y=density(data)$y*100,
    main="Latency of Consistent Hashing when requests=10000, server=100",
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
    lty


# ch <- as.numeric(unlist(data))
# rendezvous <- as.numeric(unlist(data1))
# maglev <- as.numeric(unlist(data2))
# mpc <- as.numeric(unlist(data3))
# jump <- as.numeric(unlist(data4))=1:4, cex=0.8
)

# 2. Lognormal
# png("./results/latency/ch/ch_lognormal_latency_10000_100.png",width=500,height=500)
# plot(density(lognormal_data), 
#     main="Lognormal Lantency when command=1000, server=10",
#     xlab="Lantency",
#     ylab="Density",col="red",xlim=c(0,max(lognormal_data)))

# 3. Normal
# png("./results/latency/ch/ch_normal_latency_10000_100.png",width=500,height=500)
# plot(density(normal_data), 
#     main="Normal Lantency when command=1000, server=10",
#     xlab="Lantency",
#     ylab="Density",col="blue",xlim=c(0,max(normal_data)))

# 4. Uniform
# png("./results/latency/ch/ch_uniform_latency_10000_100.png",width=500,height=500)
# plot(density(uniform_data), 
#     main="Uniform Lantency when command=1000, server=10",
#     xlab="Lantency",
#     ylab="Density",col="green",xlim=c(0,max(uniform_data)))
dev.off()