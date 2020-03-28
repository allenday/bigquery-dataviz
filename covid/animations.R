library(usmap)
library(ggplot2)

#set output resolution
dpi=72

covid = read.csv('~/Downloads/results-20200328-150508.csv')

#plot
for ( covid.idx in 5:69 ) {
dateparts = as.numeric(unlist(strsplit(sub("X_","",colnames(covid)[covid.idx]),"_")))
subtitle = sprintf("%04d-%02d-%02d",2000+dateparts[3],dateparts[1],dateparts[2])
countypop$covid = covid[ match(countypop$fips, sprintf("%05d",covid$fips)), covid.idx ]
lower.lim = min(min(1+countypop$covid,na.rm=T),100)
upper.lim = max(countypop$covid,na.rm=T)
if ( upper.lim > 100 ) { upper.lim = 100 }
plot_usmap("counties", data=countypop, values=c("covid")) + scale_fill_continuous(low = "pink", high = "red", name = "Total Cases", label = scales::comma,limit=c(lower.lim,upper.lim)) + labs(title = "COVID-19 by county", subtitle=subtitle) + theme(legend.position = "right")
filename = paste("~/Downloads/covid/total-",subtitle,".png",sep="")
ggsave(filename,width=1080/dpi,height=720/dpi,units='in',dpi=dpi)
}

for ( covid.idx in 5:69 ) {
dateparts = as.numeric(unlist(strsplit(sub("X_","",colnames(covid)[covid.idx]),"_")))
subtitle = sprintf("%04d-%02d-%02d",2000+dateparts[3],dateparts[1],dateparts[2])
countypop$covid = covid.percapita[ match(countypop$fips, sprintf("%05d",covid$fips)), covid.idx ]
lower.lim = 0
upper.lim = max(countypop$covid,na.rm=T)/5
plot_usmap("counties", data=countypop, values=c("covid")) + scale_fill_continuous(low = "white", high = "red", na.value="white", name = "Per-capita Cases", label = scales::comma,limit=c(lower.lim,upper.lim)) + labs(title = "COVID-19 by county", subtitle=subtitle) + theme(legend.position = "right")
filename = paste("~/Downloads/covid/percapita-",subtitle,".png",sep="")
ggsave(filename,width=1080/dpi,height=720/dpi,units='in',dpi=dpi)
}
