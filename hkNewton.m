function root = hkNewton(x0, k, maxIterations)
    currentX=0; nextX=0;
    hk = k^(x0/2)*x0^x0*(1-x0)^(1-x0);
    currentX = x0 - (hk-1)/(hk*log((sqrt(k)*x0)/(1-x0)));
    for i = 1:maxIterations-1
        hk = (k^(currentX/2))*currentX^currentX*(1-currentX)^(1-currentX);
       nextX =  currentX - (hk-1)/(hk*log((sqrt(k)*currentX)/(1-currentX)));
       currentX = nextX;
    end
    root = currentX;
end