function [neighbors]=get_neighbors(rnd_vect)
% global l;%输入信号个数
global WRV;%当代最差输入向量
global und_ins;%不确定位数
clear neighbors;%每次清除旧邻居
% WRV=[-1,-1,1,-1,0,-1];%测试用
% und_ins=4;
% rnd_vect=[0,0,1,1,0,0];

udefine_bit=find(WRV==-1);%返回所有不确定取值的位置序列
for i=1:und_ins%逐个对每个邻居在不确定位置上遍历修改，每次只改1个位置
    neighbors(i,:)=rnd_vect;%所有邻居初始化为此代初始输入向量
    if neighbors(i,udefine_bit(i))==0
        neighbors(i,udefine_bit(i))=1;
    else
        neighbors(i,udefine_bit(i))=0;
    end
end




end