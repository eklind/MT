function [rps, mps,bf] = rpm_to_beltfreq(rpm, ratio,belt_length)
rps=rpm*ratio/60;
mps=rps*(8*pi*0.0254);
bf=mps/(belt_length*0.0254); %per second
end

