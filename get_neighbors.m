function [neighbors]=get_neighbors(rnd_vect)
% global l;%�����źŸ���
global WRV;%���������������
global und_ins;%��ȷ��λ��
clear neighbors;%ÿ��������ھ�
% WRV=[-1,-1,1,-1,0,-1];%������
% und_ins=4;
% rnd_vect=[0,0,1,1,0,0];

udefine_bit=find(WRV==-1);%�������в�ȷ��ȡֵ��λ������
for i=1:und_ins%�����ÿ���ھ��ڲ�ȷ��λ���ϱ����޸ģ�ÿ��ֻ��1��λ��
    neighbors(i,:)=rnd_vect;%�����ھӳ�ʼ��Ϊ�˴���ʼ��������
    if neighbors(i,udefine_bit(i))==0
        neighbors(i,udefine_bit(i))=1;
    else
        neighbors(i,udefine_bit(i))=0;
    end
end




end