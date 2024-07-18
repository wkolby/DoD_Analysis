setwd("/Users/wksmith/Rworkspace/DDsense")
prj_dir2="/Users/wksmith/Data/DDSense/DoD_Lands/QGIS_Exports/"
#library(raster)
#library(rgdal)
#library(dplyr)

###Plots##################################################################################
DoD_Box_Plot<-function(C1,C2,C3,C4,C5,clrs,filename) {
  ###BoxPlot
  png(file=filename,width=2500,height=6000,res=600)
  layout(matrix(c(1,2,3),3,1,byrow=TRUE),heights=c(1,1,1),TRUE)
  par(oma=c(8,1,5,8))
  
  ###STATS###
  #plot 1
  p1_means<-c(mean(as.vector(as.matrix(C1[,1])),na.rm=T),mean(as.vector(as.matrix(C2[,1])),na.rm=T),mean(as.vector(as.matrix(C3[,1])),na.rm=T),mean(as.vector(as.matrix(C4[,1])),na.rm=T),mean(as.vector(as.matrix(C5[,1])),na.rm=T))
  p1_stdvs<-c(sd(as.vector(as.matrix(C1[,1])),na.rm=T),sd(as.vector(as.matrix(C2[,1])),na.rm=T),sd(as.vector(as.matrix(C3[,1])),na.rm=T),sd(as.vector(as.matrix(C4[,1])),na.rm=T),sd(as.vector(as.matrix(C5[,1])),na.rm=T))
  #plot 2
  p2_means<-c(mean(as.vector(as.matrix(C1[,2])),na.rm=T),mean(as.vector(as.matrix(C2[,2])),na.rm=T),mean(as.vector(as.matrix(C3[,2])),na.rm=T),mean(as.vector(as.matrix(C4[,2])),na.rm=T),mean(as.vector(as.matrix(C5[,2])),na.rm=T))
  p2_stdvs<-c(sd(as.vector(as.matrix(C1[,2])),na.rm=T),sd(as.vector(as.matrix(C2[,2])),na.rm=T),sd(as.vector(as.matrix(C3[,2])),na.rm=T),sd(as.vector(as.matrix(C4[,2])),na.rm=T),sd(as.vector(as.matrix(C5[,2])),na.rm=T))
  #ard
  p3_means<-c(mean(as.vector(as.matrix(C1[,3])),na.rm=T),mean(as.vector(as.matrix(C2[,3])),na.rm=T),mean(as.vector(as.matrix(C3[,3])),na.rm=T),mean(as.vector(as.matrix(C4[,3])),na.rm=T),mean(as.vector(as.matrix(C5[,3])),na.rm=T))
  p3_stdvs<-c(sd(as.vector(as.matrix(C1[,3])),na.rm=T),sd(as.vector(as.matrix(C2[,3])),na.rm=T),sd(as.vector(as.matrix(C3[,3])),na.rm=T),sd(as.vector(as.matrix(C4[,3])),na.rm=T),sd(as.vector(as.matrix(C5[,3])),na.rm=T))
  #area
  area<-c(sum(as.vector(as.matrix(C1[,4])),na.rm=T),sum(as.vector(as.matrix(C2[,4])),na.rm=T),sum(as.vector(as.matrix(C3[,4])),na.rm=T),sum(as.vector(as.matrix(C4[,4])),na.rm=T),sum(as.vector(as.matrix(C5[,4])),na.rm=T))*100/1000000 #Mha
  
  
  #####Plot 1
  par(mar=c(2,0,1,0))
  boxplot(C1[,1],C2[,1],C3[,1],C4[,1],C5[,1],col=clrs,ylim = c(-50, 1000),varwidth=T,outline=FALSE,axes=FALSE,xaxs="i",yaxs="i")
  points(x=c(1,2,3,4,5),y=p1_means,type="p",cex=2.5,pch=21,lwd=3,bg=c('red','magenta','dodgerblue','darkgoldenrod','darkgreen'),col='black')
  #text(x=c(1,2,3,4,5),y=c(900,900,900,900,900),paste(formatC(p1_means,format='f',digits=1)),adj=0.5,font=2,cex=1,col='black')
  #text(x=c(1,2,3,4,5),y=c(850,850,850,850,850),paste("+/-",formatC(p1_stdvs,format='f',digits=1)),adj=0.5,font=2,cex=1,col='black')
  #text(x=c(1,2,3,4,5),y=c(800,800,800,800,800),paste(formatC(area,format='f',digits=2)," Mha"),adj=0.5,font=2,cex=1,col='black')
  
  #EXTRA
  mtext(4, text=expression(bold(paste('g C m'^{-2},' yr'^{-1}))),line=6,cex=1.5,font=2,col='black')
  mtext(3, text=expression(bold(paste('B. Net Primary Productivity'))),line=0,adj=0.01,cex=1.25,font=2,col='black')
  legend('topright',clrs,c('global','Western US'))
  axis(1, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(4, at = c(-150,0,250,500,750,1000), cex.axis=1.5, font.axis=2, tck=0.015, las=2)
  axis(3, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(2, at = c(-150,0,250,500,750,1000), tck=0.015, labels=FALSE)
  
  #####Plot 2
  par(mar=c(2,0,1,0))
  boxplot(C1[,2],C2[,2],C3[,2],C4[,2],C5[,2],col=clrs,ylim = c(.1, .6),varwidth=T,outline=FALSE,axes=FALSE,xaxs="i",yaxs="i")
  points(x=c(1,2,3,4,5),y=p2_means,type="p",cex=2.5,pch=21,lwd=3,bg=c('red','magenta','dodgerblue','darkgoldenrod','darkgreen'),col='black')
  #text(x=c(1,2,3,4,5),y=c(.95,.95,.95,.95,.95),paste(formatC(p2_means,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  #text(x=c(1,2,3,4,5),y=c(.9,.9,.9,.9,.9),paste("+/-",formatC(p2_stdvs,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  #text(x=c(1,2,3,4,5),y=c(.85,.85,.85,.85,.85),paste(formatC(area,format='f',digits=2)," Mha"),adj=0.5,font=2,cex=1,col='black')
  
  #EXTRA
  mtext(4, text=expression(bold(paste('Normalized'))),line=6,cex=1.5,font=2,col='black')
  mtext(3, text=expression(bold(paste('D. Species Richness'))),line=0,adj=0.01,cex=1.25,font=2,col='black')
  axis(1, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(4, at = c(0,.2,.4,.6,.8,1), cex.axis=1.5, font.axis=2, tck=0.015, las=2)
  axis(3, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(2, at = c(0,.2,.4,.6,.8,1), tck=0.015, labels=FALSE)
  
  ######Plot 3:
  par(mar=c(2,0,1,0))
  boxplot(C1[,3],C2[,3],C3[,3],C4[,3],C5[,3],col=clrs,ylim = c(0, 1),varwidth=T,outline=FALSE,axes=FALSE,xaxs="i",yaxs="i")
  points(x=c(1,2,3,4,5),y=p3_means,type="p",cex=2.5,pch=21,lwd=3,bg=c('red','magenta','dodgerblue','darkgoldenrod','darkgreen'),col='black')
  text(x=c(1,2,3,4,5),y=c(.9,.9,.9,.9,.9),paste(formatC(p3_means,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.85,.85,.85,.85,.85),paste("+/-",formatC(p3_stdvs,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.8,.8,.8,.8,.8),paste(formatC(area,format='f',digits=2)," Mha"),adj=0.5,font=2,cex=1,col='black')
  
  #EXTRA
  mtext(1, at=c(1,2,3,4,5),text=c(expression(bold(paste("DOD"))),expression(bold(paste("Tribal"))),expression(bold(paste("NPS"))),expression(bold(paste("BLM"))),expression(bold(paste("USFS")))),
        cex=1.5,font=2,tck=0.01,las=2,line=1)
  mtext(4, text=expression(bold(paste('mm mm'^{-1}))),line=6,cex=1.5,font=2,col='black')
  mtext(3, text=expression(bold(paste('Aridity Index'))),line=0,adj=0.01,cex=1.25,font=2,col='black')
  axis(1, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(4, at = c(0,.2,.4,.6,.8,1), cex.axis=1.5, font.axis=2, tck=0.015, las=2)
  axis(3, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(2, at = c(0,.2,.4,.6,.8,1), tck=0.015, labels=FALSE)
  
  dev.off()
}

DoD_Norm_Box_Plot<-function(C1,C2,C3,C4,C5,clrs,filename) {
  ###BoxPlot
  png(file=filename,width=3000,height=5500,res=600)
  layout(matrix(c(1,2,3),3,1,byrow=TRUE),heights=c(1,1,1),TRUE)
  par(oma=c(8,7,5,1))
  
  ###STATS###
  #plot 1
  p1_means<-c(mean(as.vector(as.matrix(C1[,1])),na.rm=T),mean(as.vector(as.matrix(C2[,1])),na.rm=T),mean(as.vector(as.matrix(C3[,1])),na.rm=T),mean(as.vector(as.matrix(C4[,1])),na.rm=T),mean(as.vector(as.matrix(C5[,1])),na.rm=T))
  p1_stdvs<-c(sd(as.vector(as.matrix(C1[,1])),na.rm=T),sd(as.vector(as.matrix(C2[,1])),na.rm=T),sd(as.vector(as.matrix(C3[,1])),na.rm=T),sd(as.vector(as.matrix(C4[,1])),na.rm=T),sd(as.vector(as.matrix(C5[,1])),na.rm=T))
  #plot 2
  p2_means<-c(mean(as.vector(as.matrix(C1[,2])),na.rm=T),mean(as.vector(as.matrix(C2[,2])),na.rm=T),mean(as.vector(as.matrix(C3[,2])),na.rm=T),mean(as.vector(as.matrix(C4[,2])),na.rm=T),mean(as.vector(as.matrix(C5[,2])),na.rm=T))
  p2_stdvs<-c(sd(as.vector(as.matrix(C1[,2])),na.rm=T),sd(as.vector(as.matrix(C2[,2])),na.rm=T),sd(as.vector(as.matrix(C3[,2])),na.rm=T),sd(as.vector(as.matrix(C4[,2])),na.rm=T),sd(as.vector(as.matrix(C5[,2])),na.rm=T))
  #ard
  p3_means<-c(mean(as.vector(as.matrix(C1[,3])),na.rm=T),mean(as.vector(as.matrix(C2[,3])),na.rm=T),mean(as.vector(as.matrix(C3[,3])),na.rm=T),mean(as.vector(as.matrix(C4[,3])),na.rm=T),mean(as.vector(as.matrix(C5[,3])),na.rm=T))
  p3_stdvs<-c(sd(as.vector(as.matrix(C1[,3])),na.rm=T),sd(as.vector(as.matrix(C2[,3])),na.rm=T),sd(as.vector(as.matrix(C3[,3])),na.rm=T),sd(as.vector(as.matrix(C4[,3])),na.rm=T),sd(as.vector(as.matrix(C5[,3])),na.rm=T))
  #area
  area<-c(sum(as.vector(as.matrix(C1[,4])),na.rm=T),sum(as.vector(as.matrix(C2[,4])),na.rm=T),sum(as.vector(as.matrix(C3[,4])),na.rm=T),sum(as.vector(as.matrix(C4[,4])),na.rm=T),sum(as.vector(as.matrix(C5[,4])),na.rm=T))*100/1000000 #Mha
  
  #####Plot 1
  par(mar=c(2,0,1,0))
  boxplot(C1[,1],C2[,1],C3[,1],C4[,1],C5[,1],col=clrs,ylim = c(0,1),varwidth=T,outline=FALSE,axes=FALSE,xaxs="i",yaxs="i")
  points(x=c(1,2,3,4,5),y=p1_means,type="p",cex=2.5,pch=21,lwd=3,bg=c('red','magenta','dodgerblue','darkgoldenrod','darkgreen'),col='black')
  text(x=c(1,2,3,4,5),y=c(.9,.9,.9,.9,.9),paste(formatC(p1_means,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.8,.8,.8,.8,.8),paste("+/-",formatC(p1_stdvs,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.7,.7,.7,.7,.7),paste(formatC(area,format='f',digits=2)," Mha"),adj=0.5,font=2,cex=1,col='black')
  
  #EXTRA
  mtext(2, text=expression(bold(paste('Normalized'))),line=4,cex=1.5,font=2,col='black')
  mtext(3, text=expression(bold(paste('a. Reptile Richness'))),line=0,adj=0.01,cex=1.25,font=2,col='black')
  axis(1, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(2, at = c(0,.2,.4,.6,.8,1), cex.axis=1.5, font.axis=2, tck=0.015, las=2)
  axis(3, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(4, at = c(0,.2,.4,.6,.8,1), tck=0.015, labels=FALSE)
  
  #####Plot 2
  par(mar=c(2,0,1,0))
  boxplot(C1[,2],C2[,2],C3[,2],C4[,2],C5[,2],col=clrs,ylim = c(0, 1),varwidth=T,outline=FALSE,axes=FALSE,xaxs="i",yaxs="i")
  points(x=c(1,2,3,4,5),y=p2_means,type="p",cex=2.5,pch=21,lwd=3,bg=c('red','magenta','dodgerblue','darkgoldenrod','darkgreen'),col='black')
  text(x=c(1,2,3,4,5),y=c(.9,.9,.9,.9,.9),paste(formatC(p2_means,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.8,.8,.8,.8,.8),paste("+/-",formatC(p2_stdvs,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.7,.7,.7,.7,.7),paste(formatC(area,format='f',digits=2)," Mha"),adj=0.5,font=2,cex=1,col='black')
  
  #EXTRA
  mtext(2, text=expression(bold(paste('Normalized'))),line=4,cex=1.5,font=2,col='black')
  mtext(3, text=expression(bold(paste('b. Mammal Richness'))),line=0,adj=0.01,cex=1.25,font=2,col='black')
  axis(1, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(2, at = c(0,.2,.4,.6,.8,1), cex.axis=1.5, font.axis=2, tck=0.015, las=2)
  axis(3, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(4, at = c(0,.2,.4,.6,.8,1), tck=0.015, labels=FALSE)
  
  ######Plot 3:
  par(mar=c(2,0,1,0))
  boxplot(C1[,3],C2[,3],C3[,3],C4[,3],C5[,3],col=clrs,ylim = c(0, 1),varwidth=T,outline=FALSE,axes=FALSE,xaxs="i",yaxs="i")
  points(x=c(1,2,3,4,5),y=p3_means,type="p",cex=2.5,pch=21,lwd=3,bg=c('red','magenta','dodgerblue','darkgoldenrod','darkgreen'),col='black')
  text(x=c(1,2,3,4,5),y=c(.9,.9,.9,.9,.9),paste(formatC(p3_means,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.8,.8,.8,.8,.8),paste("+/-",formatC(p3_stdvs,format='f',digits=2)),adj=0.5,font=2,cex=1,col='black')
  text(x=c(1,2,3,4,5),y=c(.7,.7,.7,.7,.7),paste(formatC(area,format='f',digits=2)," Mha"),adj=0.5,font=2,cex=1,col='black')
  
  #EXTRA
  mtext(1, at=c(1,2,3,4,5),text=c(expression(bold(paste("DOD"))),expression(bold(paste("Tribal"))),expression(bold(paste("NPS"))),expression(bold(paste("BLM"))),expression(bold(paste("USFS")))),
        cex=1.5,font=2,tck=0.01,las=2,line=1)
  mtext(2, text=expression(bold(paste('Normalized'))),line=4,cex=1.5,font=2,col='black')
  mtext(3, text=expression(bold(paste('c. Bird Richness'))),line=0,adj=0.01,cex=1.25,font=2,col='black')
  axis(1, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(2, at = c(0,.2,.4,.6,.8,1), cex.axis=1.5, font.axis=2, tck=0.015, las=2)
  axis(3, at = c(0,1,2,3,4,5,6), tck=0.015, labels=FALSE)
  axis(4, at = c(0,.2,.4,.6,.8,1), tck=0.015, labels=FALSE)
  
  dev.off()
}


#################################################################################################################
##############################################MAIN#######################################################
  
#Thresholds
class=c('Dryland','Arid','Semiarid','Subhumid')
min_threshold=c(0.00,0.00,0.20,0.50)
max_threshold=c(0.50,0.20,0.50,0.65)

for(i in 1:length(class)){
  ###ARIDITY
  ard_min=min_threshold[i]
  ard_max=max_threshold[i]
  ard_dod <- raster(paste(prj_dir2,"ARD_DOD_4km.tif",sep=''))
  ard_dod_ard=ard_dod[ard_dod>ard_min & ard_dod<=ard_max]
  ard_trb <- raster(paste(prj_dir2,"ARD_TRB_4km.tif",sep=''))
  ard_trb_ard=ard_trb[ard_trb>ard_min & ard_trb<=ard_max]
  ard_nps <- raster(paste(prj_dir2,"ARD_NPS_4km.tif",sep=''))
  ard_nps_ard=ard_nps[ard_nps>ard_min & ard_nps<=ard_max]
  ard_blm <- raster(paste(prj_dir2,"ARD_BLM_4km.tif",sep=''))
  ard_blm_ard=ard_blm[ard_blm>ard_min & ard_blm<=ard_max]
  ard_ufs <- raster(paste(prj_dir2,"ARD_UFS_4km.tif",sep=''))
  ard_ufs_ard=ard_ufs[ard_ufs>ard_min & ard_ufs<=ard_max]
  
  #AREA
  area_dod <- raster(paste(prj_dir2,"Area_DOD_4km.tif",sep=''))
  area_dod_ard=area_dod[ard_dod>ard_min & ard_dod<=ard_max]
  area_trb <- raster(paste(prj_dir2,"Area_TRB_4km.tif",sep=''))
  area_trb_ard=area_trb[ard_trb>ard_min & ard_trb<=ard_max]
  area_nps <- raster(paste(prj_dir2,"Area_NPS_4km.tif",sep=''))
  area_nps_ard=area_nps[ard_nps>ard_min & ard_nps<=ard_max]
  area_blm <- raster(paste(prj_dir2,"Area_BLM_4km.tif",sep=''))
  area_blm_ard=area_blm[ard_blm>ard_min & ard_blm<=ard_max]
  area_ufs <- raster(paste(prj_dir2,"Area_UFS_4km.tif",sep=''))
  area_ufs_ard=area_ufs[ard_ufs>ard_min & ard_ufs<=ard_max]
  
  ###NPP
  npp_dod <- raster(paste(prj_dir2,"NPP_DOD_4km.tif",sep=''))*0.1
  npp_dod_ard=npp_dod[ard_dod>ard_min & ard_dod<=ard_max]
  npp_trb <- raster(paste(prj_dir2,"NPP_TRB_4km.tif",sep=''))*0.1
  npp_trb_ard=npp_trb[ard_trb>ard_min & ard_trb<=ard_max]
  npp_nps <- raster(paste(prj_dir2,"NPP_NPS_4km.tif",sep=''))*0.1
  npp_nps_ard=npp_nps[ard_nps>ard_min & ard_nps<=ard_max]
  npp_blm <- raster(paste(prj_dir2,"NPP_BLM_4km.tif",sep=''))*0.1
  npp_blm_ard=npp_blm[ard_blm>ard_min & ard_blm<=ard_max]
  npp_ufs <- raster(paste(prj_dir2,"NPP_UFS_4km.tif",sep=''))*0.1
  npp_ufs_ard=npp_ufs[ard_ufs>ard_min & ard_ufs<=ard_max]
  
  ###Reptile
  rept_min=1
  rept_max=65
  tmp <- raster(paste(prj_dir2,"Reptile_DOD_4km.tif",sep=''))
  rept_dod<-(tmp-rept_min)/(rept_max)
  rept_dod_ard=rept_dod[ard_dod>ard_min & ard_dod<=ard_max]
  tmp <- raster(paste(prj_dir2,"Reptile_TRB_4km.tif",sep=''))
  rept_trb<-(tmp-rept_min)/(rept_max)
  rept_trb_ard=rept_trb[ard_trb>ard_min & ard_trb<=ard_max]
  tmp <- raster(paste(prj_dir2,"Reptile_NPS_4km.tif",sep=''))
  rept_nps<-(tmp-rept_min)/(rept_max)
  rept_nps_ard=rept_nps[ard_nps>ard_min & ard_nps<=ard_max]
  tmp <- raster(paste(prj_dir2,"Reptile_BLM_4km.tif",sep=''))
  rept_blm<-(tmp-rept_min)/(rept_max)
  rept_blm_ard=rept_blm[ard_blm>ard_min & ard_blm<=ard_max]
  tmp <- raster(paste(prj_dir2,"Reptile_UFS_4km.tif",sep=''))
  rept_ufs<-(tmp-rept_min)/(rept_max)
  rept_ufs_ard=rept_ufs[ard_ufs>ard_min & ard_ufs<=ard_max]
  
  ###Mammal
  mamm_min=25
  mamm_max=85
  tmp <- raster(paste(prj_dir2,"Mammal_DOD_4km.tif",sep=''))
  mamm_dod<-(tmp-mamm_min)/(mamm_max)
  mamm_dod_ard=mamm_dod[ard_dod>ard_min & ard_dod<=ard_max]
  tmp <- raster(paste(prj_dir2,"Mammal_TRB_4km.tif",sep=''))
  mamm_trb<-(tmp-mamm_min)/(mamm_max)
  mamm_trb_ard=mamm_trb[ard_trb>ard_min & ard_trb<=ard_max]
  tmp <- raster(paste(prj_dir2,"Mammal_NPS_4km.tif",sep=''))
  mamm_nps<-(tmp-mamm_min)/(mamm_max)
  mamm_nps_ard=mamm_nps[ard_nps>ard_min & ard_nps<=ard_max]
  tmp <- raster(paste(prj_dir2,"Mammal_BLM_4km.tif",sep=''))
  mamm_blm<-(tmp-mamm_min)/(mamm_max)
  mamm_blm_ard=mamm_blm[ard_blm>ard_min & ard_blm<=ard_max]
  tmp <- raster(paste(prj_dir2,"Mammal_UFS_4km.tif",sep=''))
  mamm_ufs<-(tmp-mamm_min)/(mamm_max)
  mamm_ufs_ard=mamm_ufs[ard_ufs>ard_min & ard_ufs<=ard_max]
  
  ###Bird
  bird_min=100
  bird_max=200
  tmp <- raster(paste(prj_dir2,"Bird_DOD_4km.tif",sep=''))
  bird_dod<-(tmp-bird_min)/(bird_max)
  bird_dod_ard=bird_dod[ard_dod>ard_min & ard_dod<=ard_max]
  tmp <- raster(paste(prj_dir2,"Bird_TRB_4km.tif",sep=''))
  bird_trb<-(tmp-bird_min)/(bird_max)
  bird_trb_ard=bird_trb[ard_trb>ard_min & ard_trb<=ard_max]
  tmp <- raster(paste(prj_dir2,"Bird_NPS_4km.tif",sep=''))
  bird_nps<-(tmp-bird_min)/(bird_max)
  bird_nps_ard=bird_nps[ard_nps>ard_min & ard_nps<=ard_max]
  tmp <- raster(paste(prj_dir2,"Bird_BLM_4km.tif",sep=''))
  bird_blm<-(tmp-bird_min)/(bird_max)
  bird_blm_ard=bird_blm[ard_blm>ard_min & ard_blm<=ard_max]
  tmp <- raster(paste(prj_dir2,"Bird_UFS_4km.tif",sep=''))
  bird_ufs<-(tmp-bird_min)/(bird_max)
  bird_ufs_ard=bird_ufs[ard_ufs>ard_min & ard_ufs<=ard_max]
  
  ###Mean Diversity
  divr_dod_ard=(bird_dod_ard+mamm_dod_ard+rept_dod_ard)/3
  divr_trb_ard=(bird_trb_ard+bird_trb_ard+rept_trb_ard)/3
  divr_nps_ard=(bird_nps_ard+bird_nps_ard+rept_nps_ard)/3
  divr_ufs_ard=(bird_ufs_ard+bird_ufs_ard+rept_ufs_ard)/3
  divr_blm_ard=(bird_blm_ard+bird_blm_ard+rept_blm_ard)/3
  
  #####PLOTS############
  filename=paste("Class_Importance_Multi_",class[i],"_Box.png")
  clrs=c(rgb(205,0,0,200,max=255),rgb(255,000,255,200,max=255),rgb(030,144,255,200,max=255),rgb(184,134,011,200,max=255),rgb(000,100,000,200,max=255))
  DOD<-cbind(as.vector(as.matrix(npp_dod_ard)), as.vector(as.matrix(divr_dod_ard)), as.vector(as.matrix(ard_dod_ard)),as.vector(as.matrix(area_dod_ard)))
  TRB<-cbind(as.vector(as.matrix(npp_trb_ard)), as.vector(as.matrix(divr_trb_ard)), as.vector(as.matrix(ard_trb_ard)),as.vector(as.matrix(area_trb_ard)))
  NPS<-cbind(as.vector(as.matrix(npp_nps_ard)), as.vector(as.matrix(divr_nps_ard)), as.vector(as.matrix(ard_nps_ard)),as.vector(as.matrix(area_nps_ard)))
  BLM<-cbind(as.vector(as.matrix(npp_blm_ard)), as.vector(as.matrix(divr_blm_ard)), as.vector(as.matrix(ard_blm_ard)),as.vector(as.matrix(area_blm_ard)))
  UFS<-cbind(as.vector(as.matrix(npp_ufs_ard)), as.vector(as.matrix(divr_ufs_ard)), as.vector(as.matrix(ard_ufs_ard)),as.vector(as.matrix(area_ufs_ard)))
  DoD_Box_Plot(DOD,TRB,NPS,BLM,UFS,clrs,filename)
  filename=paste("Class_Importance_Divr_",class[i],"_Box.png")
  clrs=c(rgb(205,0,0,200,max=255),rgb(255,0,255,200,max=255),rgb(030,144,255,200,max=255),rgb(184,134,011,200,max=255),rgb(000,100,000,200,max=255))
  DOD<-cbind(as.vector(as.matrix(rept_dod_ard)), as.vector(as.matrix(mamm_dod_ard)), as.vector(as.matrix(bird_dod_ard)),as.vector(as.matrix(area_dod_ard)))
  TRB<-cbind(as.vector(as.matrix(rept_trb_ard)), as.vector(as.matrix(mamm_trb_ard)), as.vector(as.matrix(bird_trb_ard)),as.vector(as.matrix(area_dod_ard)))
  NPS<-cbind(as.vector(as.matrix(rept_nps_ard)), as.vector(as.matrix(mamm_nps_ard)), as.vector(as.matrix(bird_nps_ard)),as.vector(as.matrix(area_dod_ard)))
  BLM<-cbind(as.vector(as.matrix(rept_blm_ard)), as.vector(as.matrix(mamm_blm_ard)), as.vector(as.matrix(bird_blm_ard)),as.vector(as.matrix(area_dod_ard)))
  UFS<-cbind(as.vector(as.matrix(rept_ufs_ard)), as.vector(as.matrix(mamm_ufs_ard)), as.vector(as.matrix(bird_ufs_ard)),as.vector(as.matrix(area_dod_ard)))
  DoD_Norm_Box_Plot(DOD,TRB,NPS,BLM,UFS,clrs,filename)
}