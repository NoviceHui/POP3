%�����·��Ԫ������ֵ�����ݸ�����˵������ź����·��Ԫ������˸�������������ֵ
function IptOrder=IptOrderCal(InptIDCell,IptNum)

sum=0;
% InptIDCell=[1,1];  %������
% IptNum=2;
for i=1:1:IptNum
    sum=sum+cell2mat(InptIDCell(1,i))*2^(IptNum-i);  %�Ӹ�λ����λ
end
IptOrder=sum;

end