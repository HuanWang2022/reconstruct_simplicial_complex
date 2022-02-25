function [A,B,C]=Extract_ABC(S,nod)
%Extract A B C
%Input:  time-series:S; 
%        node to reconstruct:i
%Output:  A    the state matrix of other nodes when node i is zero at time t
%         B    the state of node i at time t+1
%         C    the state matrix of any other two nodes when node i is zero
%         at time t,state 1 indicating that they are in the active state,
%         otherwise it is 0.

[m,n]=size(S);
B1=S(:,nod);         %Extract column i
A1=S;
A1(:,nod)=[];       
t=find(B1==0);   
t(find(t==m))=[];   %Ensure that there is data at t+1 time
A=A1(t,:);          %Neighbor status at this time
B=B1(t+1,:);        %State of i at the next time
dl=find(sum(A,2)==0|sum(A,2)>=n-1);
A(dl,:)=[];
B(dl)=[];

[m,n1]=size(A);    %n1=n-1
n2=nchoosek(n1,2); %Number of columns in C
C=zeros(m,n2);
col=1;             %Locate column of C
for i=1:n1-1
    for j=i+1:n1
        C(:,col)=A(:,i).*A(:,j);
        col=col+1;
    end
end
end