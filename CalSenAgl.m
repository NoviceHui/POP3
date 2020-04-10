%��������������Լ��㷽��
function [SR,PriIpt]=CalSenAgl(vector)

clc;
% clear;

pg=0.01; %ָ��Ԫ�Ĺ��ϸ���
%�������
[CompleteCell,PriOpt,NPriIpt,NGates]=NetlistParse(pg);
% whos CompleteCell;   %��ȡ�ڴ濪��
cm=length(CompleteCell);  %��������������ĳ���
InptCell={};  %��Ԫ������˵�������ֵ
% SenInpt={};  %��Ԫ������������˺�
InptIDCell={}; %��Ԫ������˵���������
inpt={}; %�洢ָ�������ȡ��������ֵ
h=0;  %ͳ��ԭʼ����˵ĸ���
SR=[];  %�洢ԭʼ����˵�������
ii=0;  %����ͳ��ԭʼ���������ĸ���
PriIpt=[];

%������������������еĵ�Ԫ
for i=1:1:cm
   Temp=cell2mat(CompleteCell{1,i}(1,3));  %��ȡ��Ԫ����
   IptNum=length(CompleteCell{1,i}{1,7});  %����ȡ��Ԫ������˸���
   switch(Temp)
       case {'inpt','INPT'}    %����ԭʼ�����źš����������Ե�
           if(strcmp(CompleteCell{1,i}(1,6),'-1')==1)  %�жϸõ�Ԫ������������Ƿ���֪
               CompleteCell{1,i}(1,6)={0};  %ָ�õ�Ԫ����˵�������
               PriSig=SigalGenerator(vector,i);      %�źŷ�����
               ii=ii+1;
               PriIpt(ii)=PriSig;  %�洢��·��ԭʼ�����ź�
               CompleteCell{1,i}(1,8)={PriSig};   %��Ԫ���������       
           end
       case {'from','FROM'}    %��ȡ��from������˵����ֵ��ע��from������Ӧ�����Ѿ��õ�����ֵ
           for j=1:1:i-1
               if(strcmp(CompleteCell{1,i}(1,7),CompleteCell{1,j}(1,1))==1)
                   CompleteCell{1,i}(1,6)=CompleteCell{1,j}(1,6);  %��ȡ�õ�Ԫ����˵�������
                   CompleteCell{1,i}(1,8)=CompleteCell{1,j}(1,8);  %��ȡ�õ�Ԫ����˵��������
                   break;
               end
           end
       case {'and','AND','or','OR','nand','NAND','nor','NOR','xor','XOR','xnor','XNOR','not','NOT','buff','BUFF'}
           for k=1:1:IptNum    %�������õ�Ԫ�������,���жϸõ�Ԫ�������������         
               for j=1:1:i-1   %���Ҹ�����˸���ֵ����Դ
                   if(strcmp(CompleteCell{1,i}{1,7}(1,k),CompleteCell{1,j}(1,1))==1)
                       InptIDCell(1,k)=CompleteCell{1,j}(1,8);   %��ȡ������˵�����ֵ
                       InptCell(1,k)=CompleteCell{1,j}(1,6);    %��ȡ�õ�Ԫ����˵�������ֵ
                       break;
                   end
               end
           end
           
           IptOrder=IptOrderCal(InptIDCell,IptNum); %��ȡ�õ�Ԫ���������
           CompleteCell{1,i}(1,8)={GateITM(Temp,IptOrder,IptNum)};  %��ȡ�õ�Ԫ���������

           Sen=0;   %��Ԫ�����������
           for k=1:1:IptNum     %�жϸ�����˵�������
               for j=1:1:IptNum
                   if(k==j)
                       inpt(1,j)={~cell2mat(InptIDCell(1,j))};  %����Ԫ��ָ�������ֵȡ��
                   else
                       inpt(1,j)=InptIDCell(1,j);  %������ص�����ԭ����ֵ
                   end
               end
               IptOrder=IptOrderCal(inpt,IptNum); %���»�ȡ�õ�Ԫ���������
               oupt={GateITM(Temp,IptOrder,IptNum)};    %���¼����ڸ������µ����

               if(isequal(CompleteCell{1,i}(1,8),oupt))   %�ж�ָ�������k�Ƿ����������
                   InptCell(1,k)={0};   %ָ�������Ϊ�������������
               end  
               
               Sen=Sen+cell2mat(InptCell(1,k));  %��ȡ�õ�Ԫ������������˵�������             
           end
           Sen=Sen+cell2mat(CompleteCell{1,i}(1,9));   %����õ�Ԫ����˵�������

           CompleteCell{1,i}(1,6)={Sen};
           if(strcmp(CompleteCell{1,i}(1,4),'0')==1)  %��ȡԭʼ����˵�������
               h=h+1;
               SR(h)=cell2mat(CompleteCell{1,i}(1,6));
           end  
       otherwise
           disp('XiaoJie');
           continue;
   end  
% CompleteCell{1,i}(1,8);  %������ 
end

end