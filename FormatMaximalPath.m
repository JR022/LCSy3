function FormatMaximalPath(array,x,y,write)
pathString = ""; pathString2 = "";
h = height(array); w = width(array); %Dimensions of the grid.
path = DownmostMaximalPath2(array);
path2 = LeftmostMaximalPath2(array);
for point = 1:length(path)-1
    pathString = pathString + sprintf("(%.2f,%.2f)--",path(point,1)/w*x,path(point,2)/h*y);
end
pathString = pathString + sprintf("(%.2f,%.2f)",path(length(path),1)/w*x,path(length(path),2)/h*y);

for point = 1:length(path2)-1
    pathString2 = pathString2 + sprintf("(%.2f,%.2f)--",path2(point,1)/w*x,path2(point,2)/h*y);
end
pathString2 = pathString2 + sprintf("(%.2f,%.2f)",path2(length(path2),1)/w*x,path2(length(path2),2)/h*y);

%Store to a file if desired.
if write
    timeString = string(datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss_Z'));
    myFile = fopen(strcat("FormatMaximalPath--",timeString,".txt"),'w');
    fprintf(myFile, "Down-most path:\n");
    fprintf(myFile,pathString);
    fprintf(myFile,"\n");
    fprintf(myFile, "Left-most path:\n");
    fprintf(myFile,pathString2);
    fclose(myFile);
else
    disp("Down-most path:");
    disp(pathString);
    disp("Left-most path:");
    disp(pathString2);
end
end