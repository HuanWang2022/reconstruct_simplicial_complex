function c_cut=fun_cut(a)
%Find the two-body truncation value
%Input: Connection probability between reconstructed node and other nodes
%Output: Get the truncation value in the vector

aveave=mean(a(find(a<=mean(a)))); 
a_c=min(aveave,1/length(a));  
if a_c>0
    a_n=a(a>a_c);
    b=[-sort(-a_n),a_c];   %Descending order
    [c1,id1]=max(b(1:end-1).*(b(1:end-1)-b(2:end))./b(2:end)); %Truncation method, the first
    bb=b;
    b(1:id1)=[];
    if length(b)==1
        c_cut=bb(id1);  
    else
        [c1,id1]=max(b(1:end-1).*(b(1:end-1)-b(2:end))./b(2:end)); %Truncation method, the second
        c_cut=b(id1);  
    end
else
    c_cut=0.000001;
end