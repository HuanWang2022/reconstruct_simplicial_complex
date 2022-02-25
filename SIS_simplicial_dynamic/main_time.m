function main_time
%generate the time series of nodes
load BASC_w
A=w;
load BASC_triangles
B=triangles;
beta1=0.1;
beta2=1;
mu=1;
T=10000;
rho0=0.2;
state_nodes=cell(1,5);
for i=1:5
    state_nodes{i}=SIS_RSC_2(A,B,beta1,beta2,mu,T,rho0);
end
save state_nodes state_nodes