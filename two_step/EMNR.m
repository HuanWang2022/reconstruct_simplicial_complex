function [p,k]=EMNR(S,nod)
%Network reconstruction EM algorithm
%  Input:
%       time series:S   
%       Reconstructed node:nod
%  Output:
%  p:The connection probability with other nodes is in two lines. 
%    The first line is the node lable, and the second line is the
%    connection probability with other nodes.
%  k:Number of iterations

[A,B]=Extract_AB(S,nod);                              %Extract useful information
[m,n]=size(A);                                        %m:Number of times; n: number of possible neighbors
x=sum(bsxfun(@times,A,B),1)./(sum(A,1)+0.00000001);   %Statistics the probability of i occurring when j occurs
A=bsxfun(@times,A,x);                                 
A=[A,ones(m,1)];                                      %Add an error term
n=n+1;

p=ones(1,n);                                          %Initialization probability
p1=zeros(1,n);
k=0;                                                  
while(sum(abs(p-p1))>0.0001)
    p1=p;
    t=bsxfun(@times,A,p);
    rho=bsxfun(@rdivide,t,(sum(t,2)+0.00000001));         %calculate rho
    p=sum(bsxfun(@times,rho,B),1)./(sum(A,1)+0.00000001); %calculate a new round of p 
    k=k+1;
end
p(end)=[];                                             
p(p<0.00001)=0;                                       
pid=1:n;
pid(nod)=[];
p=[pid;p];   %Corresponding node and score
end

function [A,B]=Extract_AB(S,nod)
%Extract A B
%Input:time series matrix: S
%      Reconstructed node:i
%Output  A B    

[m,n]=size(S);
B1=S(:,nod);         %Extract the column i
A1=S;
A1(:,nod)=[];        
t=find(B1==0);    
t(find(t==m))=[];   %Ensure that there is data at t+1 time
A=A1(t,:);          %Neighbor status at this time
B=B1(t+1,:);        %State of i at the next time
dl=find(sum(A,2)==0|sum(A,2)>=n-1);
A(dl,:)=[];
B(dl)=[];
end
