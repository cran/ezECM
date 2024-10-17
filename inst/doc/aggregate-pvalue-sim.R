## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ezECM)

## ----pvalgen------------------------------------------------------------------
simulated.pvalues <- pval_gen(sims = 160, grid.dim = c(1000,1000,30), 
                              seismometer = list(N = 100, max.depth = 2),
                              explosion = list(max.depth = 3, prob = 0.3),
                              pwave.arrival = list(H0 = 4, optim.starts = 15),
                              first.polarity  = list(read.err = 0.6))

## ----pvalgen_summary----------------------------------------------------------
summary(simulated.pvalues)

## ----pvalgen_singlerow--------------------------------------------------------
simulated.pvalues[1,]

## ----pvalgen_traindf----------------------------------------------------------
train <- simulated.pvalues[1:150,]
new.data <- simulated.pvalues[151:160,]

knitr::kable(new.data, format = "html")

## ----truecat------------------------------------------------------------------
new.data.true <- new.data$event
new.data$event <- NULL

## ----pagg_fit-----------------------------------------------------------------
fit <- cECM(x = train)

## ----ecmplot------------------------------------------------------------------
plot(fit)

## ----pagg_newdata-------------------------------------------------------------
new.data.category <- cECM(x = fit, newdata = new.data)

## ----pagg_summary-------------------------------------------------------------
categories <- cbind(new.data.category$cECM, new.data.true)
categories <- categories[c("explosion", "new.data.true")]

knitr::kable(categories, format = "html")

