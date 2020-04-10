function [remain_vect]=get_remain()
global und_ins;%不确定位数
global WRV;
global l;
remain_vect(2^und_ins,l)=0;
udefine_bit=find(WRV==-1);%返回所有不确定取值的位置序列
A=[];  
for i=0:(2^und_ins-1)     
    A=[A;bitget(i,und_ins:-1:1)]; %产生所有可能的2进制组合
end

for i=1:2^und_ins
    remain_vect(i,:)=WRV;
    for j=1:und_ins
        remain_vect(i,udefine_bit(j))=A(i,j);%将2进制组合插入未确定位
    end
end

end