function [res_w,res_tri]=clc_w_tri(S)
[m,n]=size(S);
res_w=zeros(n,n);       %save two-body calculation results
comb=nchoosek(1:n,2)';
nnn=length(comb);
res_tri=zeros(n+2,nnn);  %save three-body calculation results
res_tri(1:2,:)=comb;
for nod=1:n
    [p,k]=EMNR(S,nod); %Reconstruction of two-body
    a=p(2,:);
    c_cut=fun_cut(a);
    neig=p(1,find(p(2,:)>=c_cut)); %Find the neighbors of the reconstructed node
    neig_renode=[neig,nod];
    S2=S(:,neig_renode);  %Time series of neighbor nodes and reconstructed nodes
    [p,q,k,nn]=EMSCR(S2,neig);
    res_w(nod, p(1,:))=p(2,:);
    for j=1:nn
        if  length(find(comb(1,:)==q(1,j)))>0 && length(find(comb(2,:)==q(2,j)))>0
            lie=find(comb(1,:)==q(1,j) & comb(2,:)==q(2,j));
            res_tri(nod+2,lie)=q(3,j);
        end
    end
end