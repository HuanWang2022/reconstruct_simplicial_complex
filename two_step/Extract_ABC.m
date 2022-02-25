function [A,B,C]=Extract_ABC(S2)
%Extract A B C
%Input:The time series matrix of the node to be reconstructed and its neighbor nodes:S2
%      Reconstructed node:i
%Output: A    the state matrix of neighbor nodes when node i is zero at time t
%        B    the state of node i at time t+1
%        C    the state matrix of any two nodes in its neighbor when node i is zero
%         at time t,state 1 indicating that they are in the active state,
%         otherwise it is 0.

[m,n_r]=size(S2);     %Number of reconstructed nodes and their neighbors
B1=S2(:,n_r);         %Extract the last column
A1=S2;
A1(:,n_r)=[];        
t=find(B1==0);     
t(find(t==m))=[];   %Ensure that there is data at t+1 time
A=A1(t,:);          %Neighbor status at this time
B=B1(t+1,:);        %State of i at the next time

[m,n1]=size(A);     %n1=n_r-1
if n1<2
    C=zeros(m,1);   %Only one neighbor node
else
    n2=nchoosek(n1,2); %Number of columns in C
    C=zeros(m,n2);
    col=0;            
    for i=1:n1-1
        for j=i+1:n1
            col=col+1;
            C(:,col)=A(:,i).*A(:,j);
        end
    end
end
end
