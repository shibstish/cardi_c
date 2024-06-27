#test treemix figure making
#from: https://speciationgenomics.github.io/Treemix/

setwd()
library(RColorBrewer)
library(R.utils)
library(phytools)

#first thing: unzip files for all migration edges and put in working directory

#functions from plotting_funcs.R
set_y_coords = function(d){
  i = which(d[,3]=="ROOT")
  y = d[i,8]/ (d[i,8]+d[i,10])
  d[i,]$y = 1-y
  d[i,]$ymin = 0
  d[i,]$ymax = 1
  c1 = d[i,7]
  c2 = d[i,9]
  ni = which(d[,1]==c1)
  ny = d[ni,8]/ (d[ni,8]+d[ni,10])
  d[ni,]$ymin = 1-y
  d[ni,]$ymax = 1
  d[ni,]$y = 1- ny*(y)
  
  ni = which(d[,1]==c2)
  ny = d[ni,8]/ (d[ni,8]+d[ni,10])
  d[ni,]$ymin = 0
  d[ni,]$ymax = 1-y
  d[ni,]$y = (1-y)-ny*(1-y)
  
  for (j in 1:nrow(d)){
    d = set_y_coord(d, j)
  }	
  return(d)
}

set_y_coord = function(d, i){
  index = d[i,1]
  parent = d[i,6]
  if (!is.na(d[i,]$y)){
    return(d)
  }
  tmp = d[d[,1] == parent,]
  if ( is.na(tmp[1,]$y)){
    d = set_y_coord(d, which(d[,1]==parent))
    tmp = d[d[,1]== parent,]
  }
  py = tmp[1,]$y
  pymin = tmp[1,]$ymin
  pymax = tmp[1,]$ymax
  f = d[i,8]/( d[i,8]+d[i,10])
  #print (paste(i, index, py, pymin, pymax, f))
  if (tmp[1,7] == index){
    d[i,]$ymin = py
    d[i,]$ymax = pymax
    d[i,]$y = pymax-f*(pymax-py)
    if (d[i,5]== "TIP"){
      d[i,]$y = (py+pymax)/2
    }
  }
  else{
    d[i,]$ymin = pymin
    d[i,]$ymax = py
    d[i,]$y = py-f*(py-pymin)
    if (d[i,5]== "TIP"){
      d[i,]$y = (pymin+py)/2
    }	
    
  }
  return(d)
}


set_x_coords = function(d, e){
  i = which(d[,3]=="ROOT")
  index = d[i,1]
  d[i,]$x = 0
  c1 = d[i,7]
  c2 = d[i,9]
  ni = which(d[,1]==c1)
  tmpx =  e[e[,1]==index & e[,2] == c1,3]
  if (length(tmpx) == 0){
    tmp = e[e[,1] == index,]
    tmpc1 = tmp[1,2]
    if ( d[d[,1]==tmpc1,4] != "MIG"){
      tmpc1 = tmp[2,2]
    }
    tmpx = get_dist_to_nmig(d, e, index, tmpc1)
  }
  if(tmpx < 0){
    tmpx = 0
  }
  d[ni,]$x = tmpx
  
  ni = which(d[,1]==c2)
  tmpx =  e[e[,1]==index & e[,2] == c2,3]
  if (length(tmpx) == 0){
    tmp = e[e[,1] == index,]
    tmpc2 = tmp[2,2]
    if ( d[d[,1]==tmpc2,4] != "MIG"){
      tmpc2 = tmp[1,2]
    }
    tmpx = get_dist_to_nmig(d, e, index, tmpc2)
  }
  if(tmpx < 0){
    tmpx = 0
  }
  d[ni,]$x = tmpx
  
  for (j in 1:nrow(d)){
    d = set_x_coord(d, e, j)
  }
  return(d)
  print(d)
}


set_x_coord = function(d, e, i){
  index = d[i,1]
  parent = d[i,6]
  if (!is.na(d[i,]$x)){
    return(d)
  }
  tmp = d[d[,1] == parent,]
  if ( is.na(tmp[1,]$x)){
    d = set_x_coord(d, e, which(d[,1]==parent))
    tmp = d[d[,1]== parent,]
  }
  #print (paste(parent, index))
  tmpx =  e[e[,1]==parent & e[,2] == index,3]
  if (length(tmpx) == 0){
    tmp2 = e[e[,1] == parent,]
    tmpc2 = tmp2[2,2]
    #print
    if ( d[d[,1]==tmpc2,4] != "MIG"){
      tmpc2 = tmp2[1,2]
    }
    tmpx = get_dist_to_nmig(d, e, parent, tmpc2)
  }
  if(tmpx < 0){
    tmpx = 0
  }
  d[i,]$x = tmp[1,]$x+ tmpx
  return(d)
}

plot_tree_internal = function(d, e, o = NA, cex = 1, disp = 0.005, plus = 0.005, arrow = 0.05, ybar = 0.01, scale = T, mbar = T, mse = 0.01, plotmig = T, plotnames = T, xmin = 0, lwd = 1, font = 1){
  plot(d$x, d$y, axes = F, ylab = "", xlab = "Drift parameter", xlim = c(xmin, max(d$x)+plus), pch = "")
  axis(1)
  mw = max(e[e[,5]=="MIG",4])
  mcols = rev(heat.colors(150))
  for(i in 1:nrow(e)){
    col = "black"
    if (e[i,5] == "MIG"){
      w = floor(e[i,4]*200)+50
      if (mw > 0.5){
        w = floor(e[i,4]*100)+50
      }
      col = mcols[w]
      if (is.na(col)){
        col = "blue"
      }
    }
    v1 = d[d[,1] == e[i,1],]
    v2 = d[d[,1] == e[i,2],]
    if (e[i,5] == "MIG"){
      if (plotmig){
        arrows( v1[1,]$x, v1[1,]$y, v2[1,]$x, v2[1,]$y, col = col, length = arrow)
      }
    }
    else{
      lines( c(v1[1,]$x, v2[1,]$x), c(v1[1,]$y, v2[1,]$y), col = col, lwd = lwd)
    }
  }
  tmp = d[d[,5] == "TIP",]
  print(tmp$x)
  print(disp)
  if ( !is.na(o)){
    for(i in 1:nrow(tmp)){
      tcol = o[o[,1] == tmp[i,2],2]
      if(plotnames){
        #print(tmp[i,2])
        text(tmp[i,]$x+disp, tmp[i,]$y, labels = tmp[i,2], adj = 0, cex = cex, col  = tcol, font = font)
      }
    }
  }
  else{
    if (plotnames){
      text(tmp$x+disp, tmp$y, labels = tmp[,2], adj = 0, cex = cex, font = font)
    }
  }
  if (scale){
    print (paste("mse", mse))
    lines(c(0, mse*10), c(ybar, ybar))
    text( 0, ybar - 0.04, lab = "10 s.e.", adj = 0, cex  = 0.8)
    lines( c(0, 0), c( ybar - 0.01, ybar+0.01))
    lines( c(mse*10, mse*10), c(ybar- 0.01, ybar+ 0.01))
  }
  if (mbar){
    mcols = rev( heat.colors(150) )
    mcols = mcols[50:length(mcols)]
    ymi = ybar+0.15
    yma = ybar+0.35
    l = 0.2
    w = l/100
    xma = max(d$x/20)
    rect( rep(0, 100), ymi+(0:99)*w, rep(xma, 100), ymi+(1:100)*w, col = mcols, border = mcols)
    text(xma+disp, ymi, lab = "0", adj = 0, cex = 0.7)
    if ( mw >0.5){ text(xma+disp, yma, lab = "1", adj = 0, cex = 0.7)}
    else{
      text(xma+disp, yma, lab = "0.5", adj = 0, cex =0.7)
    }
    text(0, yma+0.06, lab = "Migration", adj = 0 , cex = 0.6)
    text(0, yma+0.03, lab = "weight", adj = 0 , cex = 0.6)
  }	
}

set_mig_coords = function(d, e){
  for (j in 1:nrow(d)){
    if (d[j,4] == "MIG"){
      p = d[d[,1] == d[j,6],]
      c = d[d[,1] == d[j,7],]
      tmpe = e[e[,1] == d[j,1],]
      y1 = p[1,]$y
      y2 = c[1,]$y
      x1 = p[1,]$x
      x2 = c[1,]$x
      
      mf = tmpe[1,6]	
      if (is.nan(mf)){
        mf = 0
      }
      #d[j,]$y = (y1+y2)* mf
      #d[j,]$x = (x1+x2) *mf
      d[j,]$y = y1+(y2-y1)* mf
      print(paste(mf, x1, x2))
      d[j,]$x = x1+(x2-x1) *mf
    }	
    
  }
  return(d)
}

get_f = function(stem){
  d = paste(stem, ".cov.gz", sep = "")
  d2 = paste(stem, ".modelcov.gz", sep = "")
  d = read.table(gzfile(d), as.is = T, comment.char = "", quote = "")
  d2 = read.table(gzfile(d2), as.is = T, comment.char = "", quote = "")
  d = d[order(names(d)), order(names(d))]
  d2 = d2[order(names(d2)), order(names(d2))]
  tmpcf = vector()
  tmpmcf = vector()
  for (j in 1:nrow(d)){
    for (k in (j+1):nrow(d)){
      tmpcf = append(tmpcf, d[j,k])
      tmpmcf = append(tmpmcf, d[j,k] - d2[j,k])
    }
  }
  tmpv = var(tmpmcf)/var(tmpcf)
  return(1-tmpv)
}

flip_node = function(d, n){
  i = which(d[,1] == n)
  t1 = d[i,7]
  t2 = d[i,8]
  d[i,7] = d[i,9]
  d[i,8] = d[i,10]
  d[i,9] = t1
  d[i,10] = t2
  return(d)
}

plot_tree = function(stem, o = NA, cex = 1, disp = 0.003, plus = 0.01, flip = vector(), arrow = 0.05, scale = T, ybar = 0.1, mbar = T, plotmig = T, plotnames = T, xmin = 0, lwd = 1, font = 1){
  d = paste(stem, ".vertices", sep = "")
  e = paste(stem, ".edges", sep = "")
  se = paste(stem, ".covse", sep = "")
  d = read.table(d, as.is = T, comment.char = "", quote = "")
  e = read.table(e, as.is  = T, comment.char = "", quote = "")
  if (!is.na(o)){
    o = read.table(o, as.is = T, comment.char = "", quote = "")
  }
  e[,3] = e[,3]*e[,4]
  e[,3] = e[,3]*e[,4]
  
  se = read.table(se, as.is = T, comment.char = "", quote = "")
  m1 = apply(se, 1, mean)
  m = mean(m1)
  #m = 0
  for(i in 1:length(flip)){
    d = flip_node(d, flip[i])
  }
  d$x = "NA"
  d$y = "NA"
  d$ymin = "NA"
  d$ymax = "NA"
  d$x = as.numeric(d$x)
  d$y = as.numeric(d$y)
  d$ymin = as.numeric(d$ymin)
  d$ymax = as.numeric(d$ymax)
  
  d = set_y_coords(d)
  d = set_x_coords(d, e)
  print(d)
  d = set_mig_coords(d, e)
  plot_tree_internal(d, e, o = o, cex = cex, xmin = xmin, disp = disp, plus = plus, arrow = arrow, ybar = ybar, mbar = mbar, mse = m, scale = scale, plotmig = plotmig, plotnames = plotnames, lwd = lwd, font = font)
  return(list( d= d, e = e))
}

get_dist_to_nmig = function(d, e, n1, n2){
  toreturn = e[e[,1] == n1 & e[,2] == n2,3]
  #print(toreturn)
  while ( d[d[,1] ==n2,4] == "MIG"){
    tmp = e[e[,1] == n2 & e[,5] == "NOT_MIG",]
    toreturn = toreturn+tmp[1,3]
    n2 = tmp[1,2]
  }
  return(toreturn)
}

#file
prefix='medge6'

#set dimensions of plot window
par(mfrow=c(2,3))
for(edge in 1:6){
  plot_tree(paste0(prefix,'_',edge), cex=0.8)
  title(paste(edge," edges"))
}

plot_tree(paste0(prefix,'_',1), cex=0.8)
title(paste(1," edges"))

plot_tree(paste0(prefix,'_',2), cex=0.8)
title(paste(2," edges"))

plot_tree(paste0(prefix,'_',3), cex=0.8)
title(paste(3," edges"))

plot_tree(paste0(prefix,'_',4), cex=0.8)
title(paste(4," edges"))

plot_tree(paste0(prefix,'_',5), cex=0.8)
title(paste(5," edges"))

#plot_tree(paste0(prefix,'_',6), cex=0.8)
#title(paste(6," edges"))
#plot likelihoods (from '.llik' files) 

