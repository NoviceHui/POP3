%��·�������
%class(CompleteCell{1,17}{1,7}(1))���鿴��������������
function [CompleteCell,PriOpt,NPriIpt,NGates]=NetlistParse(pg)
% clc;
% clear;

ci=0;  %��¼������������Ԫ�صĸ���
ui=0;  %��¼��������������Ԫ�صĸ���
k=0; %ָ��·ԭʼ����˵ĸ���
NPriIpt=0; %ͳ�Ƶ�·ԭʼ����˵ĸ���
NGates=0;  %ͳ�Ƶ�·�л����ŵĸ���
%��̬����cellԪ��a={},�������ϴ��������Ԥ�ȷ���ʹ�и��ߵļ���Ч�ʡ�
CompleteCell={};   %������������̬����
UnCompleteCell={};  %��������������̬����
PriOpt=zeros();    %�洢��·��ԭʼ����ˣ���̬����

% fidin=fopen('D:\������\c17\c17_22.txt','r');
% fidin=fopen('D:\������\c17\c17_23.txt','r');
% fidin=fopen('D:\������\c5315\c5315_4737.txt','r');
% fidin=fopen('D:\������\c5315\c5315_7015.txt','r');
% fidin=fopen('D:\������\c5315\c5315_7365.txt','r');
% fidin=fopen('D:\������\c7552\c7552_add.txt','r');
% fidin=fopen('D:\������\c3540\c3540_3195.txt','r');
% fidin=fopen('D:\������\74148\74148_78.txt','r');
% fidin=fopen('D:\������\74157\74157_40.txt','r');
% fidin=fopen('D:\������\74182\74182_63.txt','r');
% fidin=fopen('D:\������\74283\74283_101.txt','r');
% fidin=fopen('D:\������\alu4\alu4_192.txt','r');
% fidin=fopen('D:\������\c880\c880_767.txt','r');
% fidin=fopen('D:\������\74155\74155_46.txt','r');
% fidin=fopen('D:\������\74283\74283_97.txt','r');
% fidin=fopen('D:\������\alu4\alu4_191.txt','r');
% fidin=fopen('D:\������\c2670\c2670_1971.txt','r');
% fidin=fopen('D:\������\c2670\c2670_2891.txt','r');
% fidin=fopen('D:\������\c3540\c3540_3987.txt','r');
% fidin=fopen('D:\������\c7552_add.txt','r');
% fidin=fopen('D:\������\c7552\c7552_10112.txt','r');
% fidin=fopen('D:\������\c432\c432_223.txt','r');
fidin=fopen('D:\������\c432\c432_329.txt','r');
% fidin=fopen('D:\������\c6288\c6288_2223.txt','r');
% fidin=fopen('D:\������\c499\c499_753.txt','r');

while(~feof(fidin))     %�ж��Ƿ��ļ���β
    tline=fgetl(fidin);   %���ж�ȡ�ļ�
    tline=strtrim(tline);    %ȥ��tline��β�Ķ���ո�
    if(strcmp(tline(1),'*')==1)   %�ж��ļ��ĵ�һ���ַ�
        continue;
    else
        tline=strtrim(tline);    %ȥ��tline��β�Ķ���ո�
        TempCell=regexpi(tline,'\s+','split');         %�����ַ����ķָ�ո�Ϊ�磩����Сд������
    end
    
    %��Ҫע����洢����˺ŵ���
    if(strcmp(TempCell(1,3),'inpt')==1||strcmp(TempCell(1,3),'INPT')==1)
        [CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,NPriIpt,fidin]=GetInpt(TempCell,CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,NPriIpt,fidin); %��ȡ��·��Ԫ�����롢�������������Ϣ
    elseif(strcmp(TempCell(1,3),'from')==1||strcmp(TempCell(1,3),'FROM')==1)
        [CompleteCell,UnCompleteCell,ci,ui,k,fidin]=GetFrom(TempCell,CompleteCell,UnCompleteCell,ci,ui,k,fidin);
    else
        [CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,NGates,fidin]=GetBasicGates(TempCell,CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,NGates,fidin,pg);%pgָ��Ԫ�Ĺ��ϸ���
    end
end
fclose(fidin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
