%Calculate the table of L-values for a given 2D array of 1's and 0's.
function lArray = MakeLTable(array)
    h = height(array); w = width(array);
    lArray = zeros(h,w);
    %A 2D array in MATLAB is weird:
    %       a(,1)   a(,2)
    % a(1,)     1   2
    % a(2,)     3   4
    %The first coordinate is the row and the second coordinate is the
    %column.  The height is the range for x; the width the range for y.
    
    %Initialise the first row
    for column = (1:w)
        if array(h,column)==1
            lArray(h,column) = 1;
            break;
        end
    end
    if column < w
        for k = (column:w)
            lArray(h,k) = 1;
        end
    end
    %Initialise the first column
    for row = (0:h-1)
        if array(h-row,1) == 1
            lArray(h-row,1) = 1;
            break;
        end
    end
    if row < h-1
        for k = (row:h-1)
            lArray(h-k,1) = 1;
        end
    end
    
    
    for x=1:h-1
        for y=2:w
            lArray(h-x,y) = max([lArray(h-x,y-1),lArray(h-x+1,y),lArray(h-x+1,y-1)+array(h-x,y)]);
        end
    end
    
end