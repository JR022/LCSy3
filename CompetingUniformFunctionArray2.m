%Creates an n*n array populated with Bernoulli(0.5) points in a region
%formed from the n*Delta neighbourhoods of multiple functions.  Each
%function should be non-decreasing.
%Allows the domain of each function to be specified (each only a single interval).
function randomArray = CompetingUniformFunctionArray2(domains,functions,n,delta,xMin,xMax)
randomArray = zeros(n,n);
numberOfFunctions = length(functions);
yMin = functions{1}(domains{1}(1))-n*delta;
yMax = functions{1}(domains{1}(2))+n*delta;
for i = 2:numberOfFunctions
    minimumX = domains{i}(1); maximumX = domains{i}(2);
    if functions{i}(minimumX)-n*delta < yMin
        yMin = functions{i}(minimumX)-n*delta;
    end
    if functions{i}(maximumX)+n*delta > yMax
        yMax = functions{i}(maximumX)+n*delta;
    end
end

xChange = (xMax-xMin)/(n-1);
for i = 1:numberOfFunctions
    func = functions{i};
    domain = domains{i};
    %The x-value of square i is xMin + (xMax-xMin)*i/(n-1), i>=0.
    firstColumn = ceil((domain(1)-xMin)/(xMax-xMin)*(n-1));
    lastColumn = floor((domain(2)-xMin)/(xMax-xMin)*(n-1));
    for column = firstColumn:lastColumn
        %The x-value of square i is xMin + (xMax-xMin)*i/(n-1), i>=0.
        xValue = xMin + column*xChange;
        yValue = func(xValue);
        %The y-value of square j is yMin + (yMax-yMin)*j/(n-1), j>= 0.
        rowMin = (yValue-n*delta-yMin)*(n-1)/(yMax-yMin);
        rowMax = (yValue+n*delta-yMin)*(n-1)/(yMax-yMin);
        for row = ceil(rowMin):floor(rowMax) %Adapted for positive functions.
            %Mark the site for later.
            randomArray(row+1,column+1) = 1;
        end
    end
end
%Now the n*n table has all sites in the neighbourhood
%marked with 1. 
for row = 1:n
    for column = 1:n
        if randomArray(row,column) == 1 %Occupy marked sites.
            if rand >= 0.5
                randomArray(row,column) = 1; %Occupied.
            else
                randomArray(row,column) = 0; %Vacant.
            end
        end
    end
end
end