remove(list=ls())

require(ggplot2)
require(dplyr)

dat=read.csv(url("https://github.com/TheUpshot/nyt_weddings/raw/master/nyt_wedding_announcements.csv"), stringsAsFactors=FALSE)

dat2=data.frame(name_status=rep(NA,length(unique(dat$name_status))),age_diff=rep(NA,length(unique(dat$name_status))),n=rep(NA,length(unique(dat$name_status))), stringsAsFactors = FALSE)
index=1

for(i in unique(dat$name_status)){

  dat2$name_status[index]=i

  tmp=round(sd(abs(dat$bride_age[dat$name_status==i]-dat$groom_age[dat$name_status==i]), na.rm=T))

  dat2$age_diff[index]=tmp

  dat2$n[index]=length(dat$name_status[dat$name_status==i])

  message(i)

  index=index+1

}

dat2=data.frame()
for(i in unique(dat$name_status)){

  .dat=data.frame(name_status=i, stringsAsFactors = FALSE)

  tmp=round(sd(abs(dat$bride_age[dat$name_status==i]-dat$groom_age[dat$name_status==i]), na.rm=T))

  .dat$age_diff=tmp

  .dat$n=length(dat$name_status[dat$name_status==i])

  dat2=rbind(dat2,.dat)

  rm(.dat)

  message(i)

}

dat2=list()
for(i in unique(dat$name_status)){

  dat2[[i]]=data.frame(name_status=i, stringsAsFactors = FALSE)

  tmp=round(sd(abs(dat$bride_age[dat$name_status==i]-dat$groom_age[dat$name_status==i]), na.rm=T))

  dat2[[i]]$age_diff=tmp

  dat2[[i]]$n=length(dat$name_status[dat$name_status==i])

  message(i)

}

dat2=data.frame(bind_rows(dat2))

ggplot(dat2,aes(name_status, age_diff, size=n)) + geom_point()
