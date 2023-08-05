%Read and Display original Image
I=imread("cameraman.tif");
Size=size(I);
figure();
subplot(2,2,1);
imshow(I);
subplot(2,2,2);

Histo1=Histogram_Function(I);%Calculates Histogram
histogram(I);
A=mean(I);
Avg1=mean(A);

Dh=zeros(1,256);
Ddh=zeros(1,256);

%Calculate first order difference
for l=2:255
    Dh(l)=Histo1(l+1)-Histo1(l-1);
end

%Calculate second order difference
for m=2:254
    Ddh(m)=Dh(m+1)-Dh(m-1);
end

%Find all local maxima
o=0;
LocalMax=zeros(1,256);
for n=2:256
    if Ddh(n)<0
        if Dh(n-1)*Dh(n+1)<0
            o=o+1;
            LocalMax(o)=n;
        end
    end
end

%Select dominant maxima from all local maxima
q=0;
for p=1:51
    if LocalMax(p+1)-LocalMax(p)==1;
        if Histo1(LocalMax(p))>Histo1(LocalMax(p+1))
            q=q+1;
            TrueMax(q)=LocalMax(p);
        else
            q=q+1;
            TrueMax(q)=LocalMax(p+1);
        end
    end
end
t=1;
s=1;

%Find locations of dominant maxima
Maxima(1)=TrueMax(1);
for r=2:q
    if TrueMax(r)-TrueMax(t)>=21
        s=s+1;
        Maxima(s)=TrueMax(r);
        t=r;
    end
end

%Equilization of divided histogram
Start=1;
for a=1:s
    F(1,[Start:Maxima(a)])=cumsum(Histo1(1,[Start:Maxima(a)]));
    Start=Maxima(a)+1;
end
F(1,[Start:256])=cumsum(Histo1(1,[Start:256]));

Start=1;
for a=1:s
        K(1,[Start:Maxima(a)])=floor(Start+((Maxima(a)-Start)*F(1,[Start:Maxima(a)]))/F(1,Maxima(a)));
        Start=Maxima(a)+1;
end
K(1,[Maxima(s):256])=floor(Maxima(s)+((255-Maxima(s))*F(1,[Maxima(s):256]))/F(1,256));

I2=I;
for i=1:Size(1)
    for j=1:Size(2)
        I2(i,j)=K(I(i,j));
    end
end

%Display modified image
subplot(2,2,3);
imshow(I2);
subplot(2,2,4);
histogram(I2);
