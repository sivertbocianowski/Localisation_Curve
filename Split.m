function [ind1,ind2,ind3,ind4] = Split(n, k )
%SPLIT Splits a box into four subboxes
%   Goes from n to n+1, and return 4 indexes
s=floor(k/2^n)
r=k-2^n*s
ind1=2^(n+2)*s+2*r
ind2=2^(n+2)*s+2*r+1
ind3=2^(n+2)*s+2^(n+1)+2*r
ind4=2^(n+2)*s+2^(n+1)+2*r+1

end

