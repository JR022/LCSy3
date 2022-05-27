function PlotArray(array)
h = height(array); w = width(array); %Dimensions of the grid.
f = figure('visible','off');
for i = 1:h
for j = 1:w
    if array (i,j) == 1
        plot(i,j,'.');
        hold on;
    end
end
end
set(f,'visible','on');
end