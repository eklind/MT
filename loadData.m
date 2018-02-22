%name: name of file
%sheet: array of sheets to be loaded into struct "loadedData". ex: [1:5],
%[1,2,8] etc
%Assuming time in A column and measurements in the rest
function loadedData=loadData(name,sheets)
    for i=sheets
        id=strcat('ID',num2str(i))
        values=xlsread(name,i);
        loadedData.(id).data.temp_motor=values(:,[1,2]);
        loadedData.(id).data.temp_comp=values(:,[1,3]);
        loadedData.(id).data.rmp_motor=values(:,[1,4]);
        loadedData.(id).data.rpm_comp=values(:,[1,5]);
        loadedData.(id).data.tension=values(:,[1,6]);
        loadedData.(id).data.vibrometer=values(:,[1,7]);
        loadedData.(id).op=i;
        i
    end
end