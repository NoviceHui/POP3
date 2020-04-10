function []=test()
 A=[];  
for i=0:(2^1-1)     
    A=[A;bitget(i,3:-1:1)]; 
end
end