% Belt life expectancy
function life_reduction=belt_life_est(belt_temp)
%IN: belt_temp celsius
%OUT: life reduction of belt in percent
%https://www.engineerlive.com/content/v-belts-high-temperatures
%call with a mean or multiple time to make decision
belt_temp=mean(belt_temp);
temp_high=55;
if(belt_temp>temp_high) %change to 60(?)
    life_loss=(belt_temp-temp_high)/10;%0 is nothing, 1 is 50 percent
    life_reduction=1-0.5.^(life_loss); %life reduction in percent(0-1)
else
    life_reduction =0; %normal life time
end
end