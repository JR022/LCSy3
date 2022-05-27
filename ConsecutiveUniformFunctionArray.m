%Generates an m by n array filled with 0's and 1's, with each cell taking
%either value with probability 1/2.  The region is formed from the
%neighbourhood of a function.  The x axis is partitioned and the functions
%should be given as a cell array of function handles.
%n>=2 is the number of columns and rows.  This should be divisible
%by the number of partitions.
function randomArray = ConsecutiveUniformFunctionArray(xPartition,n,delta,functions)
    randomArray = zeros(2);
    numberOfPartitions = length(xPartition)-1;
    xMin = xPartition(1); xMax = xPartition(numberOfPartitions+1);
    yMin = functions{1}(xMin)-n*delta; yMax = functions{numberOfPartitions}(xMax)+n*delta;
    xChange = (xMax-xMin)/n;
    numberOfPoints = n/numberOfPartitions; %Number of points per partition.
    for partition = 1:numberOfPartitions
        for column = 0:numberOfPoints
            func = functions{partition};
            %The x-value of square i is xMin + (xMax-xMin)*i/n, i>=0.
            xValue = xMin + (column+(partition-1)*numberOfPoints)*xChange;
            yValue = func(xValue);
            %The y-value of square j is yMin + (yMax-yMin)*j/n, j>= 0.
            rowMin = (yValue-n*delta-yMin)*n/(yMax-yMin);
            rowMax = (yValue+n*delta-yMin)*n/(yMax-yMin);
            for row = ceil(rowMin):floor(rowMax) %Adapted for positive functions.
                %Mark the site for later.
                randomArray(row+1,numberOfPoints*(partition-1)+column+1) = 1;
            end
        end
    end
    %Now the n*n table has all sites in the neighbourhood
        %marked with 1. 
    for row = 1:n+1
        for column = 1:n+1
            if randomArray(row,column) == 1 %Occupy marked sites.
                if rand >= 0.5
                    randomArray(row,column) = 1; %Occupied.
                else
                    randomArray(row,column) = 1; %Vacant.
                end
            end
        end
    end
end