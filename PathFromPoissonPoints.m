function PathFromPoissonPoints(pointString, decimalPoints)
    array=zeros(2);
    points = split(pointString,',');
    n = length(points)/2;
    shift = 10^decimalPoints;
    for point = 1:n
        coordinates = floor([sscanf(points(2*point),"%f)"),sscanf(points(2*point-1),"(%f")]*shift);
        array(coordinates(1),coordinates(2)) = 1;
    end
    %Array now created.
    path = DownmostMaximalPath2(array);
    pathString = "";
    pathLength = length(path);
    for point = 1:pathLength
        coordinates = path(point,:)/shift;
        pathString = pathString + sprintf("(%.2f,%.2f)--", coordinates(1),coordinates(2));
    end
    %Now repeat for the left-most path
    path = LeftmostMaximalPath2(array);
    pathString2 = "";
    pathLength = length(path);
    for point = 1:pathLength
        coordinates = path(point,:)/shift;
        pathString2 = pathString2 + sprintf("(%.2f,%.2f)--", coordinates(1),coordinates(2));
    end
    disp("Down-most path:");
    disp(pathString);
    disp("Left-most path:");
    disp(pathString2);
end