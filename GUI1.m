function hh = GUI1(intmem,extmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag,promem,branchNumber)
    hfig = figure(...
        'Name', 'test',...
        'Units','pixels',...
        'Position',[200,100,1100,800],...
        'Resize','off',...
        'Menubar','none',...
        'Toolbar','none');

    htab = uitabpanel(...
        'Parent',hfig,...
        'TitlePosition','centertop',...
        'Position',[0,0,1,1],...
        'PanelBorderType','line',...
        'Title',{'Main Menu','Addition','About'},...
        'CreateFcn',@CreateTab);

    function CreateTab(htab,evdt,hpanel,hstatus)
%         ACC=ACC;
        drawtabOne(hpanel(1),intmem,extmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag,promem,branchNumber);
        %         drawtab2(hpanel(2),NDIM_INIT,seed);
%         drawtab3(hpanel(3));
    end
    cycle
end
