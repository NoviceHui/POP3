%电路网表解析
%class(CompleteCell{1,17}{1,7}(1))：查看变量的数据类型
function [CompleteCell,PriOpt,PriIpt]=NetlistParse2()
clc;
clear;

ci=0;  %记录完整性链表中元素的个数
ui=0;  %记录非完整性链表中元素的个数
k=0; %指电路原始输出端的个数
j=0; %指电路的原始输入端个数
%动态创建cell元组a={},但开销较大。所以最好预先分配使有更高的计算效率。
CompleteCell={};   %完整性链表，动态创建
UnCompleteCell={};  %非完整性链表，动态创建
PriOpt=zeros();    %存储电路的原始输出端，动态创建
PriIpt=zeros();    %存储电路的原始输入端，动态创建

% fidin=fopen('D:\子网表\c17\c17_22.txt','r');
% fidin=fopen('D:\子网表\c17\c17_23.txt','r');
% fidin=fopen('D:\子网表\c5315\c5315_4737.txt','r');
% fidin=fopen('D:\子网表\c5315\c5315_7015.txt','r');
% fidin=fopen('D:\子网表\c5315\c5315_7365.txt','r');
% fidin=fopen('D:\子网表\c7552\c7552_add.txt','r');
% fidin=fopen('D:\子网表\c3540\c3540_3195.txt','r');
% fidin=fopen('D:\子网表\74148\74148_78.txt','r');
% fidin=fopen('D:\子网表\74157\74157_40.txt','r');
% fidin=fopen('D:\子网表\74182\74182_63.txt','r');
% fidin=fopen('D:\子网表\74283\74283_101.txt','r');
% fidin=fopen('D:\子网表\alu4\alu4_192.txt','r');
% fidin=fopen('D:\子网表\c880\c880_767.txt','r');
% fidin=fopen('D:\子网表\74155\74155_46.txt','r');
% fidin=fopen('D:\子网表\74283\74283_97.txt','r');
% fidin=fopen('D:\子网表\alu4\alu4_191.txt','r');
% fidin=fopen('D:\子网表\c2670\c2670_2891.txt','r');
% fidin=fopen('D:\子网表\c3540\c3540_3987.txt','r');
% fidin=fopen('D:\子网表\c7552_add.txt','r');
% fidin=fopen('D:\子网表\c7552\c7552_10112.txt','r');
fidin=fopen('D:\子网表\c432\c432_329.txt','r');
% fidin=fopen('D:\子网表\c6288\c6288_2223.txt','r');
% fidin=fopen('D:\子网表\c499\c499_753.txt','r');


while(~feof(fidin))     %判断是否文件结尾
    tline=fgetl(fidin);   %按行读取文件
    tline=strtrim(tline);    %去掉tline首尾的多余空格
    if(strcmp(tline(1),'*')==1)   %判断文件的第一个字符
        continue;
    else
        tline=strtrim(tline);    %去掉tline首尾的多余空格
        TempCell=regexpi(tline,'\s+','split');         %行中字符串的分割（空格为界），大小写不敏感
    end
    
    %需要注意仅存储输入端号的行
    if(strcmp(TempCell(1,3),'inpt')==1||strcmp(TempCell(1,3),'INPT')==1)
        [CompleteCell,UnCompleteCell,PriOpt,PriIpt,ci,ui,k,j,fidin]=GetInpt2(TempCell,CompleteCell,UnCompleteCell,PriOpt,PriIpt,ci,ui,k,j,fidin); %提取电路单元的输入、类型与输出等信息
    elseif(strcmp(TempCell(1,3),'from')==1||strcmp(TempCell(1,3),'FROM')==1)
        [CompleteCell,UnCompleteCell,ci,ui,k,fidin]=GetFrom2(TempCell,CompleteCell,UnCompleteCell,ci,ui,k,fidin);
    else
        [CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,fidin]=GetBasicGates2(TempCell,CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,fidin);
    end
end
fclose(fidin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=length(CompleteCell);
for i=1:1:m     %重构造节点输入元组，使节点输入中存储的是完整性链表中的标号
    temp=cell2mat(CompleteCell{1,i}(1,3));  %cell2mat()将cell转化成str
    IptNum=length(CompleteCell{1,i}{1,7});   %提取该单元的输入端个数，注意cell类型嵌套cell类型元素长度的计算技巧
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
