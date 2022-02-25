function main_time_Ising
%generate the time series of nodes
load RSC_w
A=w;
load RSC_triangles
B=triangles;
rho0=0.5;
T=10000;
temp=6;
J1=0.7;
J_tri=1.2;

state_nodes=cell(1,5);
for i=1:5
    state_nodes{i}=Ising_SC(A,B,rho0,T,temp,J1,J_tri);
end
save state_nodes state_nodes