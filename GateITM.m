%��ȡ��·������Ԫ���������
function Opt=GateITM(Temp,IptOrder,IptNum)

%������
% clc;
% Temp='buff';
% IptOrder=1;
% IptNum=1;
sum=0;
switch(Temp)
    case {'and','AND'}
        for i=1:1:IptNum    %and���Ϊ1�����
            sum=sum+1*2^(IptNum-i);
        end
        if(IptOrder==sum)
            Opt=1;
        else
            Opt=0;
        end
    case {'or', 'OR'}
        if(IptOrder==0)
            Opt=0;
        else
            Opt=1;
        end
    case {'not', 'NOT'}
        if(IptOrder==0)
            Opt=1;
        else
            Opt=0;
        end
    case {'nand','NAND'}
        for i=1:1:IptNum    %nand���Ϊ0�����
            sum=sum+1*2^(IptNum-i);
        end
        if(IptOrder==sum)
            Opt=0;
        else
            Opt=1;
        end
    case {'nor','NOR'}
        if(IptOrder==0)
            Opt=1;
        else
            Opt=0;
        end
    case {'xor','XOR'}
        for i=1:1:IptNum    %xor���Ϊ0�����
            sum=sum+1*2^(IptNum-i);
        end
        if(IptOrder==0||IptOrder==sum)
            Opt=0;
        else
            Opt=1;
        end
    case {'xnor','XNOR'}
        for i=1:1:IptNum    %xnor���Ϊ1�����
            sum=sum+1*2^(IptNum-i);
        end
        if(IptOrder==0||IptOrder==sum)
            Opt=1;
        else
            Opt=0;
        end
    otherwise    %buff�����
        if(IptOrder==0)
            Opt=0;
        else
            Opt=1;
        end
end

end