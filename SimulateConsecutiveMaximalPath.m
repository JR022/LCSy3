function SimulateConsecutiveMaximalPath(xPartition,n,delta,functions)
array = ConsecutiveUniformFunctionArray(xPartition,n,delta,functions);
path = DownMostMaximalPath(array);
pathString = "";
numberOfPartitions = length(xPartition)-1;
xMin = xPartition(1); xMax = xPartition(numberOfPartitions+1);
yMin = functions{1}(xMin)-n*delta; yMax = functions{numberOfPartitions}(xMax)+n*delta;
pathLength = length(path);
for point = 1:pathLength
    %The x-value of square i is xMin + (xMax-xMin)*i/n, i>=0.
    column = path(point,1);
    xValue = xMin + (xMax-xMin)*(column-1)/n;
    %The y-value of square j is yMin + (yMax-yMin)*j/n, j>= 0.
    row = path(point,2);
    yValue = yMin + (yMax-yMin)*row/n;
    pathString = pathString + sprintf("(%0.2f,%0.2f)", xValue,yValue);
end
disp(pathString);
end