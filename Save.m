 function []=Save()
clear all;
tic
global l;%输入信号个数
global m;%每代产生的随机输入向量个数
global n;%待选输入向量的个数
global tr;%第一部分阈值
global th;%初始共识阈值
global th_min;%最小共识阈值
global WRV_CS;%最差输入向量得分
global WRV;%最差输入向量
global und_ins;%不确定的位数数量
global critical_list;%关键节点列表
global Ng;%基本门的个数
global outputnum;%原始输出端线号；
global num_input;%原始输入端序列位置
global cand_list;%待选输入向量列表
global cand_scores;%待选输入向量得分


pg=0.05;%指单元的故障概率
[CompleteCell,PriOpt,NPriIpt,NGates]=NetlistParse(pg);  %网表解析，并提取相关参数
[buff_num] = Get_buff(CompleteCell);%获取buff门的个数
get_input();%获取原始输入端排序
l=NPriIpt; %电路的原始输入端个数
Ng=NGates-buff_num;%基本门的个数
outputnum = PriOpt;%原始输出端线号；

n=10;
WRV_CS=0;%最差输入向量得分
WRV(1:l)=-1;%初始每一位都为-1
cand_list(1:n,1:l)=0;%待选输入向量列表初始都为0
cand_scores(1:n,1)=0;%待选输入向量得分初始为0
und_ins=l;%不确定位数初始为全部输入信号个数
critical_list=[];%关键节点初始为空集

%实验临时取值
m=1000;
tr=5;
th=0.9;
th_min=0.7;

global k;
Main;%寻找最坏输入向量
for k=1:n
    [Result2]=CalResult();
    result=Result2(:,1);
    
    fid = fopen('c432_329.txt','a');
    fprintf(fid,'最差输入向量为：');
    fprintf(fid,'%d ',cand_list(k,:));   
    fprintf(fid,'\n');
    fprintf(fid,'最差输入向量下敏感电路单元为：');
    fprintf(fid,'%d ',result);
    fprintf(fid,'\n');
    
end
tt=toc;%统计时间
fid = fopen('c432_329.txt','a');
fprintf(fid,'执行时间为：');
fprintf(fid,'%.2f',tt);
fprintf(fid,'\n');

whos
end