function [state_nodes]=Ising_SC(A,B,rho0,T,temp,J1,J_tri)
%Input:
%      A:           network
%      B:           Triples in networks
%      rho0:        Initial -1 node density
%      T:           Iteration steps
%      temp:       temperature
%      J1:         constant
%      J_tri:      constant
%Output:
%      state_nodes: State matrix

n=length(A);
state_nodes=zeros(T,n);
tri_num=length(B);
C=zeros(tri_num,3);   %Triplet state matrix
beta=1/temp;
state=ones(1,n);
state(randperm(n,ceil(rho0*n)))=-1;  
for t=1:T
    if length(find(state==1))>0 && length(find(state==-1))~=0  %No longer continue when full infection or full recovery
        state0=state;   %Intermediate variable        
        for j=1:tri_num
            C(j,1)=state0(B(j,1));
            C(j,2)=state0(B(j,2));
            C(j,3)=state0(B(j,3));
        end
        P=zeros(1,n);
        %%%Calculate turnover probability%%
        for ii=1:n
            part1=sum(state0(find(A(ii,:)==1))); %Sum of neighbor states of node ii
            tri_ii = C(find(B(:,1)==ii | B(:,2)==ii | B(:,3)==ii),:); %State of node ii and its triangular neighbors
            part2=sum(prod(tri_ii,2));
            deta_Ei=2*J1*state0(ii)*part1 + 2*J_tri*part2;
            P(ii)=1/(1+exp(beta*deta_Ei));
        end
        for iii=1:n
            if rand<P(iii)
                state(iii)=-state0(iii);
            end
        end   
    else                                
        state=ones(1,n);
        state(randperm(n,ceil(rho0*n)))=-1;
    end
    state_nodes(t,:)=state;
end