function [] = get_input()
global num_input;
pg=0.01;
[UnCompleteCell]=NetlistParse(pg);
m=length(UnCompleteCell);
% inputsum = 0;
num_input=[];
for i=1:1:m
    temp=cell2mat(UnCompleteCell{1,i}(1,5));  %cell2mat()将cell转化成str
    switch(temp)
         case {'0'}
%             inputsum = inputsum+1;
            num_input=[num_input,i];
    end

end
% disp(inputsum)
end