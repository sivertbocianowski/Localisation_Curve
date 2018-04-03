function [val] = CollideDown( X, Y, n, k)
%COLLIDE Checks if curve collides to the right with box at index k at partition n
%   Returns 1 if collides, 0 if not
s=floor(k/2^n)
r=k-2^n*s
h=2^(-n)
xmin=r*h
xmax=(r+1)*h
y=1-(s+1)*h

val=0


i=1
while i<length(X)
    if ((Y(i)<=y) && (Y(i+1)>=y)) || ((Y(i)>=y) && (Y(i+1)<=y))
        if Y(i+1)~=Y(i)
            x=(X(i)-X(i+1))/(Y(i+1)-Y(i))*(Y(i+1)-y)+X(i+1)
            if (x<=xmax) && (x>=xmin)
                val=1
                break
            end
        end
    end
    i=i+1
end
end