%替代方案的敏感性计算方法
function [SR,PriIpt]=CalSenAgl(vector)

clc;
% clear;

pg=0.01; %指单元的故障概率
%网表解析
[CompleteCell,PriOpt,NPriIpt,NGates]=NetlistParse(pg);
% whos CompleteCell;   %提取内存开销
cm=length(CompleteCell);  %计算完整性链表的长度
InptCell={};  %单元各输入端的敏感性值
% SenInpt={};  %单元的敏感性输入端号
InptIDCell={}; %单元各输入端的理想输入
inpt={}; %存储指定输入端取反的输入值
h=0;  %统计原始输出端的个数
SR=[];  %存储原始输出端的敏感性
ii=0;  %用于统计原始输入向量的个数
PriIpt=[];

%逐个处理完整性链表中的单元
for i=1:1:cm
   Temp=cell2mat(CompleteCell{1,i}(1,3));  %提取单元类型
   IptNum=length(CompleteCell{1,i}{1,7});  %所提取单元的输入端个数
   switch(Temp)
       case {'inpt','INPT'}    %产生原始输入信号、输入敏感性等
           if(strcmp(CompleteCell{1,i}(1,6),'-1')==1)  %判断该单元的输出敏感性是否已知
               CompleteCell{1,i}(1,6)={0};  %指该单元输出端的敏感性
               PriSig=SigalGenerator(vector,i);      %信号发生器
               ii=ii+1;
               PriIpt(ii)=PriSig;  %存储电路的原始输入信号
               CompleteCell{1,i}(1,8)={PriSig};   %单元的理想输出       
           end
       case {'from','FROM'}    %提取“from”输出端的相关值，注意from的输入应该是已经得到了新值
           for j=1:1:i-1
               if(strcmp(CompleteCell{1,i}(1,7),CompleteCell{1,j}(1,1))==1)
                   CompleteCell{1,i}(1,6)=CompleteCell{1,j}(1,6);  %获取该单元输出端的敏感性
                   CompleteCell{1,i}(1,8)=CompleteCell{1,j}(1,8);  %获取该单元输出端的理想输出
                   break;
               end
           end
       case {'and','AND','or','OR','nand','NAND','nor','NOR','xor','XOR','xnor','XNOR','not','NOT','buff','BUFF'}
           for k=1:1:IptNum    %逐个处理该单元的输入端,并判断该单元的敏感性输入端         
               for j=1:1:i-1   %查找该输入端各类值的来源
                   if(strcmp(CompleteCell{1,i}{1,7}(1,k),CompleteCell{1,j}(1,1))==1)
                       InptIDCell(1,k)=CompleteCell{1,j}(1,8);   %获取各输入端的输入值
                       InptCell(1,k)=CompleteCell{1,j}(1,6);    %获取该单元输入端的敏感性值
                       break;
                   end
               end
           end
           
           IptOrder=IptOrderCal(InptIDCell,IptNum); %获取该单元的输入序号
           CompleteCell{1,i}(1,8)={GateITM(Temp,IptOrder,IptNum)};  %获取该单元的理想输出

           Sen=0;   %单元的输出敏感性
           for k=1:1:IptNum     %判断各输入端的敏感性
               for j=1:1:IptNum
                   if(k==j)
                       inpt(1,j)={~cell2mat(InptIDCell(1,j))};  %将单元的指定输入端值取反
                   else
                       inpt(1,j)=InptIDCell(1,j);  %将不相关的输入原样赋值
                   end
               end
               IptOrder=IptOrderCal(inpt,IptNum); %重新获取该单元的输入序号
               oupt={GateITM(Temp,IptOrder,IptNum)};    %重新计算在该输入下的输出

               if(isequal(CompleteCell{1,i}(1,8),oupt))   %判断指定输入端k是否敏感输入端
                   InptCell(1,k)={0};   %指该输入端为非敏感性输入端
               end  
               
               Sen=Sen+cell2mat(InptCell(1,k));  %提取该单元所有敏感输入端的敏感性             
           end
           Sen=Sen+cell2mat(CompleteCell{1,i}(1,9));   %计算该单元输出端的敏感性

           CompleteCell{1,i}(1,6)={Sen};
           if(strcmp(CompleteCell{1,i}(1,4),'0')==1)  %提取原始输出端的敏感性
               h=h+1;
               SR(h)=cell2mat(CompleteCell{1,i}(1,6));
           end  
       otherwise
           disp('XiaoJie');
           continue;
   end  
% CompleteCell{1,i}(1,8);  %测试用 
end

end