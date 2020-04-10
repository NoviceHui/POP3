%构建电路的原始输入向量分布
function [PriIpt1,PriIpt2]=PriIptVector()
global cand_list;
global l;
global k;
PriIpt1(1,l)=0;
PriIpt2=cand_list(k,:);
for i=1:l
    if cand_list(k,i)==1
        PriIpt1(i)=0;
    else
        PriIpt1(i)=1;
    end
end

end