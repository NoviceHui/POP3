function [remain_vect]=get_remain()
global und_ins;%��ȷ��λ��
global WRV;
global l;
remain_vect(2^und_ins,l)=0;
udefine_bit=find(WRV==-1);%�������в�ȷ��ȡֵ��λ������
A=[];  
for i=0:(2^und_ins-1)     
    A=[A;bitget(i,und_ins:-1:1)]; %�������п��ܵ�2�������
end

for i=1:2^und_ins
    remain_vect(i,:)=WRV;
    for j=1:und_ins
        remain_vect(i,udefine_bit(j))=A(i,j);%��2������ϲ���δȷ��λ
    end
end

end