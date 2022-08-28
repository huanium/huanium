function plot2DMatrixWithSlider(Xmesh,Ymesh,ZData,varargin)
    p = inputParser;
    p.addParameter('colormapMatrix',parula);
    p.addParameter('xlimits',[min(Xmesh(1,:)),max(Xmesh(1,:))]);
    p.addParameter('ylimits',[min(Ymesh(:,1)),max(Ymesh(:,1))]);
    p.parse(varargin{:});
    colormapMatrix  = p.Results.colormapMatrix;
    xlimits         = p.Results.xlimits;
    ylimits         = p.Results.ylimits;

    
    [rows,columns] = size(ZData);
    hf=figure(8123);clf;
    hpanel0=uipanel('position',[0 .00 0.5 1]);
    hpanel=uipanel('position',[0.5 .05 0.5 .45]);
    hpanel2=uipanel('position',[0.5 .55 0.5 .45]);
    hscrollbar1=uicontrol('style','slider','Min',1,'Max',columns,'Value',1,...
                        'Units', 'Normalized',...
                        'position',[0.5 0 0.5 .05],'callback',@hscroll_Callback);
    hscrollbar2=uicontrol('style','slider','Min',1,'Max',rows,'Value',1,...
                        'Units', 'Normalized',...
                        'position',[0.5 0.5 0.5 .05],'callback',@hscroll_Callback2);
    axes('parent',hpanel,'outerposition',[0 0 1 1])
    CutPlot1 = plot(Ymesh(:,1),ZData(:,1),'-o','MarkerSize',5);
    CutPlot1.MarkerFaceColor = CutPlot1.Color+0.2;
    ax1 = gca;
    title(['X parameter: ' num2str(Xmesh(1,1))])
    axes('parent',hpanel2,'outerposition',[0 0 1 1])
    CutPlot2 = plot(Xmesh(1,:),ZData(1,:),'-o','MarkerSize',5);
    CutPlot2.MarkerFaceColor = CutPlot2.Color+0.2;
    ax2 = gca;
    title(['Y parameter: ' num2str(Ymesh(1,1))])
    axes('parent',hpanel0,'outerposition',[0 0 1 1])
    
    hold on
    s = surf(Xmesh,Ymesh,ZData);
    s.EdgeColor = 'none';
    colormap(colormapMatrix);
    view(2);
    xlim(xlimits);
    ylim(ylimits);
    z = get(s,'ZData');
    set(s,'ZData',z-10)  
    Line2 = plot([min(Xmesh(:)),max(Xmesh(:))],[Ymesh(1,1),Ymesh(1,1)],'k--','LineWidth',1.5);
    xlim(xlimits);
    Line1 = plot([Xmesh(1,1),Xmesh(1,1)],[min(Ymesh(:)),max(Ymesh(:))],'k--','LineWidth',1.5);
    xlim(ylimits);
    hold off

function hscroll_Callback(src,evt)
    set(Line1, 'XData', [Xmesh(1,round(src.Value)),Xmesh(1,round(src.Value))]);
    set(CutPlot1, 'YData', ZData(:,round(src.Value)));
    title(['X parameter: ' num2str(Xmesh(1,round(src.Value)))])
    title(ax1,['X parameter: ' num2str(Xmesh(1,round(src.Value)))])
    drawnow
end
function hscroll_Callback2(src,evt)
    set(Line2, 'YData', [Ymesh(round(src.Value),1),Ymesh(round(src.Value),1)]);
    set(CutPlot2, 'YData', ZData(round(src.Value),:));
    title(['Y parameter: ' num2str(Ymesh(round(src.Value),1))])
    title(ax2,['Y parameter: ' num2str(Ymesh(round(src.Value),1))])
    drawnow
end

end