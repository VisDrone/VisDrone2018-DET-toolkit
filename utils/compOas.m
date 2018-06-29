function oa = compOas( dt, gt, ig )
% Computes (modified) overlap area between pairs of bbs.
%
% Uses modified Pascal criteria with "ignore" regions. The overlap area
% (oa) of a ground truth (gt) and detected (dt) bb is defined as:
%  oa(gt,dt) = area(intersect(dt,dt)) / area(union(gt,dt))
% In the modified criteria, a gt bb may be marked as "ignore", in which
% case the dt bb can can match any subregion of the gt bb. Choosing gt' in
% gt that most closely matches dt can be done using gt'=intersect(dt,gt).
% Computing oa(gt',dt) is equivalent to:
%  oa'(gt,dt) = area(intersect(gt,dt)) / area(dt)
%
% USAGE
%  oa = bbGt( 'compOas', dt, gt, [ig] )
%
% INPUTS
%  dt       - [mx4] detected bbs
%  gt       - [nx4] gt bbs
%  ig       - [nx1] 0/1 ignore flags (0 by default)
%
% OUTPUTS
%  oas      - [m x n] overlap area between each gt and each dt bb
%
% EXAMPLE
%  dt=[0 0 10 10]; gt=[0 0 20 20];
%  oa0 = bbGt('compOas',dt,gt,0)
%  oa1 = bbGt('compOas',dt,gt,1)
%
% See also bbGt, bbGt>evalRes
m=size(dt,1); n=size(gt,1); oa=zeros(m,n);
if(nargin<3), ig=zeros(n,1); end
de=dt(:,[1 2])+dt(:,[3 4]); da=dt(:,3).*dt(:,4);
ge=gt(:,[1 2])+gt(:,[3 4]); ga=gt(:,3).*gt(:,4);
for i=1:m
  for j=1:n
    w=min(de(i,1),ge(j,1))-max(dt(i,1),gt(j,1)); if(w<=0), continue; end
    h=min(de(i,2),ge(j,2))-max(dt(i,2),gt(j,2)); if(h<=0), continue; end
    t=w*h; 
    if(ig(j)) 
        u=da(i);
    else
        u=da(i)+ga(j)-t; 
    end
    oa(i,j)=t/u;
  end
end
end
