function [state_nodes]=SIS_RSC_2(A,B,beta1,beta2,mu,T,rho0)
%Input:
%      A:           network
%      B:           Triples in networks
%      beta1£º      Probability of infection between two-body
%      beta2£º      Probability of infection between three-body
%      mu:          Recovery rate
%      T:           Iteration steps
%      rho0:        Initial infection node density
%Output:
%      state_nodes: State matrix

n=length(A);
state_nodes=zeros(T,n);
tri_num=length(B);
C=zeros(tri_num,3);   %Triplet state matrix
state=zeros(1,n);
state(randperm(n,ceil(rho0*n)))=1;  
for t=1:T
    if length(find(state==1))>0 && length(find(state==0))~=0  %No longer continue when full infection or full recovery
        state0=state;   %Intermediate variable
        %%%Two-body infection process%%%
        I_node=find(state0==1);  
        I_num=length(I_node);
        for i=1:I_num
            neig=find(A(I_node(i),:)==1); 
            state(neig(rand(1,length(neig))<beta1))=1;
        end
        %%%Three-body infection process%%%
        for j=1:tri_num
           C(j,1)=state0(B(j,1));
           C(j,2)=state0(B(j,2));
           C(j,3)=state0(B(j,3));
        end
        tri_inf=B(find(sum(C,2)==2),:);  %Triples satisfying infection conditions
        tri_inf_num=size(tri_inf,1);     
        if tri_inf_num>0
            tri_S=zeros(1,tri_inf_num);      
            for h=1:tri_inf_num
                tri_S(h)=tri_inf(h,find(state0(tri_inf(h,:))==0));
            end
            state(tri_S(rand(1,tri_inf_num)<beta2))=1;
        end        
        %%%Recovery process%%%
        if length(find(state==1))<n 
            state(I_node(rand(1,length(I_node))<mu))=0;
        end
    else                                  
       state=zeros(1,n);
       state(randperm(n,ceil(rho0*n)))=1; 
    end
    state_nodes(t,:)=state;    
end