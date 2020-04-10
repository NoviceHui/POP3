%电路单元“nand”提取
function [CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,fidin]=GetBasicGates2(TempCell,CompleteCell,UnCompleteCell,PriOpt,ci,ui,k,fidin)

%判断单元的各输入端是否已知
if(strcmp(TempCell(1,5),'0')==0)
    TempUp=TempCell;
    tm=str2double(cell2mat(TempUp(1,5))); %该单元原始输入端的个数，cell2mat()将cell型转化成字符型
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
        UnCompleteCell{1,ui}(1,6)=cellstr('0'); %指该单元的输出信号未知
        UnCompleteCell{1,ui}(1,7)={TempCell};    %该单元的所有输入端号
        UnCompleteCell{1,ui}(1,8)={[0,1]}; %指该单元输出端所对应的信号概率
        UnCompleteCell{1,ui}(1,9)={[0,0]}; %指该单元输出端所对应的理想信号概率
        UnCompleteCell{1,ui}(1,10)={[0,0]}; %第一个参数为总关键值，第二个参数为当前输入下关键值
        UnCompleteCell{1,ui}(1,11)={TempCell};    %该单元的所有输入端关键性
        UnCompleteCell{1,ui}(1,12)={0}; %是否被剪枝，0表示被剪枝
        UnCompleteCell{1,ui}(1,13)={[0,0]}; %检测门再收敛时临时存储信号
        UnCompleteCell{1,ui}(1,14)={0}; %关键扇出边的条数
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
        CompleteCell{1,ci}(1,6)=cellstr('1'); %指该单元的输出信号已知
        %提取输入端的线号       
        CompleteCell{1,ci}(1,7)={TempCell}; %该单元的所有输入端号，这种赋值方法表示元素是cell
        CompleteCell{1,ci}(1,8)={[0,1]}; %指该单元输出端所对应的信号概率
        CompleteCell{1,ci}(1,9)={[0,0]}; %指该单元输出端所对应的理想信号概率
        CompleteCell{1,ci}(1,10)={[0,0]}; %第一个参数为总关键值，第二个参数为当前输入下关键值
        CompleteCell{1,ci}(1,11)={TempCell};    %该单元的所有输入端关键性
        CompleteCell{1,ci}(1,12)={0}; %是否被剪枝，0表示被剪枝
        CompleteCell{1,ci}(1,13)={[0,0]}; %检测门再收敛时临时存储信号
        CompleteCell{1,ci}(1,14)={0}; %关键扇出边的条数
    end
end

end