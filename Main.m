function []=Main()
global m;%ÿ�����������������������
global l;%�����źŸ���
global WRV;%�����������
global und_ins;%��ȷ��λ��
global cand_list;%��ѡ���������б�
global cand_scores;%��ѡ���������÷�
global WRV_CS;%������������÷�
global n;%��ѡ���������ĸ���
global tr;%��һ������ֵ
global th;%��ʼ��ʶ��ֵ
global th_min;%��С��ʶ��ֵ
k=0;%�㷨�����ж�����֮һ

%��һ����
while und_ins >= tr %��һ���ֽ�������
    pre_und_ins=und_ins;%�ȱ����ʼund_insֵ�����Ƚ�Ҫ��
    %�㷨���壺
    for j=1:m
        rnd_vect=WRV;%���������������

        for i=1:l  %�����в�ȷ��λ�������0��1
            if rnd_vect(i)==-1%��λ���Բ�ȷ������ȡֵ
                if rand<0.5
                    rnd_vect(i)=1;
                else
                    rnd_vect(i)=0;
                end 
            end
        end

        [rnd_vect,rnd_score]=hill_climbing(rnd_vect);%������ɽ�㷨�������õ��Ľ���������������÷�

        if rnd_score>min(cand_scores)%���Ľ���������÷ָ��ں�ѡ�б��е���ͷ�
            min_loca=find(cand_scores==min(cand_scores));%��λ��Сֵ����λ��
            cand_list(min_loca(1),:)=rnd_vect;%�滻��ǰ��������
            cand_scores(min_loca(1),1)=rnd_score;%�滻��Ӧ��Ӧ��ֵ
        end

        if rnd_score>WRV_CS%������������÷�
            WRV_CS=rnd_score;
        end
    end

    %������m���Ľ�������������ѡ�б���бȽ�֮��:
    OS(1:l)=0;%��ʼ��
    ZS(1:l)=0;%��ʼ��
    C(1:l)=0;%��ʼ��
    for i=1:l
        for j=1:n%ͳ�ƺ�ѡ�б����л���λȡ0��1�ĵ÷��ܺ�
            if cand_list(j,i)==1
                OS(i)=OS(i)+cand_scores(j);
            else
                ZS(i)=ZS(i)+cand_scores(j);
            end
        end
        %���º�ѡ�б��һ����,ͬʱ����und_insֵ
        if OS(i)/(OS(i)+ZS(i)) >= th
            C(i)=1;
            WRV(i)=C(i);%���ݺ�ѡ��һ���Ը���WRV��һλȷ��ȡ1
%             und_ins=und_ins-1;%����δȷ��λ�ĸ�������ʼֵΪL�����Եݼ�
        elseif ZS(i)/(OS(i)+ZS(i)) >= th
            C(i)=0;
            WRV(i)=C(i);%���ݺ�ѡ��һ���Ը���WRV��һλȷ��ȡ0
%             und_ins=und_ins-1;%����δȷ��λ�ĸ�������ʼֵΪL�����Եݼ�
        else
            C(i)=-1;
            WRV(i)=C(i);%���ݺ�ѡ��һ���Ը���WRV��һλ��Ȼ��ȷ������ȡ-1      
        end
    end
    
    und_ins=size(find(WRV==-1),2);%����δȷ��λ�ĸ���
    
    if und_ins==pre_und_ins%��һ�׶κ������ռ�û�仯��ͳ�ƴ�������������㷨Ҫ��
        k=k+1;
    else
        k=0;
    end
    
    if und_ins<pre_und_ins%����һ�׶κ������ռ��С�����ص�һ������
         %Ĭ�ϻص���һ��
    elseif th>th_min%û��С����΢���͹�ʶ��ֵ
        th=th-0.01;
    elseif k==10%����һ������ûЧ����������һ��
        break;
    else
    end
end

%�ڶ����֣���������������������ִ��˳������

if und_ins < tr %������Դ�����˳��������һ����
    [remain_vect]=get_remain();%����2^und_ins����������
    for i=1:2^und_ins
        remain_score=Cal_score(remain_vect(i,:));%����ʣ��2^und_ins������������ط���
        if remain_score>WRV_CS %����WRV��WRV_CS
            WRV_CS=remain_score;
            WRV=remain_vect(i,:);
        end
    end
    
else%��˳������ڶ�����
    
    [remain_vect]=get_remain2();%����2^tr����������
    for i=1:2^tr
        remain_score=Cal_score(remain_vect(i,:));%����ʣ��2^tr������������ط���
        if remain_score>WRV_CS %����WRV��WRV_CS
            WRV_CS=remain_score;
            WRV=remain_vect(i,:);
        end
    end

end

%���շ���ȫ�ֱ���WRV��WRV_CS   
end
