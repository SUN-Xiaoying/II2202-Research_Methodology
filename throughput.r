setwd("/home/xiao/projects/rrr/")
# library
library(ggplot2)
library(tigerstats)
library(dplyr)

dt <- read.table(file="consistent_hashing.csv", sep="\t", header=FALSE, fill=TRUE)

# server=3, x=command
dt_server_3 <- read.table(file="cs_s3.csv", sep="\t", header=FALSE,fill=TRUE)
command <- c(
    rep(1000,3), 
    rep(2000,3), 
    rep(3000,3), 
    rep(4000,3), 
    rep(5000,3), 
    rep(6000,3), 
    rep(7000,3), 
    rep(8000,3),
    rep(9000,3),  
    rep(10000,3))
throughput_s3 <- dt_server_3[,4]
distribution <-rep(c("uniform", "normal", "lognormal"), 10)

# throughput_sever_3.png | Grouped Bars Graph
p3 <- ggplot(dt_server_3, aes(fill=distribution, y=throughput_s3, x=command))+
geom_bar(position="dodge",stat="identity")+
labs(title="Throughput when server=3 ", x="command", y ="throughput [ops/ms]")
ggsave("./results/throughput_sever_3.png", p3, width=15)



# command=5000, x=server
dt_command_5000 <- dt[,1:4][dt$V1==5000,]

server <- c(
    rep(3,3), rep(4,3), rep(5,3),
    rep(6,3), rep(7,3), rep(8,3), rep(9,3), rep(10,3),
    rep(11,3), rep(12,3), rep(13,3), rep(14,3), rep(15,3),
    rep(16,3), rep(17,3), rep(18,3), rep(19,3), rep(20,3)
)

throughput_c5 <- as.numeric(dt_command_5000[,4])
distribution_c5 <- rep(c("uniform", "normal", "lognormal"), 18)

# throughput_command_5000.png | Grouped Bars Graph
p <- ggplot(dt_command_5000, aes(fill=distribution_c5, x=server, y=throughput_c5))+geom_bar(position="dodge",stat="identity")+labs(title="Throughput when command=5000",x="server", y="throughput [ops/ms]")
ggsave("./results/throughput_command_5000.png",p, width=15)
