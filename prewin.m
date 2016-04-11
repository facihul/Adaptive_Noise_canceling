
function A =prewin(u,M,col)


A=zeros(col,M);
for i=1:M
   A(i:end,i)=u(1:end-i+1); 
end

end