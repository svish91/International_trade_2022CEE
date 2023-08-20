f_derivedPCA_WI_m <- function(allWI_d, thr=80, scale = "Y"){
    library(reticulate)
    library(FactoMineR)
    library("factoextra")

    if (identical(scale,"Y")){
        # scaling
        allWI_s = scale(allWI_d)
    } else {
        allWI_s = allWI_d # this is for count only data
    }
    
    # scale the matrix 
    WI_pca = PCA(allWI_d, graph = FALSE, scale.unit = TRUE)
    
    # checking which index has thr% or more variance
    idx_thr = which(cumsum(WI_pca$eig[,2])>=thr)[1]#which.min(diff(sort(WI_pca$eig[,2], decreasing = T)))#
    # percentage contribution
    if (idx_thr == 1){
        WI_pca_contrib <- get_pca_var(WI_pca)$contrib[,1]
    } else{
        WI_pca_contrib <- get_pca_var(WI_pca)$contrib[,1:idx_thr]
    }
    
    wi_screeP_names = list()
    wi_screeP_contrib = list()
    allWI_m_screeP_pca = matrix(NA, nrow=dim(allWI_d)[1], ncol=idx_thr)
    
    for(j in 1:idx_thr){
        if (idx_thr == 1){
            wi_contrib_sort = sort(WI_pca_contrib, decreasing = TRUE)
        } else{        
            wi_contrib_sort = sort(WI_pca_contrib[,j], decreasing = TRUE)
        }
        i = which.min(diff(wi_contrib_sort))
        wi_screeP_names[[j]] = names(wi_contrib_sort)[1:i]
        wi_screeP_contrib[[j]] =  wi_contrib_sort[1:i]
        if (idx_thr == 1){
            allWI_m_screeP_pca[,j] = allWI_s[,wi_screeP_names[[j]], drop = FALSE] %*% WI_pca_contrib[wi_screeP_names[[j]], drop=FALSE]
        } else{
            allWI_m_screeP_pca[,j] = allWI_s[,wi_screeP_names[[j]], drop = FALSE] %*% WI_pca_contrib[wi_screeP_names[[j]], j, drop=FALSE]
        }
    }
    
    allWI_m_screeP_pca <- data.frame(allWI_m_screeP_pca)
    cname = 0
    for (j in 1:idx_thr){cname[j] = paste("Dim.",j,sep="") }
    colnames(allWI_m_screeP_pca) = cname
    rownames(allWI_m_screeP_pca) = rownames(allWI_d)
    
    return(list("WI_PCA"=WI_pca, "derived_PCA" = allWI_m_screeP_pca,
                "derived_PCA_ScreeP_names" = wi_screeP_names,
                "derived_PCA_ScreeP_contrib" = wi_screeP_contrib,
                "WI_scaled" = allWI_s,
                "chosen_dim" = cname))
}
    