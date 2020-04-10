%计算电路单元的输入值，根据各输入端的输入信号与电路单元的输入端个数计算其输入值
function IptOrder=IptOrderCal(InptIDCell,IptNum)

sum=0;
% InptIDCell=[1,1];  %测试用
% IptNum=2;
for i=1:1:IptNum
    sum=sum+cell2mat(InptIDCell(1,i))*2^(IptNum-i);  %从高位到低位
end
IptOrder=sum;

end