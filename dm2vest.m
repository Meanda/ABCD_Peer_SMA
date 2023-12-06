

path = 'D:\hcp\design_matrix';
file = dir(fullfile(path,'*.txt'));
FileNames = {file.name};

len = length(FileNames);
for i = 1:len,
    x = importdata(FileNames{i});
    x = x.data;
    S = regexp(FileNames{i},'_','split');
    S = strcat(S{1:end-1});
    palm_vestwrite(sprintf('M_%s.mat',S),x);
end 


H = table2array(HappinessUnadjdm)


ids = strcsvread('D:\hcp\social_nomiss_beh_brain.csv');
EB = hcp2blocks('S1200_behavior_restricted.csv','EB.CSV',false,ids);


T = behcol
ids = picktraits('social_nomiss.csv','Age',ids,true,'');
for t = 1:numel(T),
trt = picktraits('social_nomiss.csv',T{t},ids,true,'');
M = [trt age sex ones(size(trt))];
palm_vestwrite(sprintf('M_%s.mat',T{t}),M);
end