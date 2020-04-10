%若f=0，用完整性链表中第i个门当前信号计算正确输出；若f=1，用理想信号计算,计算完整性链表中第i个门在index输入错误的情况下门的输出
function R=GateFunc(CompleteCell,i,index,f)
    temp=cell2mat(CompleteCell{1,i}(1,3));  %cell2mat()将cell转化成str
    IptNum=length(CompleteCell{1,i}{1,7});   %提取该单元的输入端个数，注意cell类型嵌套cell类型元素长度的计算技巧
    if(f==1)
        if(strcmp(temp,'and')==1||strcmp(temp,'AND')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,index}}{1,9}(1,2);
            for j=1:1:IptNum
                if(j~=index)
                    R=R&CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,9}(1,2);
                end
            end
        elseif(strcmp(temp,'or')==1||strcmp(temp,'OR')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,index}}{1,9}(1,2);
            for j=1:1:IptNum
                if(j~=index)
                    R=R|CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,9}(1,2);
                end
            end
        elseif(strcmp(temp,'nand')==1||strcmp(temp,'NAND')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,index}}{1,9}(1,2);
            for j=1:1:IptNum
                if(j~=index)
                    R=R&CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,9}(1,2);
                end
            end
            R=~R;
        elseif(strcmp(temp,'nor')==1||strcmp(temp,'NOR')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,index}}{1,9}(1,2);
            for j=1:1:IptNum
                if(j~=index)
                    R=R|CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,9}(1,2);
                end
            end
            R=~R;
        elseif(strcmp(temp,'xor')==1||strcmp(temp,'XOR')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,index}}{1,9}(1,2);
            for j=1:1:IptNum
                if(j~=index)
                    R=xor(R,CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,9}(1,2));
                end
            end
        elseif(strcmp(temp,'xnor')==1||strcmp(temp,'XNOR')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,index}}{1,9}(1,2);
            for j=1:1:IptNum
                if(j~=index)
                    R=xor(R,CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,9}(1,2));
                end
            end
            R=~R;
        elseif(strcmp(temp,'not')==1||strcmp(temp,'NOT')==1)
            R=CompleteCell{1,CompleteCell{1,i}{1,7}{1,1}}{1,9}(1,2);
        elseif(strcmp(temp,'buff')==1||strcmp(temp,'BUFF')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,1}}{1,9}(1,2);
        else
            disp('Report error');             
        end
    else
        if(strcmp(temp,'and')==1||strcmp(temp,'AND')==1)
            R=1;
            for j=1:1:IptNum
                if(j~=index)
                    R=R&CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,8}(1,2);
                end
            end
        elseif(strcmp(temp,'or')==1||strcmp(temp,'OR')==1)
            R=0;
            for j=1:1:IptNum
                if(j~=index)
                    R=R|CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,8}(1,2);
                end
            end
        elseif(strcmp(temp,'nand')==1||strcmp(temp,'NAND')==1)
            R=1;
            for j=1:1:IptNum
                if(j~=index)
                    R=R&CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,8}(1,2);
                end
            end
            R=~R;
        elseif(strcmp(temp,'nor')==1||strcmp(temp,'NOR')==1)
            R=0;
            for j=1:1:IptNum
                if(j~=index)
                    R=R|CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,8}(1,2);
                end
            end
            R=~R;
        elseif(strcmp(temp,'xor')==1||strcmp(temp,'XOR')==1)
            R=CompleteCell{1,CompleteCell{1,i}{1,7}{1,1}}{1,8}(1,2);
            for j=2:1:IptNum
                if(j~=index)
                    R=xor(R,CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,8}(1,2));
                end
            end
        elseif(strcmp(temp,'xnor')==1||strcmp(temp,'XNOR')==1)
            R=CompleteCell{1,CompleteCell{1,i}{1,7}{1,1}}{1,8}(1,2);
            for j=2:1:IptNum
                if(j~=index)
                    R=xor(R,CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,8}(1,2));
                end
            end
            R=~R;
        elseif(strcmp(temp,'not')==1||strcmp(temp,'NOT')==1)
            R=~CompleteCell{1,CompleteCell{1,i}{1,7}{1,1}}{1,8}(1,2);
        elseif(strcmp(temp,'buff')==1||strcmp(temp,'BUFF')==1)
            R=CompleteCell{1,CompleteCell{1,i}{1,7}{1,1}}{1,8}(1,2);
        else
            disp('Report error');             
        end
    end
end