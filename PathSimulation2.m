function PathSimulation2(h,w,write,output)
%Generates a random h*w grid and then finds a longest increasing path.  The
%grid, table of L-values, and coordinates of the path are written to a text
%file if write==1.  The coordinates a scaled to be 0-100.
    %array = UniformArray(h,w);
    array = UniformDiamondArray(w,h);
    LTable = MakeLTable2(array);
    %Output the Bernoulli grid and L-table.  These are not flipped.
    if output==true
       disp("Bernoulli array:");
        disp(array);
        disp("L-table:");
        disp(LTable); 
    end
    %The backtracking code is included so the L-table is not constructed
    %twice.
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
    history(2*currentLValue) = currentRow; history(2*currentLValue-1) = currentColumn;
    %Output the history array pre-formatted as a Tikz path.
    historyString = "";
    for point = 1:(length(history)-1)/2
        historyString = historyString + sprintf("(%f,%f)--",history(2*point-1)/h*100,history(2*point)/w*100);
    end
    historyString = historyString + sprintf("(%f,%f)",history(2*point+1)/h*100,history(2*point+2)/w*100);
    disp(historyString); %Does not include (0,0).
    if write == true %Stores data to a text file twice: first in MATLAB-compliant syntax for re-entry and secondly pretty-printed.
        timeString = string(datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss_Z'));
        myFile = fopen(strcat(sprintf("PathSimulation2(%d,%d)--",h,w),timeString,".txt"),'w');
        fprintf(myFile,"Bernoulli grid\n");
        for row=1:h %For convenient re-entry.
            for column=1:w-1
               fprintf(myFile,"%d,",array(row,column));
            end
            fprintf(myFile,"%d;",array(row,w));
        end
        fprintf(myFile,"\n");
        for row=h:-1:1 %The output is flipped so the first row is the first line.
           for column=1:w-1
               fprintf(myFile,"%d\t",array(row,column));
           end
           fprintf(myFile,"%d\n",array(row,w));
        end
        fprintf(myFile,"\n L-table\n");
        for row=1:h %For convenient re-entry.
            for column=1:w-1
               fprintf(myFile,"%d,",LTable(row,column));
            end
            fprintf(myFile,"%d;",LTable(row,w));
        end
        fprintf(myFile,"\n");
        for row=h:-1:1 %The output is flipped so the first row is the first line.
           for column=1:w-1
               fprintf(myFile,"%d\t",LTable(row,column));
           end
           fprintf(myFile,"%d\n",LTable(row,w));
        end
        fprintf(myFile,historyString); %Does not include (0,0).
        fclose(myFile);
    end
end