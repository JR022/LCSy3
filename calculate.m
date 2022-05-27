function answer=calculate()
    syms k
    equation = sqrt(k)+(sqrt(k)-1)*log(1/(sqrt(k)-1)) + (sqrt(k)-1)*log(2)+1==0;
    answer = solve(equation,k);
end