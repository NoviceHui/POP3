function [buff_num] = Get_buff(CompleteCell)
m=length(CompleteCell);
buff_num=0;
for i=1:m                                       
     temp=cell2mat(CompleteCell{1,i}(1,3)); %cell2mat()将cell转化成str 提取电路属性
     switch(temp)
        case{'buff'}
            buff_num=buff_num+1;
     end
end



end