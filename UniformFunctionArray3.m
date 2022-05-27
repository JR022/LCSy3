%Generates an m by n array filled with 0's and 1's, with each cell taking
%either value with probability 1/2.  The region is formed from the
%neighbourhood of a function.  The range in x can be chosen and n is the 
%number of squares to use.  The function should be
%supplied as a function handle and non-decreasing.
%n>=2 is the number of columns and rows.
function randomArray = UniformFunctionArray3(xMin,xMax,n,delta,func)
    randomArray = zeros(2);
    %The x-value of square i is xMin + (xMax-xMin)*i/n, i>=0.
    xChange = (xMax-xMin)/n;
    %The y-value of square j is yMin + (yMax-yMin)*j/n, j>= 0.
    yMax = func(xMax)+n*delta;
    yMin = func(xMin)-n*delta;
    yChange = (yMax-yMin)/n;
    for column = 0:n
        xValue = xMin + column*xChange;
        yValue = func(xValue);
        rowMin = (yValue-n*delta-yMin)*n/(yMax-yMin);
        rowMax = (yValue+n*delta-yMin)*n/(yMax-yMin);
        for row = ceil(rowMin):floor(rowMax) %Adapted for positive functions.
            if rand >= 0.5
                randomArray(row+1,column+1) = 1; %Occupied.
            else
                randomArray(row+1,column+1) = 0; %Vacant.
            end
        end
    end
end