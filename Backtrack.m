function Backtrack(array)
%Given a Bernoulli grid, work backwards to find a longest increasing
%path.
%Starting at the end point, look at the L-values surrounding the point in
%the lower left.
%(x-1,y)    *(x,y)*
%(x-1,y-1)  (x,y-1)
%Starting at the end point, check if the lower left L-value is one less.
h = height(array(:,1)); w = width(array(1,:));
LTable = MakeLTable2(array);
currentLValue = LTable(h,w); %Longest path length
currentRow = h; currentColumn = w; %Stores the current position of the path
%The path is stored as a single array with the y-coordinate of the k-th
%point at index 2k and the x-coordinate at 2k-1
history = zeros;
%A flag is used to alternate between prioritising horizontal and vertical movement.
flag = true;
while currentLValue > 1
    if array(currentRow,currentColumn) == 1 %Occupied.
        history(2*currentLValue) = currentRow; history(2*currentLValue-1) = currentColumn;
        currentRow = currentRow-1; currentColumn = currentColumn-1; %Move diagonally down.
        currentLValue = LTable(currentRow,currentColumn);
        flag = not(flag);
    else %Not occupied.
        if flag == true
            if LTable(currentRow-1,currentColumn) == LTable(currentRow,currentColumn)
                currentRow = currentRow - 1;
            else
                currentColumn = currentColumn - 1;
            end
        else
            if LTable(currentRow,currentColumn-1) == LTable(currentRow,currentColumn)
                currentColumn = currentColumn - 1;
            else
                currentRow = currentRow - 1;
            end
        end
    end
end
history(2*currentLValue) = currentRow; history(2*currentLValue-1) = currentColumn; %Not always occupied!!
%Output the history array pre-formatted as a Tikz path.
historyString = "";
for point = 1:(length(history)-1)/2
    historyString = historyString + sprintf("(%d,%d)",history(2*point-1),history(2*point));
end
historyString = historyString + sprintf("(%d,%d)",history(2*point+1),history(2*point+2));
disp(historyString); %Does not include (0,0).
end