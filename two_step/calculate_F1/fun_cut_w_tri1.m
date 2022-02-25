function [w_01,triangles_pred]=fun_cut_w_tri1(w_01_01,tri)
w_01=zeros(length(w_01_01),length(w_01_01));
triangles1=[];

%Truncate the final two-body matrices
for i=1:length(w_01_01)
    a=w_01_01(i,:);
    a(a>0)=1;
    a(a<=0)=0;
    w_01(i,:)=a;
end
w_01=w_01+w_01'; 
w_01(w_01==2)=1;

%Truncate the final three-body 
for i=1:length(w_01)
    neig=find(w_01(i,:)==1);
    b=tri(i+2,:);
    a=w_01_01(i,:);
    ave=mean(a(find(a>0.001)));
    b(find(b<=ave))=0;  
    if length(find(b>0))>0
        c_cut_tri=fun_cut_tri1(b);
        if size(c_cut_tri,2)>0  %The node needs to exist in a three-body
            tri_neig=tri(1:2,find(tri(i+2,:)>=c_cut_tri)); %the node pair of form a three-body with the reconstructed node
            nneig=setdiff(tri_neig,neig);  %Non neighbor nodes
            tri_neig(:,find(sum(ismember(tri_neig,nneig), 1)))=[] ; %Delete the false three-body
            tri_neig=tri_neig';
            tn=size(tri_neig,1);
            triangles1=[triangles1;i*ones(tn,1),tri_neig]; 
        end
    end
end
triangles2=sortrows(sort(triangles1,2),1); 
triangles_pred=unique(triangles2,'rows');

%Set the conditions for the existence of three-body
num_triangles_pred=size(triangles_pred,1);  
number_triangles_pred=[triangles_pred,zeros(num_triangles_pred,1)]; %Add a column of record times
for j=1:num_triangles_pred
    number_triangles_pred(j,4)=length(find(triangles2(:,1)==triangles_pred(j,1) & triangles2(:,2)==triangles_pred(j,2)  & triangles2(:,3)==triangles_pred(j,3) )); 
end
triangles_pred(find(number_triangles_pred(:,4)==1),:)=[];









