%指信号发生器
function PriSig=SigalGenerator(vector,i)

global num_input;
ii=find(num_input==i);

if( vector(ii)==0 )
    PriSig=0;
else
    PriSig=1;
end

%disp(PriSig);
end