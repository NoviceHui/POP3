 function []=Save()
clear all;
tic
global l;%�����źŸ���
global m;%ÿ�����������������������
global n;%��ѡ���������ĸ���
global tr;%��һ������ֵ
global th;%��ʼ��ʶ��ֵ
global th_min;%��С��ʶ��ֵ
global WRV_CS;%������������÷�
global WRV;%�����������
global und_ins;%��ȷ����λ������
global critical_list;%�ؼ��ڵ��б�
global Ng;%�����ŵĸ���
global outputnum;%ԭʼ������ߺţ�
global num_input;%ԭʼ���������λ��
global cand_list;%��ѡ���������б�
global cand_scores;%��ѡ���������÷�


pg=0.05;%ָ��Ԫ�Ĺ��ϸ���
[CompleteCell,PriOpt,NPriIpt,NGates]=NetlistParse(pg);  %�������������ȡ��ز���
[buff_num] = Get_buff(CompleteCell);%��ȡbuff�ŵĸ���
get_input();%��ȡԭʼ���������
l=NPriIpt; %��·��ԭʼ����˸���
Ng=NGates-buff_num;%�����ŵĸ���
outputnum = PriOpt;%ԭʼ������ߺţ�

n=10;
WRV_CS=0;%������������÷�
WRV(1:l)=-1;%��ʼÿһλ��Ϊ-1
cand_list(1:n,1:l)=0;%��ѡ���������б��ʼ��Ϊ0
cand_scores(1:n,1)=0;%��ѡ���������÷ֳ�ʼΪ0
und_ins=l;%��ȷ��λ����ʼΪȫ�������źŸ���
critical_list=[];%�ؼ��ڵ��ʼΪ�ռ�

%ʵ����ʱȡֵ
m=1000;
tr=5;
th=0.9;
th_min=0.7;

global k;
Main;%Ѱ�����������
for k=1:n
    [Result2]=CalResult();
    result=Result2(:,1);
    
    fid = fopen('c432_329.txt','a');
    fprintf(fid,'�����������Ϊ��');
    fprintf(fid,'%d ',cand_list(k,:));   
    fprintf(fid,'\n');
    fprintf(fid,'����������������е�·��ԪΪ��');
    fprintf(fid,'%d ',result);
    fprintf(fid,'\n');
    
end
tt=toc;%ͳ��ʱ��
fid = fopen('c432_329.txt','a');
fprintf(fid,'ִ��ʱ��Ϊ��');
fprintf(fid,'%.2f',tt);
fprintf(fid,'\n');

whos
end