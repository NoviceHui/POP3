%电路各单元的输出
function [CompleteCell,PriOpt,PriIpt]=PriOptCalResult(CompleteCell,PriOpt,PriIpt)
%[CompleteCell,PriOpt,PriIpt]=NetlistParse();
pg=0.05;   %测试用
m=length(CompleteCell);
TempIpt={};
TempIIpt={};
[PriIpt1,PriIpt2]=PriIptVector();  %电路的原始输入端向量
ni=0;  %循环变量，用于提取电路的原始输入端

for i=1:1:m
    temp=cell2mat(CompleteCell{1,i}(1,3));  %cell2mat()将cell转化成str
    IptNum=length(CompleteCell{1,i}{1,7});   %提取该单元的输入端个数，注意cell类型嵌套cell类型元素长度的计算技巧
    switch(temp)
        case {'inpt','INPT'}
            ni=ni+1;
            CompleteCell{1,i}(1,8)={[PriIpt1(ni),PriIpt2(ni)]};  %该单元输出端的信号值
            CompleteCell{1,i}(1,9)={[PriIpt1(ni),PriIpt2(ni)]};  %该单元输出端的理想信号值
        case {'from','FROM'}
            CompleteCell{1,i}(1,8)=CompleteCell{1,CompleteCell{1,i}{1,7}}(1,8);
            CompleteCell{1,i}(1,9)=CompleteCell{1,CompleteCell{1,i}{1,7}}(1,9);
      
        case {'and','AND','or','OR','nand','NAND','nor','NOR','xor','XOR','xnor','XNOR','not','NOT','buff','BUFF'}
            for j=1:1:IptNum  %提取各输入端的输入概率分布，并计算其输出值
                TempIpt{1,j}=CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}(1,8);
                TempIIpt{1,j}=CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}(1,9);
            end
  
            [gPM,gIM]=PTMGateITM(IptNum);    %计算该单元的输出
            GIpt=cell2mat(TempIpt{1,1});
            GIIpt=cell2mat(TempIIpt{1,1});
            for j=2:1:IptNum
                GIpt=kron(GIpt,cell2mat(TempIpt{1,j}));  %单元的输入概率分布
                GIIpt=kron(GIIpt,cell2mat(TempIIpt{1,j})); %单元的理想输入概率分布
            end
            if(strcmp(temp,'and')==1||strcmp(temp,'AND')==1)
                PTM=gPM{1,1};
                ITM=gIM{1,1};
            elseif(strcmp(temp,'or')==1||strcmp(temp,'OR')==1)
                PTM=gPM{1,2};
                ITM=gIM{1,2};
            elseif(strcmp(temp,'nand')==1||strcmp(temp,'NAND')==1)
                PTM=gPM{1,3};
                ITM=gIM{1,3};
            elseif(strcmp(temp,'nor')==1||strcmp(temp,'NOR')==1)
                PTM=gPM{1,4};
                ITM=gIM{1,4};
            elseif(strcmp(temp,'xor')==1||strcmp(temp,'XOR')==1)
                PTM=gPM{1,5};
                ITM=gIM{1,5};
            elseif(strcmp(temp,'xnor')==1||strcmp(temp,'XNOR')==1)
                PTM=gPM{1,6};
                ITM=gIM{1,6};
            elseif(strcmp(temp,'not')==1||strcmp(temp,'NOT')==1)
                PTM=gPM{1,7};
                ITM=gIM{1,7};
            elseif(strcmp(temp,'buff')==1||strcmp(temp,'BUFF')==1)
                PTM=gPM{1,8};
                ITM=gIM{1,8};
            else
                disp('Report error');             
            end
            CompleteCell{1,i}(1,8)={GIpt*PTM};  %单元的输出概率分布，将元素转化成cell类型的技巧
            CompleteCell{1,i}(1,9)={GIIpt*ITM};  %单元的理想输出概率分布3
            if(strcmp(CompleteCell{1,i}(1,3),'inpt')==0 && strcmp(CompleteCell{1,i}(1,3),'from')==0)  %提取电路的原始输出概率分布
                CompleteCell{1,i}{1,10}(1,2)=1-sum(cell2mat(CompleteCell{1,i}(1,8)).*cell2mat(CompleteCell{1,i}(1,9)));
            end
        otherwise
            continue;
    end
%     %%测试用，分别用于输出电路中各输出端的故障情况与理想情况下的输出
%     CompleteCell{1,i}(1,3)
%     cell2mat(CompleteCell{1,i}(1,8))
%     cell2mat(CompleteCell{1,i}(1,9))
end

end