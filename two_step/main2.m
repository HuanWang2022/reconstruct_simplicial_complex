%function main2
load('state_nodes.mat')
T=1000:1000:10000; %the length of time series
ave_number=5; %average number of times
res1=cell(length(T),ave_number); %save two-body results
res2=cell(length(T),ave_number); %save three-body results
for i=1:ave_number
    SS=state_nodes{i};
    for j=1:length(T)
        [res_w,res_tri]=clc_w_tri(SS(1:T(j),:));
        res1{j,i}=res_w;
        res2{j,i}=res_tri;         
    end
    save('res1', 'res1','-v7.3')
    save('res2', 'res2','-v7.3')   
end



