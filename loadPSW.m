function PSW_back=loadPSW(PSW)
    tmp=dec2bin(PSW,8);
    PSW_back=zeros(8,1);
    PSW_back(1,1)=bin2dec(tmp(1));
    PSW_back(2,1)=bin2dec(tmp(2));
    PSW_back(3,1)=bin2dec(tmp(3));
    PSW_back(4,1)=bin2dec(tmp(4));
    PSW_back(5,1)=bin2dec(tmp(5));
    PSW_back(6,1)=bin2dec(tmp(6));
    PSW_back(7,1)=bin2dec(tmp(7));
    PSW_back(8,1)=bin2dec(tmp(8));
end
    