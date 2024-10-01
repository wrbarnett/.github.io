library(survival)
library(rms)

dat1=read.csv("vae.csv")

#Cox regression
coxfit <- cph(formula = Surv(time, status==1) ~ home + bmigroup + chf + cad + kidney + lung + ed + ward + tpn, data = dat1, x=T, y=T, surv=T)
coxfit

#Predictions for an event within 7 days
survest(coxfit, times=7)

#base^(exp*(center + beta))	
		
#Kaplan-Meier Curves
vae.surv <- survfit(Surv(time, status) ~ vaetype, data = dat1) 
plot(vae.surv, lty = 1, col = c('white','blue', 'green', 'red'), xlab = "Ventilator Days", ylab = "Proportion")
legend('topright', c("VAC", "IVAC", "VAP"), lty = 1, col = c('blue', 'green', 'red'))
title("Ventilator-associated Events (VAEs)\nfor Kaplan-Meier Curves")
summary(vae.surv) 
