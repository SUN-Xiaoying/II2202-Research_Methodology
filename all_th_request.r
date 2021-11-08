setwd("/home/xiao/projects/rrr/")
# library
library(ggplot2)
library(tigerstats)
library(dplyr)

df <- read.table(file="./throughput/consistent_hashing.csv", sep="\t", header=TRUE)
data <- df[,1:6][df$num_servers==100,]

df1 <- read.table(file="./throughput/rendezvous_hashing.csv", sep="\t", header=TRUE)
data1 <- df1[,4:6][df1$num_servers==100,]

df2 <- read.table(file="./throughput/maglev_hashing.csv", sep="\t", header=TRUE)
data2 <- df2[,4:6][df2$num_servers==100,]

df3 <- read.table(file="./throughput/mpc_hashing.csv", sep="\t", header=TRUE)
data3 <- df3[,4:6][df3$num_servers==100,]

df4 <- read.table(file="./throughput/jump_hashing.csv", sep="\t", header=TRUE)
data4 <- df4[,4:6][df4$num_servers==100,]

x <- data$num_requests[data$distribution=="normal"]

ch <- as.numeric(data$throughput[data$distribution=="normal"])/1000
rendezvous <- as.numeric(data1$throughput[data1$distribution=="normal"])/1000
maglev <- as.numeric(data2$throughput[data2$distribution=="normal"])/1000
mpc <- as.numeric(data3$throughput[data3$distribution=="normal"])/1000
jump <- as.numeric(data4$throughput[data4$distribution=="normal"])/1000

X <- data.frame(x, ch, rendezvous, maglev, mpc, jump)
colnames(X) <- c("x","ch","rendezvous","maglev","mpc","jump")

# p <- ggplot(X,
#     aes(x=x)
# ) + 
# geom_line(aes(y=ch),col="black", linetype=1)+
# geom_line(aes(y=rendezvous),col="red",linetype=2)+
# geom_line(aes(y=maglev),col="blue",linetype=3)+
# geom_line(aes(y=mpc),col="green",linetype=4)+
# geom_line(aes(y=jump),col="purple",linetype=5)+
# # labs(title="Standard Error of Maglev Hashing", x="Requests per server", y ="Standard Error")
# labs(title="Throughput of various Hashing algorithms when num_servers=100", 
#     x="The number of requests (ops)", 
#     y ="Throuhput (million ops/s)")
# # scale_color_manual(values = c("darkred", "steelblue"))
# ggsave("./results/throughput/all_throughput_server=100.png", p, width=9.5)

png("./results/throughput/all_throughput_server=100.png",width=700)
plot(
    x=x,
    y=ch,
    main="Throughput of various Hashing when num_servers=100", 
    xlab="The number of requests (ops)", 
    ylab="Throuhput (million ops/s)",
    # xlim=c(0,100), 
    ylim=c(0,max(jump)),
    type="l",
    col="black",lty=1
    )
lines(
    x=x,
    y=rendezvous,
    col="red", lty=2)
lines(
    x=x,
    y=mpc,
    col="green", lty=3)
lines(
    x=x,
    y=maglev,
    col="blue", lty=4)
lines(
    x=x,
    y=jump,
    col="purple", lty=5)
legend(
    x=44000,
    y=450,
    legend=c("ch","rendezvous","mpc","maglev","jump"),
    col=c("black","red","green","blue","purple"),
    lty=1:5, cex=0.8
)
dev.off()