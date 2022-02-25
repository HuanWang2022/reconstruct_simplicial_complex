function [F1_tri]=clc_F1_tri(triangles_pred,triangles)
%triangles: Real triangle
%triangles_pred: Predicted triangle

dim=max(max(max(triangles)),max(max(triangles_pred)));
ww_true=zeros(dim,dim,dim);
ww_pred=zeros(dim,dim,dim);
num1=size(triangles,1);       
num2=size(triangles_pred,1); 
for i=1:num1
    ww_true(triangles(i,1),triangles(i,2),triangles(i,3))=1;   
end
for j=1:num2
    ww_pred(triangles_pred(j,1),triangles_pred(j,2),triangles_pred(j,3))=1; 
end
if size(triangles_pred,1)>0
    ww=ww_true.*ww_pred;
else
    ww=zeros(dim,dim,dim);
end

TP=sum(squeeze(sum(sum(ww)))); %Number of triangles that exist and are predicted to exist
if num2>0  %Avoid 0/0
    percision=TP/num2;
else
    percision=0;
end
recall=TP/num1;
F1_tri=2/(1/recall+1/percision);