%递归遍历剪枝
function [CompleteCell]=Rec(CompleteCell,index)
    Ipt=CompleteCell{1,index}{1,7}; %提取该单元输入端
    IptNum=length(CompleteCell{1,index}{1,7});   %提取该单元的输入端个数，注意cell类型嵌套cell类型元素长度的计算技巧
    CompleteCell{1,index}{1,12}=1;
    for j=1:1:IptNum
        if(strcmp(CompleteCell{1,Ipt{1,j}}(1,3),'from')==1) 
            if(CompleteCell{1,index}{1,11}{1,j}==1 && strcmp(CompleteCell{1,Ipt{1,j}}(1,3),'inpt')==0)    %不计算原始输入端，屏蔽非关键导线
                if(strcmp(CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}(1,3),'inpt')==0 && CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,12}==0) %不计算原始输入端
                    if(CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,14}>=2)
                            CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)=CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)+1; %更新节点关键性
                            CompleteCell=Rec(CompleteCell,CompleteCell{1,Ipt{1,j}}{1,7}); %递归遍历
                    else
                        CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)=CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)+1; %更新节点关键性
                        CompleteCell=Rec(CompleteCell,CompleteCell{1,Ipt{1,j}}{1,7}); %递归遍历
                    end
                end
            end
        elseif(strcmp(CompleteCell{1,Ipt{1,j}}(1,3),'inpt')==1)
            continue;
        else
            if(CompleteCell{1,index}{1,11}{1,j}==1 && CompleteCell{1,Ipt{1,j}}{1,12}==0)
                if(CompleteCell{1,Ipt{1,j}}{1,14}>=2)
                        CompleteCell{1,Ipt{1,j}}{1,10}(1,1)=CompleteCell{1,Ipt{1,j}}{1,10}(1,1)+1; %更新节点关键性
                        CompleteCell=Rec(CompleteCell,Ipt{1,j}); %递归遍历
                else
                    CompleteCell{1,Ipt{1,j}}{1,10}(1,1)=CompleteCell{1,Ipt{1,j}}{1,10}(1,1)+1; %更新节点关键性
                    CompleteCell=Rec(CompleteCell,Ipt{1,j}); %递归遍历
                end
            end
        end
    end
end