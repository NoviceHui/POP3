%��·�������
%class(CompleteCell{1,17}{1,7}(1))���鿴��������������
function [CompleteCell,PriOpt,PriIpt]=NetlistParse2()
clc;
clear;

ci=0;  %��¼������������Ԫ�صĸ���
ui=0;  %��¼��������������Ԫ�صĸ���
k=0; %ָ��·ԭʼ����˵ĸ���
j=0; %ָ��·��ԭʼ����˸���
%��̬����cellԪ��a={},�������ϴ��������Ԥ�ȷ���ʹ�и��ߵļ���Ч�ʡ�
CompleteCell={};   %������������̬����
UnCompleteCell={};  %��������������̬����
PriOpt=zeros();    %�洢��·��ԭʼ����ˣ���̬����
PriIpt=zeros();    %�洢��·��ԭʼ����ˣ���̬����

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
% fidin=fopen('D:\������\c2670\c2670_2891.txt','r');
% fidin=fopen('D:\������\c3540\c3540_3987.txt','r');
% fidin=fopen('D:\������\c7552_add.txt','r');
% fidin=fopen('D:\������\c7552\c7552_10112.txt','r');
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
        [CompleteCell,UnCompleteCell,PriOpt,PriIpt,ci,ui,k,j,fidin]=GetInpt2(TempCell,CompleteCell,UnCompleteCell,PriOpt,PriIpt,ci,ui,k,j,fidin); %��ȡ��·��Ԫ�����롢�������������Ϣ
    elseif(strcmp(TempCell(1,3),'from')==1||strcmp(TempCell(1,3),'FROM')==1)
        [CompleteCell,UnCompleteCell,ci,ui,k,fidin]=GetFrom2(TempCell,CompleteCell,UnCompleteCell,ci,ui,k,fidin);
    else
        [CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,fidin]=GetBasicGates2(TempCell,CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,fidin);
    end
end
fclose(fidin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=length(CompleteCell);
for i=1:1:m     %�ع���ڵ�����Ԫ�飬ʹ�ڵ������д洢���������������еı��
    temp=cell2mat(CompleteCell{1,i}(1,3));  %cell2mat()��cellת����str
    IptNum=length(CompleteCell{1,i}{1,7});   %��ȡ�õ�Ԫ������˸�����ע��cell����Ƕ��cell����Ԫ�س��ȵļ��㼼��
    switch(temp)
        case {'from','FROM'}
            for j=1:1:m
                if(strcmp(CompleteCell{1,i}(1,7),CompleteCell{1,j}(1,1))==1)
                    CompleteCell{1,i}(1,7)={j};
                    break;
                end
            end
        case {'and','AND','or','OR','nand','NAND','nor','NOR','xor','XOR','xnor','XNOR','not','NOT','buff','BUFF'}
            for j=1:1:IptNum
                for k=1:1:m
                    if(strcmp(CompleteCell{1,i}{1,7}(1,j),CompleteCell{1,k}(1,1))==1)
                        CompleteCell{1,i}{1,7}{1,j}=k;
                        break;
                    end
                end
            end
        otherwise
            continue;
    end
 end   
end
