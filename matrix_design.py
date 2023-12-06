# -*- coding: utf-8 -*-
"""
Created on Fri Jan  7 16:48:56 2022

@author: zhang
"""
import pandas as pd
import numpy as np

final = pd.read_csv('D:/hcp/social.csv')
print(final.columns)

from sklearn import preprocessing
#数据先标准化
scaler = preprocessing.StandardScaler()
df_scaled = scaler.fit_transform(final.iloc[:,3:])
df_scaled = pd.DataFrame(df_scaled, columns=final.columns[3:])
final.iloc[:,3:] = df_scaled

#算几个指标
final['Anger_Unadj'] = (final['AngAffect_Unadj'] + final['AngHostil_Unadj'] + final['AngAggr_Unadj'])/3
final['Fear_Unadj'] = (final['FearAffect_Unadj']+final['FearSomat_Unadj'])/2
final['NegaAff_Unadj'] = (final['Anger_Unadj']+final['Fear_Unadj']+final['Sadness_Unadj'])/3
final['Support_Unadj'] = (final['EmotSupp_Unadj']+final['EmotSupp_Unadj'])/2
final['Happiness_Unadj'] = final['LifeSatisf_Unadj']+final['MeanPurp_Unadj']+final['PosAffect_Unadj']-final['NegaAff_Unadj']

#再标准化一遍
scaler = preprocessing.StandardScaler()
df_scaled = scaler.fit_transform(final.iloc[:,3:])
df_scaled = pd.DataFrame(df_scaled, columns=final.columns[3:])
final.iloc[:,3:] = df_scaled

final.to_csv('D:/hcp/social_recal.csv',index=False)

check = pd.read_csv('D:/hcp/HCPYA_rfMRI_file_check.tsv', sep='\t')
check = check.set_index('subID')
for col in check.columns:
    check = check[check[col]=='ok=(1200, 91282)']
check = check.reset_index()
subid = list(check['subID'])
final = final[final['Subject'].isin(subid)]

no_missing = final.dropna(how='any')

restricted_missing = no_missing[~no_missing['Subject'].isin([122418,168240,376247])]
#index: 369:168240; 740:376247


no_missing.to_csv('D:/hcp/social_nomiss_beh_brain.csv',index=False)
restricted_missing.to_csv('D:/hcp/social_nomiss.csv',index=False)

restricted_missing = pd.read_csv('D:/hcp/social_nomiss.csv')
ones = list(np.ones(len(restricted_missing)))
for col in restricted_missing.columns[3:]:
    df = pd.DataFrame(restricted_missing,columns=[col,'Age','Gender'])
    df['ones'] = ones
    df.to_csv(f'D:/hcp/design_matrix/{col}_dm.txt',sep='\t',index=False)
    