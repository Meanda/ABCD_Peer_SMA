

#导入包
library(bruceR)

#设置路径
set.wd("D:/hcp/MAPnLone")

#导入数据
df = import("MAP_lone_outcome_brain.sav")

#mediation
PROCESS(df, y="Loneliness",x="OA",meds="MIL",ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Loneliness",x="OA",meds="MIL",covs=c("Gender","Age","Edu","PosAffect"),ci="boot",nsim=5000,seed=1)


PROCESS(df, y="Loneliness",x="GBCadj_rAI",meds="MIL",ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Loneliness",x="GBC_rAI",meds="MIL",covs=c("Gender","Age","Edu","PosAffect"),ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Loneliness",x="GBCadj_rAI",meds="MIL",covs=c("Gender","Age","Edu","PosAffect","NEOFAC_N"),ci="boot",nsim=5000,seed=1)


PROCESS(df, y="Loneliness",x="GBCadj_8BM",meds="MIL",ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Loneliness",x="GBCadj_8BM",meds="MIL",covs=c("Gender","Age","Edu","PosAffect"),ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Loneliness",x="GBCadj_8BM",meds="MIL",covs=c("Gender","Age","Edu","PosAffect","NEOFAC_N"),ci="boot",nsim=5000,seed=1)


PROCESS(df, y="Lone",x="R8Av",meds="MeanPurp",ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Lone",x="R8Av",meds="MeanPurp",covs=c("Gender","Age","Educ","PosAff"),ci="boot",nsim=5000,seed=1)

PROCESS(df, y="Lone",x="R31pv",meds="MeanPurp",ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Lone",x="R31pv",meds="MeanPurp",covs=c("Gender","Age","Educ","PosAff"),ci="boot",nsim=5000,seed=1)

PROCESS(df, y="Lone",x="R31pd",meds="MeanPurp",ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Lone",x="R31pd",meds="MeanPurp",covs=c("Gender","Age","Educ","PosAff"),ci="boot",nsim=5000,seed=1)
                        
1)

PROCESS(df, y="MeanPurp",x="RAAIC",meds="Lone",covs=c("Gender","Age","Educ","PosAff"),ci="boot",nsim=5000,seed=1)

# moderation x-m
model=PROCESS(df, x="GBC_rAI",y="MIL",mods="Gender",ci="boot",nsim=5000,seed=1)

#moderated mediation
#no convariates' controll
model=PROCESS(df, y="Loneliness",x="GBC_rAI",meds="MIL",mods=c("NEOFAC_N"),mod.type="2way",mod.path=c("m-y"),ci="boot",nsim=5000,seed=1)

# controll covariates
model=PROCESS(df, y="Loneliness",x="GBCadj_rAI",meds="MIL",mods=c("NEOFAC_N"),mod.type="2way",mod.path=c("m-y"),covs=c("Age","Edu","PosAffect","Gender"),ci="boot",nsim=5000,seed=1)

model=PROCESS(df, y="Loneliness",x="GBC_rAI",meds="MIL",mods=c("Gender"),mod.type="2way",mod.path=c("x-m"),covs=c("Age","Edu","PosAffect"),ci="boot",nsim=5000,seed=1)
model=PROCESS(df, y="Loneliness",x="FC_r8Av",meds="MIL",mods=c("Gender"),mod.type="2way",mod.path=c("x-m"),covs=c("Age","Edu","PosAffect"),ci="boot",nsim=5000,seed=1)
model=PROCESS(df, y="Loneliness",x="FC_r31pd",meds="MIL",mods=c("Gender"),mod.type="2way",mod.path=c("x-m"),covs=c("Age","Edu","PosAffect"),ci="boot",nsim=5000,seed=1)
model=PROCESS(df, y="Loneliness",x="FC_r31pv",meds="MIL",mods=c("Gender"),mod.type="2way",mod.path=c("x-m"),covs=c("Age","Edu","PosAffect"),ci="boot",nsim=5000,seed=1)

model=PROCESS(df, y="Lone",x="FC_r8Av",meds="MIL",mods=c("NEON"),mod.type="2way",mod.path=c("x-m"),covs=c("Age","Edu","PosAff","Gender"),ci="boot",nsim=5000,seed=1)
model=PROCESS(df, y="Lone",x="FC_r31pd",meds="MIL",mods=c("NEON"),mod.type="2way",mod.path=c("x-m"),covs=c("Age","Edu","PosAff","Gender"),ci="boot",nsim=5000,seed=1)
model=PROCESS(df, y="Lone",x="FC_r31pv",meds="MIL",mods=c("NEON"),mod.type="2way",mod.path=c("x-m"),covs=c("Age","Edu","PosAff","Gender"),ci="boot",nsim=5000,seed=1)


model_summary(model, file="ModMedResults.doc")
#moderation
PROCESS(df, y="Lone",x="MeanPurp", mods=c("Age","Gender"))

#serial mediation
PROCESS(df, y="Intern",x="GBC_rAI",meds=c("MIL","Lone"),med.type = "serial", covs=c("Age","Edu","PosAff","Gender"),ci="boot",nsim=5000,seed=1)
PROCESS(df, y="general",x="GBC_rAI",meds=c("MIL","Lone"),med.type = "serial", covs=c("Age","Edu","PosAff","Gender"),ci="boot",nsim=5000,seed=1)


PROCESS(df, y="Intern",x="GBC_rAI",meds=c("MIL","Lone"),mods=c("NEON"),mod.type="2way",mod.path=c("m-y"),covs=c("Age","Edu","PosAff","Gender"),ci="boot",nsim=5000,seed=1)
PROCESS(df, y="Extern",x="GBC_rAI",meds=c("MIL","Lone"),mods=c("NEON"),mod.type="2way",mod.path=c("m-y"),ci="boot",nsim=5000,seed=1)
PROCESS(df, y="general",x="GBC_rAI",meds=c("MIL","Lone"),mods=c("NEON"),mod.type="2way",mod.path=c("m-y"),covs=c("Age","Edu","PosAff","Gender"),ci="boot",nsim=5000,seed=1)

#11111

