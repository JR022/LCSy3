function SimulateCompetingMaximalPaths(domains,functions,n,delta,xMin,xMax,write)
array = CompetingUniformFunctionArray2(domains,functions,n,delta,xMin,xMax);
path = DownmostMaximalPath3(array);
pathString = "";
numberOfFunctions = length(functions);
yMin = functions{1}(domains{1}(1))-n*delta;
yMax = functions{1}(domains{1}(2))+n*delta;
for i = 2:numberOfFunctions
    minimumX = domains{i}(1); maximumX = domains{i}(2);
    if functions{i}(minimumX)-n*delta < yMin
        yMin = functions{i}(minimumX)-n*delta;
    end
    if functions{i}(maximumX)+n*delta > yMax
        yMax = functions{i}(maximumX)+n*delta;
    end
end
pathLength = length(path);
for point = 1:pathLength
    %The x-value of square i is xMin + (xMax-xMin)*i/(n-1), i>=0.
    column = path(point,1);
    xValue = xMin + (xMax-xMin)*column/(n-1);
    %The y-value of square j is yMin + (yMax-yMin)*i/(n-1), j>= 0.
    row = path(point,2);
    yValue = yMin + (yMax-yMin)*row/(n-1);
    pathString = pathString + sprintf("(%0.3f,%0.3f)", xValue,yValue);
end

%Now repeat for the left-most path
path = LeftmostMaximalPath3(array);
pathString2 = "";
pathLength = length(path);
for point = 1:pathLength
    %The x-value of square i is xMin + (xMax-xMin)*i/(n-1), i>=0.
    column = path(point,1);
    xValue = xMin + (xMax-xMin)*column/(n-1);
    %The y-value of square j is yMin + (yMax-yMin)*i/(n-1), j>= 0.
    row = path(point,2);
    yValue = yMin + (yMax-yMin)*row/(n-1);
    pathString2 = pathString2 + sprintf("(%0.3f,%0.3f)", xValue,yValue);
end

%Store to a file if desired.
if write
    timeString = string(datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss_Z'));
    myFile = fopen(strcat("SimulateCompetingMaximalPaths--",timeString,".txt"),'w');
    fprintf(myFile, "Down-most path:\n");
    fprintf(myFile,pathString);
    fprintf(myFile,"\n");
    fprintf(myFile, "Left-most path:\n");
    fprintf(myFile,pathString2);
    fclose(myFile);
    disp("Written.");
else
    disp("Down-most path:");
    disp(pathString);
    disp("Left-most path:");
    disp(pathString2);
end
end