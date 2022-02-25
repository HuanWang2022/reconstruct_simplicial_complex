function [A,B,C]=Extract_ABC(S2)
%Extract A B C
%Input:The time series matrix of the node to be reconstructed and its neighbor nodes:S2
%      Reconstructed node:i
%Output: A    the state matrix of neighbor nodes when node i is zero at time t
%        B    the state of node i at time t+1
%        C    the state matrix of any two nodes in its neighbor when node i is zero
%         at time t,state 1 indicating that they are in the active state,
%         otherwise it is 0.

S1_two=S2; 
S1_two(S1_two==-1)=0; %Replace all -1 with 0
S2_two=S2;
S2_two(S2_two==1)=0;
S2_two(S2_two==-1)=1;
S_two=[S1_two;S2_two]; %Store the second step two-body matrix: S_two
%%%%%%%%%%%%%%%
[m,n_r]=size(S_two);     %Number of reconstructed nodes and their neighbors
B1=S_two(:,n_r);         %Extract the last column
A1=S_two;
A1(:,n_r)=[];       
t=find(B1==0);     
t(find(t==m))=[];   %Ensure that there is data at t+1 time
A=A1(t,:);          %Neighbor status at this time
B=B1(t+1,:);        %State of i at the next time

[m,n1]=size(A);    %n1=n_r-1
if n1<2
    C=zeros(m,1);  %Only one neighbor node
else
    %%%%%%% Store the product of any two neighbor nodes when i = -1 %%%%%%%
    S22=S2(find(S2(:,n_r)==-1),:);
    S22(:,n_r)=[];
    col=0;  
    S_three1=[];
    for i=1:n1-1
        for j=i+1:n1
            col=col+1;
            S_three1(:,col)=S22(:,i).*S22(:,j);
        end
    end
    S_three1(S_three1==-1)=0; %Replace all -1 with 0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% The product of any two neighbor nodes when i = 1 %%%%%%%
    S22=S2(find(S2(:,n_r)==1),:);
    S22(:,n_r)=[];
    col=0;  
    S_three2=[];
    for i=1:n1-1
        for j=i+1:n1
            col=col+1;
            S_three2(:,col)=S22(:,i).*S22(:,j);
        end
    end
    S_three2(S_three2==1)=0; 
    S_three2(S_three2==-1)=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    C=[S_three1;S_three2];
    if B1(end,:)==0 %In order to keep the row number dimension of C and A consistent
        C(end,:)=[];
    end
end
end
