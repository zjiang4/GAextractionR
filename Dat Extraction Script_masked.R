


library(RGoogleAnalytics)
library(lubridate)
client.id<-'xxxxxxxxxxxxxxxxxxxxxxxx'
client.secret<-'xxxxxxx'
tableId='ga:xxxxxxxxxxx'
token <- Auth(client.id,client.secret)
invisible(GetProfiles(token))

Loop_start_day<-c(
"2017-01-01",
"2017-02-01",
"2017-03-01",
"2017-04-01",
"2017-05-01",
"2017-06-01",
"2017-07-01",
"2017-08-01",
"2017-09-01",
"2017-10-01",
"2017-11-01",
"2017-12-01")

Loop_end_day<-c(
  "2017-01-31",
  "2017-02-28",
  "2017-03-31",
  "2017-04-30",
  "2017-05-31",
  "2017-06-30",
  "2017-07-31",
  "2017-08-31",
  "2017-09-30",
  "2017-10-31",
  "2017-11-30",
  "2017-12-31")
resultnum<-50000
invisible(GetProfiles(token))
setwd('S:\\Public\\Research Projects\\GA Events Data')
for(i in 9:length(Loop_end_day)){
  temp.start.day<-Loop_start_day[i]
  temp.end.day<-Loop_end_day[i]
  
  query.list <- Init(start.date =as.character(Loop_start_day[i]),
                   end.date = as.character(Loop_end_day[i]),
                   dimensions = "ga:Event Action,ga:Event Category,ga:Event Label",
                   metrics = "ga:Total Events,ga:Unique Events, ga:Event Value",
                   max.results = 50000,
                   table.id = tableId)
  ga.query <- QueryBuilder(query.list)
  ga.data<-tryCatch(GetReportData(ga.query, token,paginate_query = T),
                                   error=function(e){GetReportData(ga.query, token,paginate_query = F)})
  
write.csv(ga.data,paste(temp.start.day,'TO',temp.end.day,'.csv',sep=''),row.names = F)
}
