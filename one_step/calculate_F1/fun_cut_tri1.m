function c_cut_tri=fun_cut_tri1(b)
%Find the three-body truncation value
%Input: The probability that the reconstructed node and any two nodes in its neighbors form a three body
%Output: Get the truncation value in the vector

b_n=b(b>0);
b=[-sort(-b_n)];   %Descending order
if length(b)>1     %Avoid leaving only one value in b
    [c1,id1]=max(b(1:end-1).*(b(1:end-1)-b(2:end))./b(2:end)); %Truncation method
    c_cut_tri=b(id1);  
else
    c_cut_tri=b;
end