function [DPL,DPH]=saveDPTR(DPTR)
    tmp=DPTR;
    DPL=mod(tmp,256);
    DPH=fix(tmp/256);
end