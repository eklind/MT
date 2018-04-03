function modifyTxtFile(FileName)
Data = fileread(FileName);
Data = strrep(Data, ',', '.');
FID = fopen(FileName, 'w');
fwrite(FID, Data, 'char');
fclose(FID);
end