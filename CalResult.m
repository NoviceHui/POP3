%����ڵ�ؼ���
function [Result]=CalResult()
    
     [CompleteCell,PriOpt,PriIpt]=NetlistParse2();
     Result={};
     m=length(CompleteCell);
        [CompleteCell,PriOpt,PriIpt]=PriOptCalResult(CompleteCell,PriOpt,PriIpt); %����ؼ��ԣ���ʼ���ڵ���Ϣ
        CompleteCell=InitialLine(CompleteCell); %��ʶ���߹ؼ���
        CompleteCell{1,m}{1,12}=1;
        CompleteCell{1,m}{1,10}(1,1)=CompleteCell{1,m}{1,10}(1,1)+1; %����ԭʼ����˹ؼ���
        [CompleteCell]=Rec(CompleteCell,m); %�ݹ����
     j=1;
     for i=m:-1:1 %������
        if(strcmp(CompleteCell{1,i}(1,3),'inpt')==0 && strcmp(CompleteCell{1,i}(1,3),'from')==0 && CompleteCell{1,i}{1,10}(1,1) ~= 0)
            if(strcmp(CompleteCell{1,i}(1,3),'buff')==0) %������buff�ڵ�
                Result{j,1}=[str2num(CompleteCell{1,i}{1,1}),CompleteCell{1,i}{1,10}(1,1)];
                j=j+1;
            end
        end
     end
     Result=cell2mat(Result);
     Result=sortrows(Result,-2);
     
end