function ScaledPlotArray(array,xMin,xMax,yMin,yMax,n)
h = height(array); w = width(array); %Dimensions of the grid.
f = figure('visible','off');
for i = 1:h
for j = 1:w
    if array (i,j) == 1
        %The x-value of square i is xMin + (xMax-xMin)*(i-1)/(n-1), i>=0.
        xValue = xMin + (xMax-xMin)*(j-1)/(n-1);
        %The y-value of square j is yMin + (yMax-yMin)*(j-1)/(n-1), j>= 0.
        yValue = yMin + (yMax-yMin)*(i-1)/(n-1);
        plot(xValue,yValue,'.');
        hold on;
    end
end
end
set(f,'visible','on');
end