function history = LeftmostMaximalPath3(array)
%Constructs the left-most path of an array of Bernoulli points.
lTable = MakeLTable2(array);
h = height(array); w = width(array); %Dimensions of the grid.
history = zeros(2); %A 2D array.
%Returns an array of integers corresponding to the occupied points.
currentRow = h; currentColumn = w;
currentLValue = lTable(h,w);
while currentLValue > 1
    if lTable(currentRow,currentColumn) - lTable(currentRow,currentColumn-1) == 0
        currentColumn = currentColumn - 1;
        currentLValue = lTable(currentRow,currentColumn);
        continue;
    end
    if lTable(currentRow,currentColumn) - lTable(currentRow-1,currentColumn) == 0 && lTable(currentRow,currentColumn) - lTable(currentRow,currentColumn-1) == 1 && array(currentRow, currentColumn) == 0
        currentRow = currentRow - 1;
        currentLValue = lTable(currentRow,currentColumn);
        continue;
    end
    if lTable(currentRow,currentColumn) - lTable(currentRow,currentColumn-1) == 1 && array(currentRow, currentColumn) == 1
        %Add this point to history.
        history(currentLValue,1) = currentColumn; history(currentLValue,2) = currentRow;
        currentRow = currentRow - 1; currentColumn = currentColumn - 1;
        currentLValue = lTable(currentRow,currentColumn);
        continue;
    end
end
%The L-value is now 1. Continue until an axis is hit (row or column is 1) or the L-value becomes 0.
while currentRow > 1 && currentColumn > 1 && currentLValue == 1
    %Update the L-value.
    currentLValue = lTable(currentRow,currentColumn);
    
    if lTable(currentRow,currentColumn) - lTable(currentRow-1,currentColumn) == 0
        currentRow = currentRow - 1;
        continue;
    end
    if lTable(currentRow,currentColumn) - lTable(currentRow,currentColumn-1) == 0 && lTable(currentRow,currentColumn) - lTable(currentRow-1,currentColumn) == 1 && array(currentRow, currentColumn) == 0
        currentColumn = currentColumn - 1;
        continue;
    end
    if lTable(currentRow,currentColumn) - lTable(currentRow-1,currentColumn) == 1 && array(currentRow, currentColumn) == 1
        %Add this point to history.
        history(currentLValue,1) = currentColumn; history(currentLValue,2) = currentRow;
        currentRow = currentRow - 1; currentColumn = currentColumn - 1;
        continue;
    end
end

if currentLValue == 0
    return;
end
if currentRow == 1
    while currentColumn > 1
    if array(currentRow,currentColumn) == 1
        history(1,1) = currentColumn; history(1,2) = currentRow;
        break;
    end
    currentColumn = currentColumn - 1;
    end
else %currentColumn == 1
    while currentRow > 1
    if array(currentRow,currentColumn) == 1
        history(1,1) = currentColumn; history(1,2) = currentRow;
        break;
    end
    currentRow = currentRow - 1;
    end
end
end