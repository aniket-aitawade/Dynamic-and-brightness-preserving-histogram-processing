function Intensity=Histogram_Function(Image)

Size=size(Image);
Intensity=zeros(1,256);
for i=1:Size(1)
    for j=1:Size(2)
        Intensity_val=Image(i,j);
        Intensity(Intensity_val)=Intensity(Intensity_val)+1;
    end
end
end
%plot(0:255,Intensity);