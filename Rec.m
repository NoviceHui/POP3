%�ݹ������֦
function [CompleteCell]=Rec(CompleteCell,index)
    Ipt=CompleteCell{1,index}{1,7}; %��ȡ�õ�Ԫ�����
    IptNum=length(CompleteCell{1,index}{1,7});   %��ȡ�õ�Ԫ������˸�����ע��cell����Ƕ��cell����Ԫ�س��ȵļ��㼼��
    CompleteCell{1,index}{1,12}=1;
    for j=1:1:IptNum
        if(strcmp(CompleteCell{1,Ipt{1,j}}(1,3),'from')==1) 
            if(CompleteCell{1,index}{1,11}{1,j}==1 && strcmp(CompleteCell{1,Ipt{1,j}}(1,3),'inpt')==0)    %������ԭʼ����ˣ����ηǹؼ�����
                if(strcmp(CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}(1,3),'inpt')==0 && CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,12}==0) %������ԭʼ�����
                    if(CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,14}>=2)
                            CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)=CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)+1; %���½ڵ�ؼ���
                            CompleteCell=Rec(CompleteCell,CompleteCell{1,Ipt{1,j}}{1,7}); %�ݹ����
                    else
                        CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)=CompleteCell{1,CompleteCell{1,Ipt{1,j}}{1,7}}{1,10}(1,1)+1; %���½ڵ�ؼ���
                        CompleteCell=Rec(CompleteCell,CompleteCell{1,Ipt{1,j}}{1,7}); %�ݹ����
                    end
                end
            end
        elseif(strcmp(CompleteCell{1,Ipt{1,j}}(1,3),'inpt')==1)
            continue;
        else
            if(CompleteCell{1,index}{1,11}{1,j}==1 && CompleteCell{1,Ipt{1,j}}{1,12}==0)
                if(CompleteCell{1,Ipt{1,j}}{1,14}>=2)
                        CompleteCell{1,Ipt{1,j}}{1,10}(1,1)=CompleteCell{1,Ipt{1,j}}{1,10}(1,1)+1; %���½ڵ�ؼ���
                        CompleteCell=Rec(CompleteCell,Ipt{1,j}); %�ݹ����
                else
                    CompleteCell{1,Ipt{1,j}}{1,10}(1,1)=CompleteCell{1,Ipt{1,j}}{1,10}(1,1)+1; %���½ڵ�ؼ���
                    CompleteCell=Rec(CompleteCell,Ipt{1,j}); %�ݹ����
                end
            end
        end
    end
end