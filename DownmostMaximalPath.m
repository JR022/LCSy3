function history = DownmostMaximalPath(array)
%Constructs the down-most path of an array of Bernoulli points.
lTable = MakeLTable2(array);
h = height(array); w = width(array); %Dimensions of the grid.
history = zeros(2); %A 2D array.
%Returns an array of integers corresponding to the occupied points.
currentRow = h; currentColumn = w;
currentLValue = lTable(currentRow,currentColumn);
while currentLValue > 1
    if lTable(currentRow,currentColumn) - lTable(currentRow-1,currentColumn) == 0
        currentRow = currentRow - 1;
    end
    if lTable(currentRow,currentColumn) - lTable(currentRow,currentColumn-1) == 0 && lTable(currentRow,currentColumn) - lTable(currentRow-1,currentColumn) == 1 && array(currentRow, currentColumn) == 0
        currentColumn = currentColumn - 1;
    end
    if lTable(currentRow,currentColumn) - lTable(currentRow-1,currentColumn) == 1 && array(currentRow, currentColumn) == 1
        %Add this point to history.
        history(currentLValue,1) = currentColumn; history(currentLValue,2) = currentRow;
        currentRow = currentRow - 1; currentColumn = currentColumn - 1;
    end
    %Update the L-value.
    currentLValue = lTable(currentRow,currentColumn);
end
%The L-value is now 1. Find the first occupied point in this row.  If
%already at column 1 add this (occupied) point.
if currentColumn == 1
    history(1,1) = currentColumn; history(1,2) = currentRow;
end
while currentColumn > 1
    %currentRow = currentRow - 1;
    if array(currentRow,currentColumn) == 1
        history(1,1) = currentColumn; history(1,2) = currentRow;
        break;
    end
    currentColumn = currentColumn - 1;
end
end