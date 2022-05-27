function LTableSimulation(m,n,write)
    %Generates a random m*n array of Bernoulli points occupied with p=1/2
    %and then constructs the L-table.  The result is stored to a text file
    %if write==1.
    array = UniformArray(m,n);
    %Output the Bernoulli grid and L-table.  These are not flipped.
    disp("Bernoulli array:");
    disp(array);
    disp("L-table:");
    LTable = MakeLTable2(array);
    disp(LTable);
    
    if write == 1 %Stores data to a text file twice: first in MATLAB-compliant syntax for re-entry and secondly pretty-printed.
        timeString = string(datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss_Z'));
        myFile = fopen(strcat(sprintf("LTableSimulation(%d,%d)--",m,n),timeString,".txt"),'w');
        fprintf(myFile,"Bernoulli grid\n");
        for row=1:n %For convenient re-entry.
            for column=1:m-1
               fprintf(myFile,"%d,",array(row,column));
            end
            fprintf(myFile,"%d;",array(row,m));
        end
        fprintf(myFile,"\n");
        for row=n:-1:1 %The output is flipped so the first row is the first line.
           for column=1:m-1
               fprintf(myFile,"%d\t",array(row,column));
           end
           fprintf(myFile,"%d\n",array(row,m));
        end
        fprintf(myFile,"\n L-table\n");
        for row=1:n %For convenient re-entry.
            for column=1:m-1
               fprintf(myFile,"%d,",LTable(row,column));
            end
            fprintf(myFile,"%d;",LTable(row,m));
        end
        fprintf(myFile,"\n");
        for row=n:-1:1 %The output is flipped so the first row is the first line.
           for column=1:m-1
               fprintf(myFile,"%d\t",LTable(row,column));
           end
           fprintf(myFile,"%d\n",LTable(row,m));
        end
        fclose(myFile);
    end
end