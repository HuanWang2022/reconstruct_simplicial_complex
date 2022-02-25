function [res_w,res_tri]=clc_w_tri(S)
[m,n]=size(S);
res_w=zeros(n,n);       %save two-body calculation results
comb=nchoosek(1:n,2)';
nnn=length(comb);
res_tri=zeros(n+2,nnn);  %save three-body calculation results
res_tri(1:2,:)=comb;
for nod=1:n
    [p,q,k,nn]=EMSCR(S,nod);
    res_w(nod, p(1,:))=p(2,:);
    for j=1:nn
        lie=find(comb(1,:)==q(1,j) & comb(2,:)==q(2,j));
        res_tri(nod+2,lie)=q(3,j);
    end   
end
