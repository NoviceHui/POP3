%��ʼ�����ߵĹؼ���
function CompleteCell=InitialLine(CompleteCell)
    m=length(CompleteCell);
    for i=1:1:m
        if(strcmp(CompleteCell{1,i}(1,3),'inpt')==0 && strcmp(CompleteCell{1,i}(1,3),'from')==0)
            CompleteCell{1,i}{1,14}=0;
        end
    end
	for i=1:1:m
        if(strcmp(CompleteCell{1,i}(1,3),'inpt')==0 && strcmp(CompleteCell{1,i}(1,3),'from')==0)
            IptNum=length(CompleteCell{1,i}{1,7});   %��ȡ�õ�Ԫ������˸�����ע��cell����Ƕ��cell����Ԫ�س��ȵļ��㼼��
            for j=1:1:IptNum
                temp=GateFunc(CompleteCell,i,j,1); %���㵥���������ʱ��Ӧ��������ź�
                if(temp==CompleteCell{1,i}{1,9}(1,2)) %����������źűȽ�
                    CompleteCell{1,i}{1,11}{1,j}=0;
                else
                    CompleteCell{1,i}{1,11}{1,j}=1;
                    if(strcmp(CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,3},'from')==1)
                        if(strcmp(CompleteCell{1,CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,7}}{1,3},'inpt')==0)
                            CompleteCell{1,CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,7}}{1,14}=CompleteCell{1,CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,7}}{1,14}+1;
                        end
                    elseif(strcmp(CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,3},'inpt')==1)
                        
                    else
                        CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,14}=CompleteCell{1,CompleteCell{1,i}{1,7}{1,j}}{1,14}+1;
                    end
                end
            end
        end
    end
%     for i=1:1:m
%         if(strcmp(CompleteCell{1,i}(1,3),'from')==1)
%             if(CompleteCell{1,i}{1,10}==1)
%                 CompleteCell{1,CompleteCell{1,i}{1,4}}{1,14}=CompleteCell{1,CompleteCell{1,i}{1,4}}{1,14}+1;
%             end
%         end
%     end
end