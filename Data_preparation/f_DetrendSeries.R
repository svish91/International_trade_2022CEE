f_DetrendSeries <- function(xx){

    # loess method
    # finding the best span value
    xx_CV = xx
    pred_CV = xx
    h_co = 0
    err_min = 0
    
    # n: sample size
    h_seq = seq(from=0.15,to=1, by=0.1)
    CV_err_h = rep(NA, length(h_seq)) 
    
    X = 1:nrow(xx)
    n = nrow(xx)
    for (co in 1:ncol(xx)){
        #n = length(xx[,co])
        
        Y = xx[,co]
        if (all(is.na(Y))){
            xx_CV[,co] = NA
           next
        }
        
        #X = 1:nrow(xx)

        for(j in 1:length(h_seq)){
            h_using = h_seq[j] 
            CV_err = rep(NA, n)
            for(i in 1:n){
                Y_val = Y
                # validation set
                #X_tr = X[-i]
                #Y_tr = Y[-i]
                # training set
                #Y_val_mdl = loess(Y_tr ~ X_tr, span = h_using, control = loess.control(surface = "direct"))
                x.inv = try(loess(Y[-i] ~ X[-i], span = h_using, control = loess.control(surface = "direct")),
                            silent=T)
                if (('try-error' %in% class(x.inv))) {
                    next
                } else {
                    Y_val_mdl = loess(Y[-i] ~ X[-i], span = h_using, control = loess.control(surface = "direct"))
                }
                #predict(Y_val_mdl,newdata = X[i])
                CV_err[i] = (Y_val[i] - predict(Y_val_mdl,newdata = X[i]))^2
                # we measure the error in terms of difference sqaure
            } 
            CV_err_h[j] = mean(CV_err, na.rm = TRUE)
        }
        
        
        # selecting which 
        min_CV = which.min(CV_err_h) 
        # save this for different countires
        h_co[co] = h_seq[min_CV]
        err_min[co] = min_CV
        ### re-evaluating using the selected span
        Y_val_predict = loess(Y ~ X, span = h_seq[min_CV])#, control = loess.control(surface = "direct"))
    
        ## residuals
        xx_CV[!is.na(Y),co] = Y[!is.na(Y)] - Y_val_predict$fitted # residuals
        pred_CV[!is.na(Y),co] = Y_val_predict$fitted
        
    }
    rslt <- list("DTS"=xx_CV,"predY" = pred_CV,"span" = h_co,"errorCV" = err_min  )
    #return(as.data.frame(xx_CV))
    return(rslt)
}
