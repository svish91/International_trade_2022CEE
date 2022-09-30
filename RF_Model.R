library(reshape2)
library(ranger)
library(randomForest)
# This code is a demonstration of weighted directed trade network
# the same model can be used for unweighted directed trade network by replacing non-zero values with 1

DATA_WD = read.csv('Supplementary_Data_2.csv')

DATA <- DATA_WD
RESPONSE <- "Trade" #column name in the data frame "DATA"
NTREE <- 500

set.seed(10000)

rf_all_WD <- ranger(dependent.variable.name = RESPONSE, data = na.omit(DATA),
                    importance = 'impurity_corrected',
                    respect.unordered.factors = 'partition',
                    num.trees = NTREE)
print(rf_all_WD) 

rm("vn")
count <- 1 #count how many times we re-run RF
while (any(rf_all_WD$variable.importance <= 0)) {
  vn <- names(rf_all_WD$variable.importance)[rf_all_WD$variable.importance > 0]
  DATAnoNA <- na.omit(DATA[, c(RESPONSE, vn)])
  rf_all_WD <- ranger(dependent.variable.name = RESPONSE, data = DATAnoNA,
                      importance = 'impurity_corrected',
                      min.node.size = 3, respect.unordered.factors = 'partition',
                      num.trees = NTREE)
  count <- count + 1
}

# variable importance
set.seed(20000)
if (exists("DATAnoNA") == TRUE) {
  rf_allimp <- importance_pvalues(rf_all_WD, method = "altmann",
                                  num.permutations = 100,
                                  formula = as.formula(paste(RESPONSE, ".", sep = " ~ ")),
                                  data = DATAnoNA)
} else {
  rf_allimp <- importance_pvalues(rf_all_WD, method = "altmann",
                                  num.permutations = 100,
                                  formula = as.formula(paste(RESPONSE, ".", sep = " ~ ")),
                                  data = DATA)  
}
rf_allimp <- rf_allimp[order(rf_allimp[,1]),]
v <- sort(rownames(rf_allimp)[rf_allimp[, 2] < 0.05])


set.seed(30000)
DATAnoNAv <- na.omit(DATA[, c(RESPONSE, v)])
rf_all_WDv <- ranger(dependent.variable.name = RESPONSE, data = DATAnoNAv,
                     respect.unordered.factors = 'partition',
                     num.trees = NTREE)
print(rf_all_WDv)

# Final random forest output from another package to see partial dependence plots:

library(randomForest)
set.seed(40000)
rf_all_WDv2 <- randomForest(y = DATAnoNAv[,RESPONSE],
                            x = DATAnoNAv[, v],
                            nodesize = rf_all_WDv$min.node.size,
                            mtry = rf_all_WDv$mtry,
                            ntree = rf_all_WDv$num.trees)
print(rf_all_WDv2)
plot(rf_all_WDv2)


RF <- rf_all_WDv2
preds <- sort(v)

# variable importance plot
library(vip)
vip(RF) + theme(text = element_text(size = 20))

# Partial dependence plots
par(mfrow = c(ceiling(length(preds)/3), 3))
par(bty = "L", mar = c(5, 6, 4, 1) + 0.1, mgp = c(2, 0.7, 0))
for(i in 1:length(preds)) {
  if(preds[i] == "Time_Block") {
    partialPlot(RF, pred.data = DATAnoNAv, x.var = preds[i],
                las = 1, xlab = "", ylab = "", main = "", xpd = F,
                cex.lab = 2, cex.axis = 2, lwd = 2, cex.names = 2
                #,ylim = c(1000, 2200)
    )
  } else {
    if (preds[i] == "Contiguity" || preds[i] == "offLang"){
      partialPlot(RF, pred.data = DATAnoNAv, x.var = preds[i],
                  las = 1, xlab = preds[i], ylab = "", main = "", xpd = F,
                  cex.lab = 2, cex.axis = 2, lwd = 2, cex.names = 2
                  #,ylim = c(1000, 2200)
      )
    } else {
      partialPlot(RF, pred.data = DATAnoNAv, x.var = preds[i],
                  las = 1, xlab = preds[i], ylab = "", main = "", xpd = F,
                  cex.lab = 2, cex.axis = 2, lwd = 2
                  #,ylim = c(1000, 2200)
      )
    }
    
  }
  mtext("log(kg)", side = 2, line = 4, cex = 1.5)
  mtext(paste("(", letters[i], ")", sep = ""), side = 3, line = 0.1, cex =1, adj = 0)
}
