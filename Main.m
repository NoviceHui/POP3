function []=Main()
global m;%每代产生的随机输入向量个数
global l;%输入信号个数
global WRV;%最差输入向量
global und_ins;%不确定位数
global cand_list;%待选输入向量列表
global cand_scores;%待选输入向量得分
global WRV_CS;%最差输入向量得分
global n;%待选输入向量的个数
global tr;%第一部分阈值
global th;%初始共识阈值
global th_min;%最小共识阈值
k=0;%算法结束判断条件之一

%第一部分
while und_ins >= tr %第一部分结束条件
    pre_und_ins=und_ins;%先保存初始und_ins值，最后比较要用
    %算法主体：
    for j=1:m
        rnd_vect=WRV;%当代随机输入向量

        for i=1:l  %对所有不确定位置随机赋0或1
            if rnd_vect(i)==-1%该位置仍不确定具体取值
                if rand<0.5
                    rnd_vect(i)=1;
                else
                    rnd_vect(i)=0;
                end 
            end
        end

        [rnd_vect,rnd_score]=hill_climbing(rnd_vect);%利用爬山算法进化，得到改进的输入向量和其得分

        if rnd_score>min(cand_scores)%若改进后的向量得分高于候选列表中的最低分
            min_loca=find(cand_scores==min(cand_scores));%定位最小值所在位置
            cand_list(min_loca(1),:)=rnd_vect;%替换当前输入向量
            cand_scores(min_loca(1),1)=rnd_score;%替换对应适应度值
        end

        if rnd_score>WRV_CS%更新最差向量得分
            WRV_CS=rnd_score;
        end
    end

    %将所有m个改进的随机向量与候选列表进行比较之后:
    OS(1:l)=0;%初始化
    ZS(1:l)=0;%初始化
    C(1:l)=0;%初始化
    for i=1:l
        for j=1:n%统计候选列表所有基因位取0或1的得分总和
            if cand_list(j,i)==1
                OS(i)=OS(i)+cand_scores(j);
            else
                ZS(i)=ZS(i)+cand_scores(j);
            end
        end
        %更新候选列表的一致性,同时更新und_ins值
        if OS(i)/(OS(i)+ZS(i)) >= th
            C(i)=1;
            WRV(i)=C(i);%根据候选表一致性更新WRV这一位确定取1
%             und_ins=und_ins-1;%更新未确定位的个数，初始值为L，所以递减
        elseif ZS(i)/(OS(i)+ZS(i)) >= th
            C(i)=0;
            WRV(i)=C(i);%根据候选表一致性更新WRV这一位确定取0
%             und_ins=und_ins-1;%更新未确定位的个数，初始值为L，所以递减
        else
            C(i)=-1;
            WRV(i)=C(i);%根据候选表一致性更新WRV这一位仍然不确定，暂取-1      
        end
    end
    
    und_ins=size(find(WRV==-1),2);%更新未确定位的个数
    
    if und_ins==pre_und_ins%第一阶段后搜索空间没变化，统计次数，后面结束算法要用
        k=k+1;
    else
        k=0;
    end
    
    if und_ins<pre_und_ins%若第一阶段后搜索空间减小，返回第一步继续
         %默认回到第一步
    elseif th>th_min%没减小，略微降低共识阈值
        th=th-0.01;
    elseif k==10%连续一定次数没效果，跳出第一步
        break;
    else
    end
end

%第二部分：对有限数量的输入向量执行顺序搜索

if und_ins < tr %如果是以此条件顺利结束第一步的
    [remain_vect]=get_remain();%产生2^und_ins个输入向量
    for i=1:2^und_ins
        remain_score=Cal_score(remain_vect(i,:));%计算剩余2^und_ins个输入向量相关分数
        if remain_score>WRV_CS %更新WRV和WRV_CS
            WRV_CS=remain_score;
            WRV=remain_vect(i,:);
        end
    end
    
else%非顺利进入第二步的
    
    [remain_vect]=get_remain2();%产生2^tr个输入向量
    for i=1:2^tr
        remain_score=Cal_score(remain_vect(i,:));%计算剩余2^tr个输入向量相关分数
        if remain_score>WRV_CS %更新WRV和WRV_CS
            WRV_CS=remain_score;
            WRV=remain_vect(i,:);
        end
    end

end

%最终返回全局变量WRV和WRV_CS   
end
