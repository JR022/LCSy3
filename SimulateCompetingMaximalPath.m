function SimulateCompetingMaximalPath(functions,n,delta,xMin,xMax)
array = CompetingUniformFunctionArray(functions,n,delta,xMin,xMax);
path = DownMostMaximalPath(array);
pathString = "";
numberOfFunctions = length(functions);
yMin = functions{1}(xMin)-n*delta;
yMax = functions{1}(xMax)+n*delta;
for i = 2:numberOfFunctions
    if functions{i}(xMin)-n*delta < yMin
        yMin = functions{i}(xMin)-n*delta;
    end
    if functions{i}(xMax)+n*delta > yMax
        yMax = functions{i}(xMax)+n*delta;
    end
end
pathLength = length(path);
for point = 1:pathLength
    %The x-value of square i is xMin + (xMax-xMin)*(i-1)/(n-1), i>=0.
    column = path(point,1);
    xValue = xMin + (xMax-xMin)*(column-1)/(n-1);
    %The y-value of square j is yMin + (yMax-yMin)*(j-1)/(n-1), j>= 0.
    row = path(point,2);
    yValue = yMin + (yMax-yMin)*(row-1)/(n-1);
    pathString = pathString + sprintf("(%0.2f,%0.2f)", xValue,yValue);
end
disp(pathString);
end