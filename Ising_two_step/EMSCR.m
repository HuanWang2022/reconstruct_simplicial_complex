function [p,q,k,nn]=EMSCR(S2,neig)
%Simplicial complexes reconstruction EM algorithm
%Input:
%   S2: the time series of the reconstructed node and its neighbor nodes        
%   neig: Neighbors of reconstructed node
%Output:
%  p:The connection probability with other nodes is in two lines. 
%    The first line is the node lable, and the second line is the
%    connection probability with other nodes.
%  q:The probability of forming three-body with any two nodes.There are three lines. 
%    The first two lines are the node pair lable, and the third line is the
%    probability of forming three-body.
%  k:Number of iterations

[A,B,C]=Extract_ABC(S2);                              %Extract useful information
[m,n]=size(A);                                        %m:Number of times; n: number of possible neighbors
[mm,nn]=size(C);                                      %nn: Possible three-body number
x=sum(bsxfun(@times,A,B),1)./(sum(A,1)+0.00000001);   %Statistics the probability of i occurring when j occurs
y=sum(bsxfun(@times,C,B),1)./(sum(C,1)+0.00000001);   %Statistics the probability of i occurring when j and k occur
A=bsxfun(@times,A,x);                                
C=bsxfun(@times,C,y);   
A=[A,ones(m,1)];                                      %Add an error term
n=n+1;

p=ones(1,n);                                          %Initialization probability
p1=zeros(1,n);
q=ones(1,nn);
q1=zeros(1,nn);
k=0;                                                  
while(sum(abs(p-p1))>0.0001 || sum(abs(q-q1))>0.0001)
    p1=p;
    q1=q;
    t=bsxfun(@times,A,p);
    tt=bsxfun(@times,C,q);
    rho1=bsxfun(@rdivide,t,(sum(t,2)+sum(tt,2)+0.00000001));     %calculate rho
    rho2=bsxfun(@rdivide,tt,(sum(t,2)+sum(tt,2)+0.00000001));
    p=sum(bsxfun(@times,rho1,B),1)./(sum(A,1)+0.00000001);        %calculate a new round of p and q
    q=sum(bsxfun(@times,rho2,B),1)./(sum(C,1)+0.00000001);
    k=k+1;
end
p(end)=[];                                            
p(p<0.00001)=0;                                        
pid=neig;
p=[pid;p];    %Corresponding node and score
if length(pid)>=2
    pid2=nchoosek(pid,2);
    pid2=pid2';
    q=[pid2;q];      %Node pair and score
end
end



