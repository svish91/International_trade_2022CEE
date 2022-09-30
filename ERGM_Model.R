## ERGM model
library(ergm)
# Unweighted
# creating network
sig.act = "identity"

UW_ERGM <- ergm(ntwrk_trade_Duw ~ 
                  # extreme weather
                  diff(attr = "Heat_Stress", pow = 1, sign.action = sig.act)+
                  edgecov(STS,attrname='STS')+
                  diff(attr = "Production", pow = 1, sign.action = sig.act)+
                  nodecov(attr = "GDP")+
                  nodecov(attr = "GDP_pc")+
                  nodematch(attr = "GATT_WTO")+
                  edgecov(RTA_m, attrname = 'RTA')+ 
                  edgecov(Distance,attrname = "Distance_w")+
                  edgecov(Contiguity,attrname="Contiguity")+
                  edgecov(offLang, attrname = "Common_Lang_off"), 
                control = control.ergm(seed = 10, MCMC.interval = 1, MCMC.burnin=1000, 
                                       MCMLE.nonident.tol = 1e-20) )

# Weighted 
summary(ergm(ntwrk_trade_Dw ~ 
               # extreme weather
               diff(attr = "Cold_Stress", pow = 1, sign.action = sig.act)+
               diff(attr = "Heat_Stress", pow = 1, sign.action = sig.act)+
               edgecov(STS,attrname='STS')+
               diff(attr = "Production", pow = 1, sign.action = sig.act)+
               nodecov(attr = "GDP")+
               nodecov(attr = "GDP_pc")+
               nodematch(attr = "GATT_WTO")+
               edgecov(RTA_m, attrname = 'RTA')+ 
               edgecov(Distance,attrname = "Distance_w")+
               edgecov(Contiguity,attrname="Contiguity")+
               edgecov(offLang, attrname = "Common_Lang_off"),
             response = "TradeQlog",reference = ~Unif(0,round(max(TradeQlog))),
             estimate = "MLE",eval.loglik = TRUE,
             control = control.ergm(seed = 100,
                                    main.method = 'Stochastic-Approximation'), verbose =FALSE))