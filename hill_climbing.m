function [rnd_vect,rnd_score]=hill_climbing(rnd_vect)
global und_ins;%不确定位数
score_neighbor(und_ins,1)=0;%初始化邻居适应度值

[rnd_score]=Cal_score(rnd_vect);%求当前随机向量适应度
[neighbors]=get_neighbors(rnd_vect);%确定每代邻居向量
for i=1:und_ins
    score_neighbor(i)=Cal_score(neighbors(i,:));%求每个邻居适应度    
end

while rnd_score<max(score_neighbor)%直到所有邻居适应度都小于等于此输入向量的适应度
    max_loct=find(score_neighbor==max(score_neighbor));%定位最大值所在位置
    rnd_vect=neighbors(max_loct(1),:);%替换当前输入向量
    rnd_score=score_neighbor(max_loct(1));%替换对应适应度值
    [neighbors]=get_neighbors(rnd_vect);%以新的向量产生新的邻居
    for i=1:und_ins%计算新邻居适应度
        score_neighbor(i)=Cal_score(neighbors(i,:));%求每个邻居适应度    
    end
end




end