clear
clc
close all

%The parameterized curve
t= linspace (0,1,101)
X= t
Y= 0.5-0.45*cos(3*pi*t)
plot(X,Y)

%{
%Unit square split up N times,
%each time with 4x as many boxes
%boxes are labeled like reading (left to right, from top to bottom)
%box nr k=4s+r has verticies in (k=0,...,4^n-1)
%1.(r*h,1-s*h)
%2.((r+1)*h,1-s*h)
%3.(r*h,1-(s+1)*h)
%4.((r+1)*h,1-(s+1)*h) where h=2^(-N)
%}
Nstart=1
Nstop=6

N=Nstart


v=zeros(1,4^N)
for i=1:4^N
    s=floor((i-1)/2^N)
    r=i-1-2^N*s
    if CollideRight(X,Y,N,i-1)==1
        v(i)=1
        if r<2^N-1
            v(i+1)=1
        end
    elseif CollideDown(X,Y,N,i-1)==1
        v(i)=1
        if s<2^N-1
            v(i+2^N)=1
        end
    elseif (r==0) && (CollideLeft(X,Y,N,i-1)==1)
        v(i)=1
    elseif (s==0) && (CollideUp(X,Y,N,i-1)==1)
        v(i)=1
    end
end

while N<Nstop
    w=v
    v=zeros(1,4^(N+1))
    for i=1:4^N
        if w(i)==1
            [a,b,c,d]=Split(N,i-1)
            u=[a,b,c,d]
            for j=1:4
                if CollideRight(X,Y,N+1,u(j))==1
                    v(u(j)+1)=1
                elseif CollideDown(X,Y,N+1,u(j))==1
                    v(u(j)+1)=1
                elseif CollideLeft(X,Y,N+1,u(j))==1
                    v(u(j)+1)=1
                elseif CollideUp(X,Y,N+1,u(j))==1
                    v(u(j)+1)=1
                end
            end
        end
    end
    N=N+1
end


M1=zeros(2^N)
for i=1:4^N
    s=floor((i-1)/2^N)
    r=i-1-2^N*s
    M1(s+1,r+1)=v(i)
end

E=diag(v)

n=2^N
h=1/(n+1)
epsilon=10000

A=toeplitz([4 -1 zeros(1,n-2) -1 zeros(1,n^2-n-1)])

for i = 1:(n-1)
   A(n*i+1,n*i)=0; A(n*i,n*i+1)=0
end

M=1/(h^2)*A+epsilon*E
[V,L]=eig(M)

u=V(:,1)
Z=vec2mat(u,n)

lambda=L(1,1)

%{
s1='lambda='
s2=num2str(lambda)
s=[s1 s2]
str=join(s)
%}

x=linspace(h,1-h,n)
y=linspace(h,1-h,n)
[x,y]=meshgrid(x,y)
mesh(x,y,Z)
%t=text(0, 0, 0,str,'Color','red','FontSize',14)

%{
ext_val=max(u)
if -min(u)>max(u)
  ext_val=-min(u) 
end

p=0.05

loc_area=0
for i=1:n^2
    if abs(u(i))>p*ext_val
        loc_area=loc_area+1/n^2
    end
end
%}