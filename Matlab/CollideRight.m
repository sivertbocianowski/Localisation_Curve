function [val] = CollideRight( X, Y, n, k)
%COLLIDE Checks if curve collides to the right with box at index k at partition n
%   Returns 1 if collides, 0 if not
s=floor(k/2^n)
r=k-2^n*s
h=2^(-n)
x=(r+1)*h
ymin=1-(s+1)*h
ymax=1-s*h

val=0


i=1
while i<length(X)
    if ((X(i)<=x) && (X(i+1)>=x)) || ((X(i)>=x) && (X(i+1)<=x))
        if X(i+1)~=X(i)
            y=(Y(i)-Y(i+1))/(X(i+1)-X(i))*(X(i+1)-x)+Y(i+1)
            if (y<=ymax) && (y>=ymin)
                val=1
                break
            end
        end
    end
    i=i+1
end
end
