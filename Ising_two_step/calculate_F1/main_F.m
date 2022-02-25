function main_F
load('res1.mat')
load('res2.mat')
load('RSC_w.mat')
load('RSC_triangles.mat')
[row,column]=size(res1);
index_F1=zeros(row,column);
index_F1_tri=zeros(row,column);
for i=1:column
    for j=1:row        
        w_01_01=res1{j,i};  %The final w is saved in the form of 0 and 1 matrices
        tri=res2{j,i};
        [w_01,triangles_pred]=fun_cut_w_tri2(w_01_01,tri);
        [F1]=clc_F1(w_01,w);
        [F1_tri]=clc_F1_tri(triangles_pred,triangles);
        index_F1(j,i)=F1;
        index_F1_tri(j,i)=F1_tri;
    end
end
index_F1=mean(index_F1,2)
index_F1_tri=mean(index_F1_tri,2)
save index_F1 index_F1
save index_F1_tri index_F1_tri
