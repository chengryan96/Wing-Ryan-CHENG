# STEP0 Loading library ---------------------------------------------------

library(rpart)
library(tseries)
library(quantmod)
library(lubridate)
library(nnet)
library(dplyr)
library(stringr)


# STEP1 Read in data  ---------------------------------------------------------
# 1.1 Dow Jones ---------------------------------------------------------------
DJI<-as.data.frame(get.hist.quote(instrument="^DJI",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))

# 1.2 Other Index in America --------------------------------------------------
GSPC<-as.data.frame(get.hist.quote(instrument="^GSPC",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
IXIC<-as.data.frame(get.hist.quote(instrument="^IXIC",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
RUT<-as.data.frame(get.hist.quote(instrument="^RUT",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
VIX<-as.data.frame(get.hist.quote(instrument="^VIX",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
Index<-cbind(GSPC, IXIC, RUT, VIX)

# 1.3 Other stock market --------------------------------------------------
AAPL<-as.data.frame(get.hist.quote(instrument="AAPL",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
AXP<-as.data.frame(get.hist.quote(instrument="AXP",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
BA<-as.data.frame(get.hist.quote(instrument="BA",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
CAT<-as.data.frame(get.hist.quote(instrument="CAT",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
CSCO<-as.data.frame(get.hist.quote(instrument="CSCO",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
CVX<-as.data.frame(get.hist.quote(instrument="CVX",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
DIS<-as.data.frame(get.hist.quote(instrument="DIS",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
GS<-as.data.frame(get.hist.quote(instrument="GS",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
HD<-as.data.frame(get.hist.quote(instrument="HD",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
IBM<-as.data.frame(get.hist.quote(instrument="IBM",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
INTC<-as.data.frame(get.hist.quote(instrument="INTC",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
JNJ<-as.data.frame(get.hist.quote(instrument="JNJ",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
JPM<-as.data.frame(get.hist.quote(instrument="JPM",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
KO<-as.data.frame(get.hist.quote(instrument="KO",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
MCD<-as.data.frame(get.hist.quote(instrument="MCD",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
MMM<-as.data.frame(get.hist.quote(instrument="MMM",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
MRK<-as.data.frame(get.hist.quote(instrument="MRK",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
MSFT<-as.data.frame(get.hist.quote(instrument="MSFT",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
NKE<-as.data.frame(get.hist.quote(instrument="NKE",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
PFE<-as.data.frame(get.hist.quote(instrument="PFE",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
NKE<-as.data.frame(get.hist.quote(instrument="NKE",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
PG<-as.data.frame(get.hist.quote(instrument="PG",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
TRV<-as.data.frame(get.hist.quote(instrument="TRV",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
UNH<-as.data.frame(get.hist.quote(instrument="UNH",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
UTX<-as.data.frame(get.hist.quote(instrument="UTX",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
VZ<-as.data.frame(get.hist.quote(instrument="VZ",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
WBA<-as.data.frame(get.hist.quote(instrument="WBA",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
WMT<-as.data.frame(get.hist.quote(instrument="WMT",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
XOM<-as.data.frame(get.hist.quote(instrument="XOM",'2010-1-1','2018-12-31',quote=c('Open','Close','High','Low','Volume')))
stock<-cbind.data.frame(AAPL, AXP, BA, CAT, CSCO, CVX, DIS, GS, HD, IBM, INTC, JNJ, JPM, KO, MCD, MMM, MRK, MSFT, NKE, PFE, PG, TRV, UNH, UTX, VZ, WBA, WMT, XOM)

searcher<-function(iNo){
  scher<-matrix(NA,nr=32,nc=2)
  colnames(scher)<-c('Number','Index or Company')
  rownames(scher)<-paste('No.',1:32,sep='')
  scher[,1]<-1:32
  scher[,2]<-c( 'GSPC', 'IXIC', 'RUT', 'VIX', 'AAPL', 'AXP', 'BA', 'CAT', 'CSCO', 'CVX', 'DIS', 'GS', 'HD', 'IBM', 'INTC', 'JNJ', 'JPM', 'KO', 'MCD', 'MMM', 'MRK', 'MSFT', 'NKE', 'PFE', 'PG', 'TRV', 'UNH', 'UTX', 'VZ', 'WBA', 'WMT', 'XOM')
  return(scher[iNo,])
}

# STEP2 Manage and Setup --------------------------------------------------

# 2.1 Dow Jones -----------------------------------------------------------

# 2.1.1 Define Position ---------------------------------------------------

# Dedine the position of Dow Jones Index closing price compring to the end of the month
n<-nrow(DJI) # no. of obs. on DJI
mon<-substring(rownames(DJI),6,7) # mon is the indicator of month
id<-ifelse(mon[2:n] != mon[1:n-1],TRUE,FALSE) # indicator of the last day on each month 
id<-c(id,TRUE)
Position.m<-rep(NA,n) # attribute that the position of closing price today comparing to end of corresponding month
# 1 states as higher position while 0 states as lower position 
jPos<-1 # Pointer for Position entry
for(iDate in 1:nrow(DJI)){ 
  if (id[iDate]==TRUE) jPos<-jPos+1
  Position.m[iDate]<-ifelse(DJI[iDate,2]>=DJI[id,2][jPos],1,0) 
}

# 2.1.2 Define Extended Attributes  ---------------------------------------

# develop the attribute of DJI 
# daily percentage change of closing price; mean and standard deviation of closing price in before 20 days; mean over sigma square
u<-(lag(DJI$Close)-DJI$Close)/DJI$Close # daily percentage change 
mu<-rep(NA,n)    # Empty vector 
sigma<-rep(NA,n) # Empty vector 
for (iDate in 21:n){ 
  mu[iDate]<-mean(DJI$Close[(iDate-20):iDate])  # mean 
  sigma[iDate]<-sd(DJI$Close[(iDate-20):iDate]) # standard deviation 
}
mos<-mu/sigma^2 # mean over sigma square

# combine all the useful attributes together
DJI.f<-cbind(DJI$Open,lag(DJI$Close),lag(DJI$High),lag(DJI$Low),lag(log(DJI$Volume)),u,mos)
colnames(DJI.f)<-c('Open_x','Close_x','High_x','Low_x','Voulme_x','u_x','MoSs_x')


# 2.2 Other Index and stock market ----------------------------------------

# 2.2.1 Clean Up the Attributes  ------------------------------------------

Istock<-cbind(Index,stock)
# derive the attributes open, close, high, low and volume from the corresponding Index and stock
open<-Op(Istock)
close<-Cl(Istock)
high<-Hi(Istock)
low<-Lo(Istock)
volume<-Vo(Istock)
colnames(open)<-paste('Open_',1:ncol(close),sep='')
colnames(close)<-paste('Close_',1:ncol(close),sep='')
colnames(high)<-paste('High_',1:ncol(close),sep='')
colnames(low)<-paste('Low_',1:ncol(close),sep='')
colnames(volume)<-paste('Volume_',1:ncol(close),sep='')


# 2.2.2 Define Extended Attributes ----------------------------------------

# develop the attributes of other Index and stock market closing price
# daily percentage change of closing price; mean and standard deviation of closing price in before 20 days; mean over sigma square
u<-matrix(NA,nr=n,nc=ncol(close))     # Empty matrix 
mu<-matrix(NA,nr=n,nc=ncol(close))    # Empty matrix
sigma<-matrix(NA,nr=n,nc=ncol(close)) # Empty matrix
mos<-matrix(NA,nr=n,nc=ncol(close))   # Empty matrix
for (jStock in 1:ncol(close)){
  u[,jStock]<-(lag(close[,jStock])-close[,jStock])/close[,jStock] # daily percentage
  for (iDate in 21:n){
    mu[iDate,jStock]<-mean(close[(iDate-20):iDate,jStock])        # mean 
    sigma[iDate,jStock]<-sd(close[(iDate-20):iDate,jStock])       # standard deviation
  }
  mos[,jStock]<-mu[,jStock]/sigma[,jStock]^2                      # mean over sigma square
}
colnames(u)<-paste('u',1:ncol(close),sep='_')
colnames(mu)<-paste('mu',1:ncol(close),sep='_')
colnames(sigma)<-paste('sigma',1:ncol(close),sep='_')
colnames(mos)<-paste('MoSs',1:ncol(close),sep='_')

# put the data attribute from previous day into present day
# ie. close, high, low, volume
for (iAttr in 1:4){ 
  for (iCol in 1:ncol(close))
    if (iAttr==1) close[,iCol]<-lag(close[,iCol])
    else if (iAttr==2)high[,iCol]<-lag(high[,iCol])
    else if (iAttr==3) low[,iCol]<-lag(low[,iCol])
    else volume[,iCol]<-lag(volume[,iCol])
}
volume<-volume[,-4]
# combine Other Index and Stocks
OIS<-cbind(open,close,high,low,log(volume),u,mos) 

# 2.3 Combine All the Attributes ------------------------------------------

# develop the finalized data frame 
data<-cbind(Position.m,DJI.f,OIS) # combine the attribute
data<-data[-c(1:21,n),]           # since the position of current day is unknown and the first 21 days have unknow mean and sigma, we drop it

# 2.4 Outlier detection  --------------------------------------------------

# function of mahalanobis distance
##mdist<-function(x){ 
##  t<-as.matrix(x)
##  m<-apply(t,2,mean)
##  s<-var(t)
##  mahalanobis(t,m,s)
##}
##t0<-data[data$Position.m==0,] # the data with position 0
##t1<-data[data$Position.m==1,] # the data with position 1
##dim(t0)                       # dimension 
##dim(t1)

##x<-t0[,2:ncol(data)]              # select  perdictor variable 
##md<-mdist(x)                      # show the mahalanobis distance
##c<-qchisq(0.99,df=ncol(data)-1)   # indicator that defines outlier
##plot(md);abline(h=c)              # plot 
##tc0<-t0[md<c,]                    # remove outlier

##x<-t1[,2:ncol(data)] 
##md<-mdist(x) 
##c<-qchisq(0.99,df=ncol(data)-1) 
##plot(md);abline(h=c) 
##tc1<-t1[md<c,] 

# combine the remaining data
##data<-rbind(tc0,tc1) 

# STEP3 Seperate data  ----------------------------------------------------

n<-nrow(data)
set.seed(4002)                      # set random seed
idt<-sample(1:n,size=ceiling(n*0.8)) # generate id
d1<-data[idt,]                       # training dataset
d2<-data[-idt,]                      # testing dataset

# STEP4 Data anlaysis -----------------------------------------------------

# 4.1 Classification Tree -------------------------------------------------


# 4.1.1 Standard  ---------------------------------------------------------

ctree1<-rpart(Position.m~.,data=d1,method='class') 
print(ctree1) # print ctree
printcp(ctree1)
plotcp(ctree1)
plot(ctree1,asp=15) # plot ctree
text(ctree1,use.n=T,cex=0.7) # add text

# in-sample classification table 
pr<-predict(ctree1) # in-sample
cl<-max.col(pr) # column index of max. pr
table(cl,d1$Position.m)

# out-sample classification table 
pr<-predict(ctree1,d2)
cl<-max.col(pr) # column index of max. pr
table(cl,d2$Position.m)

# 4.1.2 Prepruning  ---------------------------------------------------------

ctree2<-rpart(Position.m~.,data=d1,method='class',control=rpart.control(cp=0,maxdepth=5,minsplit=100)) 
print(ctree2) # print ctree
plot(ctree2,asp=15) # plot ctree
text(ctree2,use.n=T,cex=0.6) # add text

# in-sample classification table 
pr<-predict(ctree2) # in-sample
cl<-max.col(pr) # column index of max. pr
table(cl,d1$Position.m)

# out-sample classification table 
pr<-predict(ctree2,d2)
cl<-max.col(pr) # column index of max. pr
table(cl,d2$Position.m)

# 4.1.3 Postpruning  ---------------------------------------------------------

ctree3<-prune(ctree1,cp=0.013)
print(ctree3) # print ctree
plot(ctree3,asp=15) # plot ctree
text(ctree3,use.n=T,cex=0.6) # add text

# in-sample classification table 
pr<-predict(ctree3) # in-sample
cl<-max.col(pr) # column index of max. pr
table(cl,d1$Position.m)

# out-sample classification table 
pr<-predict(ctree3,d2)
cl<-max.col(pr) # column index of max. pr
table(cl,d2$Position.m)

