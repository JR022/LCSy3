%Calculate the table of L-values for a given 2D array of 2's, 1's, and 0's.
function lArray = MakeLTable3(array)
    h = height(array); w = width(array);
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
        if array(1,column)==2
            lArray(1,column) = 1;
            break;
        end
    end
    if column < w
        for k = (column:w)
            if array(1,column) == 0 %Invalid
                break;
            else %This will label all vacant or occupied points.
                lArray(1,k) = 1;
            end
        end
    end
    %Initialise the first column
    for row = (1:h)
        if array(row,1) == 1
            lArray(row,1) = 1;
            break;
        end
    end
    if row < h
        for k = (row:h)
            if array(row,1) == 0 %Invalid
                break;
            else %This will label all vacant or occupied points.
                lArray(k,1) = 1;
            end
        end
    end
    %Construct the rest of the table row-by-row.
    for row=2:h
        for column=2:w
            if array(row,column) == 0
                continue;
            else
                lArray(row,column) = max([lArray(row-1,column-1)+array(row,column),lArray(row-1,column),lArray(row,column-1)]);
            end
        end
    end
end