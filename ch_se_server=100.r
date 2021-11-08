setwd("/home/xiao/projects/rrr/")
# library
library(ggplot2)
library(tigerstats)
library(dplyr)

df1 <- read.table(file="./throughput/consistent_hashing.csv", sep="\t", header=TRUE)


data <- df1[,1:6][df1$num_servers==100,]

x <- data$num_requests[data$distribution=="normal"]
normal<- as.numeric(data$standard_error[data$distribution=="normal"])
lognormal <- as.numeric(data$standard_error[data$distribution=="lognormal"])
uniform<- as.numeric(data$standard_error[data$distribution=="uniform"])

total_data <- c(
    lognormal,
    normal,
    uniform
)
X <- data.frame(x, lognormal, normal, uniform)
colnames(X) <- c("x","lognormal","normal","uniform")

png("./results/se/ch_se_server=100.png",width=750)
plot(
    0,0,
    main="Standard Error of Consistent Hashing when server=100",
    xlab="The number of Requests (ops)",
    ylab="Standard Error",
    xlim=c(1000,50000), 
    ylim=c(0,2.2),
    type="n"
    )
lines(
    x=x,
    y=normal,
    col="red", lty=1)
lines(
    x=x,
    y=lognormal,
    col="green", lty=2)
lines(
    x=x,
    y=uniform,
    col="blue", lty=3)
legend(
    "topright",
    legend=c("normal", "lognormal", "uniform"),
    col=c("red","green","blue"),
    lty=1:3, cex=0.8
)

dev.off()