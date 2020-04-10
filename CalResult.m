%计算节点关键性
function [Result]=CalResult()
    
     [CompleteCell,PriOpt,PriIpt]=NetlistParse2();
     Result={};
     m=length(CompleteCell);
        [CompleteCell,PriOpt,PriIpt]=PriOptCalResult(CompleteCell,PriOpt,PriIpt); %计算关键性，初始化节点信息
        CompleteCell=InitialLine(CompleteCell); %标识导线关键性
        CompleteCell{1,m}{1,12}=1;
        CompleteCell{1,m}{1,10}(1,1)=CompleteCell{1,m}{1,10}(1,1)+1; %更新原始输出端关键性
        [CompleteCell]=Rec(CompleteCell,m); %递归遍历
     j=1;
     for i=m:-1:1 %构造结果
        if(strcmp(CompleteCell{1,i}(1,3),'inpt')==0 && strcmp(CompleteCell{1,i}(1,3),'from')==0 && CompleteCell{1,i}{1,10}(1,1) ~= 0)
            if(strcmp(CompleteCell{1,i}(1,3),'buff')==0) %不考虑buff节点
                Result{j,1}=[str2num(CompleteCell{1,i}{1,1}),CompleteCell{1,i}{1,10}(1,1)];
                j=j+1;
            end
        end
     end
     Result=cell2mat(Result);
     Result=sortrows(Result,-2);
     
end