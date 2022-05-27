function PoissonPoints(n)
    pointString = "";
    for i =  1:n
        pointString = pointString + sprintf("(%.2f,%.2f),",rand,rand);
    end
    disp(pointString);
end