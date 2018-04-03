function [X, Y] = RandomWalk(n, h)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
X=zeros(1,n)
Y=zeros(1,n)
i=2
while i<=n
        angle=2*pi*rand
        x_0=X(i-1)
        y_0=Y(i-1)
        x=h*cos(angle)+x_0
        y=h*sin(angle)+y_0
        if (x>0) && (x<1) && (y>0) && (y<1)
            X(i)=x
            Y(i)=y
            i=i+1
        end
end

end

