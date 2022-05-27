function LValueBacktrack2(array,x,y,write)
    %Constructs the L-table and keeps a log of where the L-values change.
    %This allows a path to be found effectively.
    %The output is scaled to fit in an x by y grid.
    pointsArray = zeros; %Store the points as a 3D array.  The first index is the L-value, the k-th coordinate is
    %stored at second index k, and the row and column are stored at third
    %indices 1 and 2 respectively.
    numberOfPoints = zeros(1); %Stores the number of points for each L-value.
    historyString = "";
    
    %Make the L-table.
    h = height(array); w = width(array);
    %Initial values of 0 must be set for numberOfPoints.  The only bound on
    %the path length is min(h,w).
    for i = 1:min([h,w])
       numberOfPoints(i) = 0; 
    end
    lArray = zeros(h,w);
    %A 2D array in MATLAB is indexed by:
    %       a(,1)   a(,2)
    % a(1,)     1   2
    % a(2,)     3   4
    %The first coordinate is the row and the second coordinate is the
    %column.  The height is the range for rows; the width the range for columns.
    %This function builds the table upside-down with the first row at the
    %top and the final row last.  The input should be structured in the same way.
    
    %Initialise the first row
    for column = (1:w)
        if array(1,column)==1
            lArray(1,column) = 1;
            numberOfPoints(1) = numberOfPoints(1) + 1;
            pointsArray(1,numberOfPoints(1),1) = 1;
            pointsArray(1,numberOfPoints(1),2) = column;
            break;
        end
    end
    if column < w
        for k = (column:w)
            lArray(1,k) = 1;
        end
    end
    %Initialise the first column
    for row = (1:h)
        if array(row,1) == 1
            lArray(row,1) = 1;
            numberOfPoints(1) = numberOfPoints(1) + 1;
            pointsArray(1,numberOfPoints(1),1) = row;
            pointsArray(1,numberOfPoints(1),2) = 1;
            break;
        end
    end
    if row < h
        for k = (row:h)
            lArray(k,1) = 1;
        end
    end
    %Construct the rest of the table row-by-row.
    for row=2:h
        for column=2:w
            newLValue = max([lArray(row-1,column),lArray(row,column-1),lArray(row-1,column-1)+array(row,column)]);
            if newLValue == lArray(row-1,column-1)+1 && array(row,column) == 1 %Diagonal motion: store point
                lArray(row,column) = newLValue;
                numberOfPoints(newLValue) = numberOfPoints(newLValue) + 1;
                pointsArray(newLValue,numberOfPoints(newLValue),1) = row;
                pointsArray(newLValue,numberOfPoints(newLValue),2) = column;
            else %No diagonal increase.
                lArray(row,column) = newLValue;
            end
        end
    end
    if array(1,1) == 1 %If the origin is occupied, then there are no other points where the L-value increases
        %to 1 because it is already 1.  Thus (0,0) needs to be added.
        disp("Origin occupied.");
        historyString = "(0,0)"; %Fix to be (0,func(0)-n*delta) !
    end
    
    %Work backward to find a longest increasing path.
    currentLValue = lArray(h,w); %Longest path length
    %The path is stored as a single array with the y-coordinate of the k-th
    %point at index 2k and the x-coordinate at 2k-1
    history = zeros;
    currentRow = h; currentColumn = w;
    %Choose a random (occupied) point where the L-value changes to the maximum value.
    while true
        chosenIndex =  randi([1 numberOfPoints(currentLValue)],1,1); %Choose a random point from those with L-value
        %one less than the current L-value (which are points (-1,-1) of an occupied point).  Check validity.
        if array(pointsArray(currentLValue,chosenIndex,1),pointsArray(currentLValue,chosenIndex,2)) == 1 %If point is occupied.
            currentRow = pointsArray(currentLValue,chosenIndex,1); %Move to the new point.
            currentColumn = pointsArray(currentLValue,chosenIndex,2);
            break;
        end
    end
    history(2*currentLValue) = currentRow; history(2*currentLValue-1) = currentColumn; %Store the point.
    while currentLValue > 1
        currentLValue = currentLValue - 1;
        while true
            chosenIndex =  randi([1 numberOfPoints(currentLValue)],1,1); %Choose a random point from those with L-value
            %one less than the current L-value (which are points (-1,-1) of an occupied point).  Check validity.
            if pointsArray(currentLValue,chosenIndex,1) < currentRow && pointsArray(currentLValue,chosenIndex,2) < currentColumn && array(pointsArray(currentLValue,chosenIndex,1),pointsArray(currentLValue,chosenIndex,2)) == 1
                currentRow = pointsArray(currentLValue,chosenIndex,1); %Move to the new point.
                currentColumn = pointsArray(currentLValue,chosenIndex,2);
                break;
            end
        end
        history(2*currentLValue) = currentRow; history(2*currentLValue-1) = currentColumn; %Store the point.
    end %Now output the coordinates in a compatible format.
    for point = 1:(length(history)-1)/2
        historyString = historyString + sprintf("(%0.2f,%0.2f)",history(2*point+1)/w*x,history(2*point+2)/h*y);
    end
    historyString = historyString + sprintf("(%0.2f,%0.2f)",history(2*point+1)/w*x,history(2*point+2)/h*y);
    disp(historyString); %Does not necessarily include (0,0).
    if write
        timeString = string(datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss_Z'));
        myFile = fopen(strcat(sprintf("LValueBacktrack2(%d,%d)--",x,y),timeString,".txt"),'w');
        fprintf(myFile,historyString);
        fclose(myFile);
    end
end