clc;
clear;
run('test_Node.m'); %Chay test_Node.m

deleteNode(nodes, 10);
subplot(2,2,3);
p2 = plot(G1,'XData',x,'YData',y,'EdgeLabel', G1.Edges.Weight);
plot(G1,'XData',x,'YData',y,'EdgeLabel', G1.Edges.Weight);
[T,pred] = minspantree(G1);
highlight(p2,T,'NodeColor','g','EdgeColor','r','LineWidth',1.5);
grid on;

