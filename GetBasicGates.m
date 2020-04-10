%电路单元“nand”提取
function [CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,NGates,fidin]=GetBasicGates(TempCell,CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,NGates,fidin,pg)

NGates=NGates+1;%统计电路中基本门的个数
%判断单元的各输入端是否已知
if(strcmp(TempCell(1,5),'0')==0)
    TempUp=TempCell;
    tm=str2double(cell2mat(TempUp(1,5))); %该单元原始输入端的个数，cell2mat()将cell型转化成字符型或数值型
    Ipt=zeros(1,tm);
    tline=fgetl(fidin);   %按行读取文件
    tline=strtrim(tline); %去掉tline首尾的多余空格
    TempCell=regexpi(tline,'\s+','split');
    %逐个判断该单元的输入端是否已知
    for i=1:1:tm
        for j=1:1:ci    %在完整性链表中查找即可
            if(strcmp(TempCell(1,i),CompleteCell{1,j}(1,1))==1)
                Ipt(i)=1;
                break;
            end
        end
        
        if(Ipt(i)==0)   %说明该单元的输出端未知
            break;  
        end
    end
    
    tn=length(find(Ipt));  %find()返回的是非零向量，length返回的是向量的长度
    if(tn<tm)   %说明该单元有输入端的值未知,置入非完整性链表之中
        ui=ui+1;
        UnCompleteCell{1,ui}(1,1)=TempUp(1,1);    %单元输出端的线号
        UnCompleteCell{1,ui}(1,2)=TempUp(1,2);   %线名
        UnCompleteCell{1,ui}(1,3)=TempUp(1,3); %单元类型
        UnCompleteCell{1,ui}(1,4)=TempUp(1,4); %指单元输出端的个数
        if(strcmp(UnCompleteCell{1,ui}(1,4),'0')==1)
            k=k+1;
            PriOpt(k)=str2double(cell2mat(UnCompleteCell{1,ui}(1,1))); %提取输出端的线号
        end
        UnCompleteCell{1,ui}(1,5)=TempUp(1,5); %指单元输入端的个数
        UnCompleteCell{1,ui}(1,6)=cellstr('-1'); %指该单元输出端所对应的敏感性，其中‘-1’指输出敏感性未知
        UnCompleteCell{1,ui}(1,7)={TempCell};    %该单元的所有输入端号
        UnCompleteCell{1,ui}(1,8)=cellstr('-1'); %指该单元的理想输出值，‘-1’指理想输出未知
        UnCompleteCell{1,ui}(1,9)={pg}; %指该单元的故障概率
    else     %说明该单元的输入端的值均已知
        ci=ci+1;
        CompleteCell{1,ci}(1,1)=TempUp(1,1);    %单元输出端的线号
        CompleteCell{1,ci}(1,2)=TempUp(1,2);   %线名
        CompleteCell{1,ci}(1,3)=TempUp(1,3); %单元类型
        CompleteCell{1,ci}(1,4)=TempUp(1,4); %指单元输出端的个数，-1指不考虑
        if(strcmp(CompleteCell{1,ci}(1,4),'0')==1)
            k=k+1;
            PriOpt(k)=str2double(cell2mat(CompleteCell{1,ci}(1,1))); %提取输出端的线号
        end
        CompleteCell{1,ci}(1,5)=TempUp(1,5); %指单元输入端的个数
        CompleteCell{1,ci}(1,6)=cellstr('-1'); %指该单元的输出端的敏感性
        %提取输入端的线号       
        CompleteCell{1,ci}(1,7)={TempCell}; %该单元的所有输入端号，这种赋值方法表示元素是cell
        CompleteCell{1,ci}(1,8)=cellstr('-1'); %指该单元的理想输出
        CompleteCell{1,ci}(1,9)={pg}; %指该单元的故障概率
    end
end

end