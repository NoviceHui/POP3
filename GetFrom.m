%电路单元“from”提取
function [CompleteCell,UnCompleteCell,ci,ui,k,fidin]=GetFrom(TempCell,CompleteCell,UnCompleteCell,ci,ui,k,fidin)

%提取该单元的输入是否已知，需要先通过其输入线名匹配其输入线号
flag=0;   %用于标识输入是否已知
uflag=0;
for i=1:1:ci
   if(strcmp(CompleteCell{1,i}(1,2),TempCell(1,4))==1)
       ci=ci+1;
       CompleteCell{1,ci}(1,7)=CompleteCell{1,i}(1,1);  %提取该单元的输入端号
       flag=1;   %标识该输入已知
       break;
   end
end

%该单元的该输入端号已知
if(flag==1)
    CompleteCell{1,ci}(1,1)=TempCell(1,1);    %单元输出端的线号
    CompleteCell{1,ci}(1,2)=TempCell(1,2);   %线名
    CompleteCell{1,ci}(1,3)=cellstr('from'); %单元类型
    CompleteCell{1,ci}(1,4)=cellstr('-1'); %指单元输出端的个数，-1指不考虑
    CompleteCell{1,ci}(1,5)=TempCell(1,4); %指单元输入端的线名
    CompleteCell{1,ci}(1,6)=cellstr('-1'); %指该单元输出端的敏感性
    CompleteCell{1,ci}(1,8)=cellstr('-1'); %指该单元的理想输出信号 
    CompleteCell{1,ci}(1,9)={0}; %指该单元的故障概率
else
    %查找该单元的输入端号
    for i=1:1:ui
        if(strcmp(UnCompleteCell{1,i}(1,2),TempCell(1,4))==1)
            ui=ui+1;
            UnCompleteCell{1,ui}(1,7)=UnCompleteCell{1,i}(1,1);  %提取该单元的输入端号
            uflag=1;
            break;
        end        
    end
    
    if(uflag==0)
        ui=ui+1;
        UnCompleteCell{1,ui}(1,7)=cellstr('-1');  %提取该单元的输入端号,-1指该单元的输入端号未知
    end

    UnCompleteCell{1,ui}(1,1)=TempCell(1,1);    %单元输出端的线号
    UnCompleteCell{1,ui}(1,2)=TempCell(1,2);   %线名
    UnCompleteCell{1,ui}(1,3)=cellstr('from'); %单元类型
    UnCompleteCell{1,ui}(1,4)=cellstr('-1'); %指单元输出端的个数，-1指不考虑
    UnCompleteCell{1,ui}(1,5)=TempCell(1,4); %指单元输入端的线名
    UnCompleteCell{1,ui}(1,6)=cellstr('-1'); %指该单元的输出端的敏感性
    UnCompleteCell{1,ui}(1,8)=cellstr('-1'); %指该单元的理想输出  
    UnCompleteCell{1,ui}(1,9)={0};  %指该单元的故障概率
end

end