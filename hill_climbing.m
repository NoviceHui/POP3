function [rnd_vect,rnd_score]=hill_climbing(rnd_vect)
global und_ins;%��ȷ��λ��
score_neighbor(und_ins,1)=0;%��ʼ���ھ���Ӧ��ֵ

[rnd_score]=Cal_score(rnd_vect);%��ǰ���������Ӧ��
[neighbors]=get_neighbors(rnd_vect);%ȷ��ÿ���ھ�����
for i=1:und_ins
    score_neighbor(i)=Cal_score(neighbors(i,:));%��ÿ���ھ���Ӧ��    
end

while rnd_score<max(score_neighbor)%ֱ�������ھ���Ӧ�ȶ�С�ڵ��ڴ�������������Ӧ��
    max_loct=find(score_neighbor==max(score_neighbor));%��λ���ֵ����λ��
    rnd_vect=neighbors(max_loct(1),:);%�滻��ǰ��������
    rnd_score=score_neighbor(max_loct(1));%�滻��Ӧ��Ӧ��ֵ
    [neighbors]=get_neighbors(rnd_vect);%���µ����������µ��ھ�
    for i=1:und_ins%�������ھ���Ӧ��
        score_neighbor(i)=Cal_score(neighbors(i,:));%��ÿ���ھ���Ӧ��    
    end
end




end