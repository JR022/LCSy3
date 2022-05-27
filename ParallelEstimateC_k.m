%Estimate c_k.  Generates a fixed word of length <wordSize> and then
%computes the LCS between this and <numberOfRuns> words of length
%<wordSize>.  The total is divided to give an average value of c_k.
%Information is written to a text file.
function c_k = ParallelEstimateC_k(wordSize, alphabetSize, numberOfRuns)
    tic;
    LCStotal = uint32(0); %Stores the total of all the LCS lengths.
    %Creates a text file with a timestamp.
    timeString = string(datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss_Z'));
    myFile = fopen(strcat(sprintf("ParallelEstimateC_k(%d,%d,%d)--",wordSize,alphabetSize,numberOfRuns),timeString,".txt"),'w');
    %Write function call to text file.
    fprintf(myFile,"ParallelEstimateC_k(%d,%d,%d)\n",wordSize,alphabetSize,numberOfRuns);
    %Generate a fixed word of length <wordSize> which is used to estimate
    %c_k and add to text file.
    W = randi([1 alphabetSize],1,wordSize);
    WString = strcat("'",sprintf("%d",W),"'");
    fprintf(myFile,"W = %s\n----------------------\n",WString);
    simulationString = "";
    parfor i = 1:numberOfRuns
        %Generate a random word for the LCS calculation.
        word = randi([1 alphabetSize],1,wordSize);
        LCSlength = AltLongestSubsequence(W,word); %Calculate the length of the LCS.
        wordString = strcat("'",sprintf("%d",word),"'");
        LCStotal = LCStotal + LCSlength; %Add the length to the total.
        data = sprintf("LCS(W,%s) = %d\n",wordString,LCSlength);
        simulationString = strcat(simulationString,data); %Add word and LCS length to a string.
        %The data is written to a string and not the file directly due to
        %issues with the parfor loop.
    end
    fprintf(myFile,simulationString); %Write the string of simulations to the text file.
    fprintf(myFile,"------------------------\nLCSTotal = %d\n",LCStotal); %Print LCStotal to text file.
    %Calculate the estimate for c_k, add to text file, and return.
    c_kEstimate = vpa(sym(LCStotal)/sym(numberOfRuns)/sym(wordSize));
    fprintf(myFile,"c_k = %20f",c_kEstimate);
    toc
    c_k = c_kEstimate;
end