function make_plot_pretty(fig,a,howToLabelTicks,xaxislabel,yaxislabel,xtickslabel,ytickslabel,legendOn)

set(groot, ...
    'DefaultFigureColor', 'w', ...
    'DefaultAxesLineWidth', 1, ...
    'DefaultAxesXColor', 'k', ...
    'DefaultAxesYColor', 'k', ...
    'DefaultTextFontName', 'Arial', ...
    'DefaultAxesBox', 'off', ...
    'DefaultAxesTickLength', [0.02 0.025]);
%     'DefaultAxesFontUnits', 'points', ...
%     'DefaultAxesFontSize', 14, ...
%     'DefaultAxesFontName', 'Arial', ...
%     'DefaultLineLineWidth', 1, ...
%     'DefaultTextFontUnits', 'Points', ...
%     'DefaultTextFontSize', 10);
box off
grid off

% set the tickdirs to go out - need this specific order
set(groot, 'DefaultAxesTickDir', 'out');
set(groot, 'DefaultAxesTickDirMode', 'manual');

a.XLabel.FontName = 'Arial';
a.YLabel.FontName = 'Arial';
a.XLabel.FontSize = 13;
a.YLabel.FontSize = 13;
a.FontSize = 12;

if strcmp(howToLabelTicks,'FirstAndLast')
    if ~isempty(a.XTickLabel)
        xend = length(a.XTickLabel);
        xlabels = cell(xend,1);
        xlabels{1} = a.XTickLabel{1};
        xlabels{xend} = a.XTickLabel{end};
        a.XTickLabel = xlabels;
    end
    if ~isempty(a.YTickLabel)
        yend = length(a.YTickLabel);
        ylabels = cell(yend,1);
        ylabels{1} = a.YTickLabel{1};
        ylabels{yend} = a.YTickLabel{end};
        a.YTickLabel = ylabels;
    end
    xlabel(xaxislabel);
    ylabel(yaxislabel);
end

if strcmp(howToLabelTicks,'default')
    if ~isempty(xtickslabel)
        a.XTickLabel = xtickslabel;
    end
    if ~isempty(ytickslabel)
        a.YTickLabel = ytickslabel;
    end
    xlabel(xaxislabel);
    ylabel(yaxislabel);
end

if strcmp(howToLabelTicks,'All')
    if ~isempty(xtickslabel)
        a.XTickLabel = xtickslabel;
    end
    if ~isempty(ytickslabel)
        a.YTickLabel = ytickslabel;
    end
    xlabel(xaxislabel);
    ylabel(yaxislabel);
end

for b = 1:length(a)
    if a(b).YColor < [1 1 1]
        a(b).YColor = [0 0 0];
    end
    if a(b).XColor < [1 1 1]
        a(b).XColor = [0 0 0];
    end
end
%a.LineWidth = 2;

if legendOn
    [leg,~,~,~]=legend;
    legend boxoff
    leg.FontSize = 7.5;
    leg.FontName = 'Arial';
    leg.Location = 'best';
end






end