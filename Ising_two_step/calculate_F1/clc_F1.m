function [F1]=clc_F1(w1,w)
%w:Real matrix
%w1:Prediction matrix
w=spones(w-diag(diag(w)));
w1=spones(w1-diag(diag(w1)));
TP=length(find(w+w1==2))/2; 
FP=length(find(w-w1==-1))/2; 
FN=length(find(w-w1==1))/2; 
percision=TP/(TP+FP);
recall=TP/(TP+FN);
F1=2/(1/recall+1/percision);