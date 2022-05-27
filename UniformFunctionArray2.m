%Generates an m by n array filled with 0's and 1's, with each cell taking
%either value with probability 1/2.  The region is formed from the
%neighbourhood of a function.  The range in x can be chosen and n is the 
%number of squares to use.  The function should be
%supplied as a function handle and non-decreasing.
%n>=2 is the number of columns.
function randomArray = UniformFunctionArray2(xMin,xMax,n,delta,func)
    randomArray = zeros(2);
    %To reduce the height of the array shift by the minimum value,
    %which should be f(xMin) - n\delta.
    shift = floor(func(xMin) - n*delta);
    %The x-value of square i is xMin + (xMax-xMin)*i/n
    squareChange = (xMax-xMin)/(n-1);
    for column = 0:n-1
        xValue = xMin + column*squareChange;
        yValue = func(xValue);
        for j = ceil(yValue-n*delta):floor(yValue+n*delta) %Adapted for positive functions.
            if rand >= 0.5
                randomArray(j-shift+1,column+1) = 1; %Occupied.
            else
                randomArray(j-shift+1,column+1) = 0; %Vacant.
            end
        end
    end
end