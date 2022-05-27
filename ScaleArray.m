function ScaleArray(array,xMin,xMax,yMin,yMax,n)
pathLength = length(array);
pathString = "";
for point = 1:pathLength
    j = array(point,1); i = array(point,2);
    %The x-value of square i is xMin + (xMax-xMin)*(i-1)/(n-1), i>=0.
    xValue = xMin + (xMax-xMin)*(j-1)/(n-1);
    %The y-value of square j is yMin + (yMax-yMin)*(j-1)/(n-1), j>= 0.
    yValue = yMin + (yMax-yMin)*(i-1)/(n-1);
     pathString = pathString + sprintf("(%0.2f,%0.2f)", xValue,yValue);
end
disp(pathString);
end