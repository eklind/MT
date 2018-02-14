%name: name of file
%sheet: array of sheets to be loaded into struct "loadedData". ex: [1:5],
%[1,2,8] etc
%Assuming time in A column and measurements in the rest
function loadedData=loadData(name,sheets)
    for i=sheets
        id=strcat('ID',num2str(i))
        temp=xlsread(name,i);
        loadedData.(id).data.param_1=temp(:,[1,2]);
        loadedData.(id).data.param_2=temp(:,[1,3]);
        loadedData.(id).data.param_3=temp(:,[1,4]);
        loadedData.(id).data.param_4=temp(:,[1,5]);
        loadedData.(id).data.param_5=temp(:,[1,6]);
        loadedData.(id).op=i;
        i
    end
end