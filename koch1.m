function [X Y]=koch1(n)
x0=0
y0=0
x1=1
y1=0
X=[x0 x1]
Y=[y0 y1] 
i=1
while i<=n
    Xtemp=X
    Ytemp=Y
    X=zeros(1,4^i+1)
    Y=zeros(1,4^i+1)
    for c=1:(4^(i-1)+1)
        X(4*(c-1)+1)=Xtemp(c)
        Y(4*(c-1)+1)=Ytemp(c)
        if(c~=4^(i-1)+1)
            x_0=Xtemp(c)
            y_0=Ytemp(c)
            x_1=Xtemp(c+1)
            y_1=Ytemp(c+1)
            X(4*(c-1)+2)=(2*x_0+x_1)/3
            Y(4*(c-1)+2)=(2*y_0+y_1)/3
            X(4*(c-1)+4)=(x_0+2*x_1)/3
            Y(4*(c-1)+4)=(y_0+2*y_1)/3
            if x_1>x_0
                b=(((x_1-x_0)^2+(y_1-y_0)^2)/(12*(1+((y_1-y_0)/(x_1-x_0))^2)))^(0.5)
            else 
                b=-(((x_1-x_0)^2+(y_1-y_0)^2)/(12*(1+((y_1-y_0)/(x_1-x_0))^2)))^(0.5)
            end
            a=-b*(y_1-y_0)/(x_1-x_0)
            X(4*(c-1)+3)=x_0+0.5*(x_1-x_0)+a
            Y(4*(c-1)+3)=y_0+0.5*(y_1-y_0)+b
        end
    end
    i=i+1
end
            