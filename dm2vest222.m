
%这块是通过python先生成txt文档，再转成vest格式。
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


%生成EB文件
EB = hcp2blocks('S1200_behavior_restricted.csv','EB.CSV',false,ids);


%拖进来overview，生成元胞数组，形成和hcp一毛一样的design matrix文件
ids = picktraits('social_nomiss.csv','Subject','',true,'');
age = picktraits('social_nomiss.csv','Age',ids,true,'');
sex = picktraits('social_nomiss.csv','Gender',ids,true,'');
for t = 1:numel(T),
trt = picktraits('social_nomiss.csv',T{t},ids,true,'');
M = [trt age sex ones(size(trt))];
palm_vestwrite(sprintf('M_%s.mat',T{t}),M);
end
%到这发现，happiness is not found,生成的也只有两列，所以单独再写一遍手动生成好了。。。。
trt = picktraits('social_nomiss.csv','Happiness_Unadj','',true,'');
%到这发现还是不得行，还是Trait "Happiness_Unadj" not found,换个方法，手动导入这一列成为列向量。
trt = Happiness_Unadj
M = [trt age sex ones(size(trt))];
palm_vestwrite('M_Happiness_Unadj.mat',M);

%算了，老子放弃了。再见。


