function modifyTxtFile(FileName)
%Replaces commas with dots in a file and then replaces the file.
Data = fileread(FileName);
Data = strrep(Data, ',', '.');
FID = fopen(FileName, 'w');
fwrite(FID, Data, 'char');
fclose(FID);
end