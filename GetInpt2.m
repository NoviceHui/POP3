%电路单元“inpt”提取
function [CompleteCell,UnCompleteCell,PriOpt,PriIpt,ci,ui,k,j,fidin]=GetInpt2(TempCell,CompleteCell,UnCompleteCell,PriOpt,PriIpt,ci,ui,k,j,fidin)

ci=ci+1;
CompleteCell{1,ci}(1,1)=TempCell(1,1);    %单元输出端的线号

%提取电路的原始输入端线号
j=j+1;
PriIpt(j)=str2double(cell2mat(CompleteCell{1,ci}(1,1)));

CompleteCell{1,ci}(1,2)=TempCell(1,2);   %线名
CompleteCell{1,ci}(1,3)=cellstr('inpt'); %单元类型,cellstr()是将字符数组转换成cell类型
CompleteCell{1,ci}(1,4)=TempCell(1,4); %指单元输出端的个数

%判断是否电路的原始输出端
if(strcmp(CompleteCell{1,ci}(1,4),'0')==1)
    k=k+1;
    PriOpt(k)=str2double(cell2mat(CompleteCell{1,ci}(1,1))); %提取输出端的线号
end
CompleteCell{1,ci}(1,5)=TempCell(1,5); %指单元输入端的个数
CompleteCell{1,ci}(1,6)=cellstr('1'); %指该单元的输出信号已知
CompleteCell{1,ci}(1,7)=TempCell(1,1); %指该单元的所有输入端号
CompleteCell{1,ci}(1,8)={[0,1]}; %指该单元输出端所对应的信号概率
CompleteCell{1,ci}(1,9)={[0,0]}; %指该单元输出端所对应的理想信号概率

end