#replication-norms: TABLE 2
#MAY 2023

#load needed packages
library(tidyverse)
library(miceadds) 
library(dplyr)
library(texreg)

setwd("XXX")

#load data
data <- read.csv2("data/master.csv", sep = ",")
attach(data)

#############################################
#
#Table 2
#
#############################################
model1a <- lm.cluster(Punishment ~ ViolationHelp*Child, 
                      cluster = 'School',
                      data = data)

model1b <- lm.cluster(Punishment ~ ViolationHelp*Child + 
                        hugo + male + Morning + witness + rich + Rain + Hot, 
                      cluster = 'School',
                      data = data)

model2a <- lm.cluster(Helping ~ ViolationHelp*Child, 
                      cluster = 'School',
                      data = data %>%
                        filter(Violation==0))

model2b <- lm.cluster(Helping ~ ViolationHelp*Child + 
                        hugo + male + Morning + witness + rich + Rain + Hot, 
                      cluster = 'School',
                      data = data %>%
                        filter(Violation==0))


#display results
screenreg(list(model1a, model1b, model2a, model2b), 
          type = "html",
          stars = c(0.01, 0.05, 0.10),
          custom.header = list("Punishment" = 1:2, "Helping" = 3:4),
          custom.model.names = c("(1)", "(2)", "(3)", "(4)"),
          reorder.coef = c(3, 2, 4, 5, 6, 7, 8, 9, 10, 11, 1),
          custom.coef.names = c("Constant", "VH", "Child", "Child x VH",
                                "Male Target", "Male Actor", "Morning", "Witness",
                                "Rich area", "Rain", "Hot"),
          custom.gof.rows = list("Clusters" = c("30", "30", "30", "30"), 
                                 "F" = c("7.74", "5.17", "7.36", "6.45"), 
                                 "Degrees of freedom" = c("29", "29", "29", "29")),
          reorder.gof = c(6, 1, 4, 5, 2, 3),
          custom.note = "Notes: The table contains results from pooled Ordinary Least Squared regressions. The dependent variable is a binary variable for punishment (columns 1 and 2) or helping (columns 3 and 4). Standard errors in parentheses are clustered at the school level (30 clusters). One observation is dropped due to missing data on the target's gender. * p < 0.10 ** p < 0.05 *** p < 0.01.)"
          )

#Export results
texreg(list(model1a, model1b, model2a, model2b),
       file = "results/Table2R",
       caption = "Table 2",
       label = "Table2",
       stars = c(0.01, 0.05, 0.10),
       custom.header = list("Punishment" = 1:2, "Helping" = 3:4),
       custom.model.names = c("(1)", "(2)", "(3)", "(4)"),
       reorder.coef = c(3, 2, 4, 5, 6, 7, 8, 9, 10, 11, 1),
       custom.coef.names = c("Constant", "VH", "Child", "Child x VH",
                             "Male Target", "Male Actor", "Morning", "Witness",
                             "Rich area", "Rain", "Hot"),
       custom.gof.rows = list("Clusters" = c("30", "30", "30", "30"), 
                              "F" = c("7.74", "5.17", "7.36", "6.45"), 
                              "Degrees of freedom" = c("29", "29", "29", "29")),
       reorder.gof = c(6, 1, 4, 5, 2, 3),
       custom.note = "Notes: The table contains results from pooled Ordinary Least Squared regressions. The dependent variable is a binary variable for punishment (columns 1 and 2) or helping (columns 3 and 4). Standard errors in parentheses are clustered at the school level (30 clusters). One observation is dropped due to missing data on the target's gender. * p < 0.10 ** p < 0.05 *** p < 0.01.)")

