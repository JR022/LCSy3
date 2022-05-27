%For use with the multi-function version.
function ScaledDownMostPathAlt(xMin,xMax,yMin,yMax,n,delta,write,array)
path = DownMostMaximalPath(array);

h = height(array); w = width(array); %Dimensions of the grid.
pathString = "";

for point = 1:length(path(:,1))
    xCoordinate = xMin + (xMax-xMin)*path(point,1)/n;
    yCoordinate = yMin + (yMax-yMin)*path(point,2)/n;
    pathString = pathString + sprintf("(%0.2f,%0.2f)",xCoordinate,yCoordinate);
end
if write
    timeString = string(datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss_Z'));
    myFile = fopen(strcat(sprintf("ScaledDownMostPath(%d,%d,%d,%f,%d)--",xMin,xMax,n,delta,write),timeString,".txt"),'w');
    fprintf(myFile,pathString);
    fclose(myFile);
end
disp(pathString);
end