'''
Created on 10/05/2021
@author: wksmith
'''

#plot
import gdal
import numpy as np
import osgeo.osr as osr
import osgeo.gdalconst as gdalconst
from matplotlib.patches import Polygon
from matplotlib.patches import Rectangle
from matplotlib import rc
from matplotlib.colors import Normalize
from matplotlib import cm
import matplotlib.pyplot as plt
from matplotlib.colors import from_levels_and_colors
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from cartopy.io.shapereader import Reader
PROJECTION_GEO_WGS84 = 4326 #EPSG Code

def figure_westernUS_vector(fid,scale,clrs,levels,extnd,labels,filename):
    font = {'weight' : 'bold'}
    rc('font', **font)
    rc('ytick', labelsize=12)
       
    #Read Data
    band=fid.GetRasterBand(1)
    data=band.ReadAsArray()
    geot=fid.GetGeoTransform()
    print(geot)
    data=np.ma.masked_where(data>99999,data)
    data=np.ma.masked_where(data<0,data)
    data=data*scale
    #Get rows, cols, res
    rows=data.shape[0]
    cols=data.shape[1]
    xRes=geot[1]
    yRes=-geot[5]
    #Get extent
    minx = geot[0]
    miny = geot[3] + cols*geot[4] + rows*geot[5] 
    maxx = geot[0] + cols*geot[1] + rows*geot[2]
    maxy = geot[3] 
    #Get lat, lon, area
    radians=0.0174532925
    radius=6378.137 #km
    lat=np.linspace(maxy, miny, rows)
    lon=np.linspace(minx, maxx, cols)
    xGrid, yGrid = np.meshgrid(lon, lat)
    area=(np.sin(yGrid*radians+0.5*yRes*radians)-np.sin(yGrid*radians-0.5*yRes*radians))*(xRes*radians)*radius*radius #km2
    WriteToTif(area, geot, data_dir+"Area_WUS_4km.tiff", gdalconst.GDT_Float32) #write out area raster
    ###PLOT###
    #Setup Basemap with projection
    ax = plt.axes(projection=ccrs.PlateCarree())
    ax.set_extent([-126,-101,30,51],crs=ccrs.PlateCarree())
    #Set colormap
    cmap, norm = from_levels_and_colors(levels, clrs, extend=extnd)
    #Plot colormesh
    plt.pcolormesh(xGrid,yGrid,data,transform=ccrs.PlateCarree(),cmap=cmap,norm=norm)
    
    #Other
    ax.axis('off') #turn off border
    OTHshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/DifferencedDissolved_PADUS21_WUS84.shp'
    OTHfeature=cfeature.ShapelyFeature(Reader(OTHshp).geometries(),ccrs.PlateCarree(),edgecolor='none',facecolor='lightgrey',linewidth=.5)
    ax.add_feature(OTHfeature)
    BLMshp='/Users/wksmith/Data/Shapefiles/fedland/fedlanp010g.shp_nt00966/Dissolved_BLM_WUS84.shp'
    BLMfeature=cfeature.ShapelyFeature(Reader(BLMshp).geometries(),ccrs.PlateCarree(),edgecolor='none',facecolor='darkgoldenrod',linewidth=0.1)
    ax.add_feature(BLMfeature)
    UFSshp='/Users/wksmith/Data/Shapefiles/fedland/fedlanp010g.shp_nt00966/Dissolved_FS_WUS84.shp'
    UFSfeature=cfeature.ShapelyFeature(Reader(UFSshp).geometries(),ccrs.PlateCarree(),edgecolor='none',facecolor='darkgreen',linewidth=0.1)
    ax.add_feature(UFSfeature)
    NPSshp='/Users/wksmith/Data/Shapefiles/fedland/fedlanp010g.shp_nt00966/Dissolved_NPS_WUS84.shp'
    NPSfeature=cfeature.ShapelyFeature(Reader(NPSshp).geometries(),ccrs.PlateCarree(),edgecolor='black',facecolor='dodgerblue',linewidth=.25)
    ax.add_feature(NPSfeature)
    DODshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/DODdissolved_PADUS21_WUS84.shp'
    DODfeature=cfeature.ShapelyFeature(Reader(DODshp).geometries(),ccrs.PlateCarree(),edgecolor='black',facecolor='red',linewidth=.25)
    ax.add_feature(DODfeature)
    TRBshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/TRIBdissolved_PADUS21_WUS84.shp'
    TRBfeature=cfeature.ShapelyFeature(Reader(TRBshp).geometries(),ccrs.PlateCarree(),edgecolor='black',facecolor='magenta',linewidth=.25)
    ax.add_feature(TRBfeature)
    WUSshp='/Users/wksmith/Data/Shapefiles/WesterUS_States/WesternUS.shp'
    WUSfeature=cfeature.ShapelyFeature(Reader(WUSshp).geometries(),ccrs.PlateCarree(),facecolor='none',edgecolor='black',linewidth=0.5)
    ax.add_feature(WUSfeature)
    
    ###Legend###
    classes=['DOD','TRB','NPS','BLM','FS']
    clrs2=['red','Magenta','dodgerblue','darkgoldenrod','darkgreen']
    x=(-124.5,-124.5,-124.5,-124.5,-124.5)
    y=(34.5,33.5,32.5,31.5,30.5)
    plt.scatter(x,y,s=50,marker='s',c=clrs2,cmap=cmap,norm=norm,alpha=.8,edgecolors='k',zorder=3)
    for i in np.arange(len(classes)):
        ax.text(x[i]+0.4,y[i],classes[i],weight='bold',verticalalignment='center',horizontalalignment='left',size=8,zorder=4)


    #Text lebel
    plt.text(-125,50,labels[0], fontsize=10, fontweight ='bold')

    ###Save Image###
    plt.savefig(filename,dpi=600)
    plt.show()
    plt.close()


def figure_westernUS(fid,scale,clrs,levels,extnd,labels,filename):
    font = {'weight' : 'bold'}
    rc('font', **font)
    rc('ytick', labelsize=12)
       
    #Read Data
    band=fid.GetRasterBand(1)
    data=band.ReadAsArray()
    geot=fid.GetGeoTransform()
    data=np.ma.masked_where(data>99999,data)
    data=np.ma.masked_where(data<0,data)
    data=data*scale
    #Get lat,lon
    rows=data.shape[0]
    cols=data.shape[1]
    minx = geot[0]
    miny = geot[3] + cols*geot[4] + rows*geot[5] 
    maxx = geot[0] + cols*geot[1] + rows*geot[2]
    maxy = geot[3] 
    lat=np.linspace(maxy, miny, rows)
    lon=np.linspace(minx, maxx, cols)
    #Get xGrid, yGrid
    xGrid, yGrid = np.meshgrid(lon, lat)
    
    ###PLOT###
    #Setup Basemap with projection
    ax = plt.axes(projection=ccrs.PlateCarree())
    #ax.set_extent([-126,-101,30,51],crs=ccrs.PlateCarree())
    ax.set_extent([-127.5,-101,30,51],crs=ccrs.PlateCarree())
    #Set colormap
    cmap, norm = from_levels_and_colors(levels, clrs, extend=extnd)
    #Plot colormesh
    plt.pcolormesh(xGrid,yGrid,data,transform=ccrs.PlateCarree(),cmap=cmap,norm=norm)
    
    #Other
    ax.axis('off') #turn off border
    OTHshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/DifferencedDissolved_PADUS21_WUS84.shp'
    OTHfeature=cfeature.ShapelyFeature(Reader(OTHshp).geometries(),ccrs.PlateCarree(),edgecolor='none',facecolor='#f0f0f0',linewidth=.25)
    ax.add_feature(OTHfeature)
    WUSshp='/Users/wksmith/Data/Shapefiles/WesterUS_States/WesternUS.shp'
    WUSfeature=cfeature.ShapelyFeature(Reader(WUSshp).geometries(),ccrs.PlateCarree(),facecolor='none',edgecolor='darkgrey',linewidth=0.25)
    ax.add_feature(WUSfeature)
    #BLMshp='/Users/wksmith/Data/Shapefiles/fedland/fedlanp010g.shp_nt00966/Dissolved_BLM_WUS84.shp'
    #BLMfeature=cfeature.ShapelyFeature(Reader(BLMshp).geometries(),ccrs.PlateCarree(),edgecolor='darkgoldenrod',facecolor='none',linewidth=0.1)
    #ax.add_feature(BLMfeature)
    #UFSshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/USFS_PADUS21_WUS84.shp'
    #UFSfeature=cfeature.ShapelyFeature(Reader(UFSshp).geometries(),ccrs.PlateCarree(),edgecolor='darkgreen',facecolor='none',linewidth=0.1)
    #ax.add_feature(UFSfeature)
    NPSshp='/Users/wksmith/Data/Shapefiles/fedland/fedlanp010g.shp_nt00966/Dissolved_NPS_WUS84.shp'
    NPSfeature=cfeature.ShapelyFeature(Reader(NPSshp).geometries(),ccrs.PlateCarree(),edgecolor='dodgerblue',facecolor='none',linewidth=.5)
    ax.add_feature(NPSfeature)
    DODshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/DODdissolved_PADUS21_WUS84.shp'
    DODfeature=cfeature.ShapelyFeature(Reader(DODshp).geometries(),ccrs.PlateCarree(),edgecolor='red',facecolor='none',linewidth=.5)
    ax.add_feature(DODfeature)
    TRBshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/TRIBdissolved_PADUS21_WUS84.shp'
    TRBfeature=cfeature.ShapelyFeature(Reader(TRBshp).geometries(),ccrs.PlateCarree(),edgecolor='magenta',facecolor='none',linewidth=.5)
    ax.add_feature(TRBfeature)
    
    #Text lebel
    plt.text(-125,50,labels[0], fontsize=10, fontweight ='bold')
    
    ##Colorbar
    #cbar = plt.colorbar(ax=ax, shrink=.75, pad=0.0)
    #cbar.ax.tick_params(labelsize=6)
    #cbar.set_label(labels[1], fontsize=10, fontweight ='bold', labelpad=15, rotation=270)
    
    ###Legend 2###
    classes=['Hyper-Arid','Arid','Semi-Arid','Dry Sub-humid','Mesic']
    clrs2=['#fb9a99','#fdbf6f','#b2df8a','#a6cee3','#cab2d6']
    x=(-127,-127,-127,-127,-127)
    y=(34.5,33.5,32.5,31.5,30.5)
    plt.scatter(x,y,s=50,marker='s',c=clrs2,cmap=cmap,norm=norm,alpha=.8,edgecolors='k',zorder=3)
    for i in np.arange(len(classes)):
        ax.text(x[i]+0.4,y[i],classes[i],weight='bold',verticalalignment='center',horizontalalignment='left',size=8,zorder=4)
    
    
    ###Save Image###
    plt.savefig(filename,dpi=600)
    plt.show()
    plt.close()
    
def figure_westernUS_V2(fid1,fid2,fid3,fid4,scale,clrs,levels,extnd,labels,filename):
    font = {'weight' : 'bold'}
    rc('font', **font)
    rc('ytick', labelsize=12)
       
    #Read Data
    band1=fid1.GetRasterBand(1)
    tmp=band1.ReadAsArray()
    data1=(tmp-1)/65
    band2=fid2.GetRasterBand(1)
    tmp=band2.ReadAsArray()
    data2=(tmp-25)/85
    band3=fid3.GetRasterBand(1)
    tmp=band3.ReadAsArray()
    data3=(tmp-100)/200
    data=(data1+data2+data3)/3
    geot=fid.GetGeoTransform()
    data=np.ma.masked_where(data>1,data)
    data=np.ma.masked_where(data<0,data)
    data=data*scale
    #Get lat,lon
    rows=data.shape[0]
    cols=data.shape[1]
    minx = geot[0]
    miny = geot[3] + cols*geot[4] + rows*geot[5] 
    maxx = geot[0] + cols*geot[1] + rows*geot[2]
    maxy = geot[3] 
    lat=np.linspace(maxy, miny, rows)
    lon=np.linspace(minx, maxx, cols)
    #Get xGrid, yGrid
    xGrid, yGrid = np.meshgrid(lon, lat)
    
    ###PLOT###
    #Setup Basemap with projection
    ax = plt.axes(projection=ccrs.PlateCarree())
    ax.set_extent([-126,-101,30,51],crs=ccrs.PlateCarree())
    #ax.set_extent([-127.5,-101,30,51],crs=ccrs.PlateCarree())
    #Set colormap
    cmap, norm = from_levels_and_colors(levels, clrs, extend=extnd)
    #Plot colormesh
    plt.pcolormesh(xGrid,yGrid,data,transform=ccrs.PlateCarree(),cmap=cmap,norm=norm)
    
    #Other
    ax.axis('off') #turn off border
    OTHshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/DifferencedDissolved_PADUS21_WUS84.shp'
    OTHfeature=cfeature.ShapelyFeature(Reader(OTHshp).geometries(),ccrs.PlateCarree(),edgecolor='none',facecolor='#f0f0f0',linewidth=.25)
    ax.add_feature(OTHfeature)
    WUSshp='/Users/wksmith/Data/Shapefiles/WesterUS_States/WesternUS.shp'
    WUSfeature=cfeature.ShapelyFeature(Reader(WUSshp).geometries(),ccrs.PlateCarree(),facecolor='none',edgecolor='darkgrey',linewidth=0.25)
    ax.add_feature(WUSfeature)
    #BLMshp='/Users/wksmith/Data/Shapefiles/fedland/fedlanp010g.shp_nt00966/Dissolved_BLM_WUS84.shp'
    #BLMfeature=cfeature.ShapelyFeature(Reader(BLMshp).geometries(),ccrs.PlateCarree(),edgecolor='darkgoldenrod',facecolor='none',linewidth=0.1)
    #ax.add_feature(BLMfeature)
    #UFSshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/USFS_PADUS21_WUS84.shp'
    #UFSfeature=cfeature.ShapelyFeature(Reader(UFSshp).geometries(),ccrs.PlateCarree(),edgecolor='darkgreen',facecolor='none',linewidth=0.1)
    #ax.add_feature(UFSfeature)
    NPSshp='/Users/wksmith/Data/Shapefiles/fedland/fedlanp010g.shp_nt00966/Dissolved_NPS_WUS84.shp'
    NPSfeature=cfeature.ShapelyFeature(Reader(NPSshp).geometries(),ccrs.PlateCarree(),edgecolor='dodgerblue',facecolor='none',linewidth=.5)
    ax.add_feature(NPSfeature)
    DODshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/DODdissolved_PADUS21_WUS84.shp'
    DODfeature=cfeature.ShapelyFeature(Reader(DODshp).geometries(),ccrs.PlateCarree(),edgecolor='red',facecolor='none',linewidth=.5)
    ax.add_feature(DODfeature)
    TRBshp='/Users/wksmith/Data/Shapefiles/PADUS_Merged/TRIBdissolved_PADUS21_WUS84.shp'
    TRBfeature=cfeature.ShapelyFeature(Reader(TRBshp).geometries(),ccrs.PlateCarree(),edgecolor='magenta',facecolor='none',linewidth=.5)
    ax.add_feature(TRBfeature)
    
    #Text lebel
    plt.text(-125,50,labels[0], fontsize=10, fontweight ='bold')
    
    #Colorbar
    cbar = plt.colorbar(ax=ax, shrink=.75, pad=0.0)
    cbar.ax.tick_params(labelsize=6)
    cbar.set_label(labels[1], fontsize=10, fontweight ='bold', labelpad=15, rotation=270)
    
    # ###Legend 2###
    # classes=['Hyper-Arid','Arid','Semi-Arid','Dry Sub-humid','Mesic']
    # clrs2=['#fb9a99','#fdbf6f','#b2df8a','#a6cee3','#cab2d6']
    # x=(-127,-127,-127,-127,-127)
    # y=(34.5,33.5,32.5,31.5,30.5)
    # plt.scatter(x,y,s=50,marker='s',c=clrs2,cmap=cmap,norm=norm,alpha=.8,edgecolors='k',zorder=3)
    # for i in np.arange(len(classes)):
    #     ax.text(x[i]+0.4,y[i],classes[i],weight='bold',verticalalignment='center',horizontalalignment='left',size=8,zorder=4)
    
    
    ###Save Image###
    plt.savefig(filename,dpi=600)
    plt.show()
    plt.close()    
    
def WriteToTif(src,geot,filename,dtype):
    cols=src.shape[1]
    rows=src.shape[0]
    sr_wgs84 = osr.SpatialReference()
    sr_wgs84.ImportFromEPSG(4326) #4326 is the EPSG code for WGS84
    ds_out = gdal.GetDriverByName('GTiff').Create(filename,cols,rows,1,dtype)
    band_out = ds_out.GetRasterBand(1)
    #band_out.Fill(np.nan) #no data value
    #band_out.SetNoDataValue(np.nan)
    ds_out.SetProjection(sr_wgs84.ExportToWkt()) #convert to well-known text format for setting projection on output raster
    ds_out.SetGeoTransform(geot)
    band_out.WriteArray(src)
    ds_out.FlushCache()
    
#########################################################################################################

if __name__ == '__main__':
    data_dir='/Users/wksmith/Data/DDSense/DoD_Lands/QGIS_Exports/'
    out_dir='/Users/wksmith/Data/DDSense/DoD_Lands/Figures/'
    #plot NPP
    scale=0.1
    extnd='max'
    labels=['A. NPP',r'gC $m^{-2}$ $y^{-1}$']
    levels = [0,25,50,75,100,200,400,600,800] #colorbar range
    clrs=['#f7fcfd','#e5f5f9','#ccece6','#99d8c9','#66c2a4','#41ae76','#238b45','#006d2c','#00441b',] #greens
    fid=gdal.Open(data_dir+'NPP_WUS_4km.tif')
    #figure_westernUS(fid,scale,clrs,levels,extnd,labels,out_dir+"NPP_DoD_WesternUS.png")
    
    #plot BIO
    scale=1
    extnd='both'
    labels=['C. Species Richness','normalized']
    levels = [0,.05,.1,.15,.2,.3,.4,.5] #colorbar range
    clrs=['#f7fcf0','#e0f3db','#ccebc5','#a8ddb5','#7bccc4','#4eb3d3','#2b8cbe','#0868ac','#084081'] #blues
    fid1=gdal.Open(data_dir+'Reptile_WUS_4km.tif')
    fid2=gdal.Open(data_dir+'Mammal_WUS_4km.tif')
    fid3=gdal.Open(data_dir+'Bird_WUS_4km.tif')
    fid4=gdal.Open(data_dir+'ARD_WUS_4km.tif')
    figure_westernUS_V2(fid1,fid2,fid3,fid4,scale,clrs,levels,extnd,labels,out_dir+"BIO_DoD_WesternUS.png")
    
    #plot ARD
    scale=1
    extnd='both'
    labels=['B. Aridity Class',r'mm $mm^{-1}$']
    #levels = [0,.05,.1,.15,.2,.3,.4,.5,.6] #colorbar range
    #clrs=['#d53e4f','#f46d43','#fdae61','#fee08b','#ffffbf','#e6f598','#abdda4','#66c2a5','#3288bd'] #red-blue
    #clrs=['#8c510a','#bf812d','#dfc27d','#f6e8c3','#f5f5f5','#c7eae5','#80cdc1','#35978f','#01665e'] #brown - cyan
    levels = [0.05,0.2,0.5,0.65] #colorbar range
    clrs=['#fb9a99','#fdbf6f','#b2df8a','#a6cee3','#cab2d6']
    fid=gdal.Open(data_dir+'ARD_WUS_4km.tif')
    #figure_westernUS(fid,scale,clrs,levels,extnd,labels,out_dir+"ARD_DoD_WesternUS.png")
    
    #LAND OWNERSHIP
    labels=['A. Land Ownership',r'xxx']
    #figure_westernUS_vector(fid,scale,clrs,levels,extnd,labels,out_dir+"LandOwnership_WesternUS.png")
    
    
    
    
    