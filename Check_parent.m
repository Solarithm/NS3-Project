function Check_parent(MST,node)
        parent = MST(:,1);
        child = MST(:,2);
        
for i = 1: max(MST(:,2))
            index_col = find(i == parent);
            index_col2 = find(i == child);
            c = child(index_col);
            c2 = parent(index_col2);
            node(i).child = c;
            if(i == 1)
                node(i).parent = 0;
            else
                
                node(i).parent = c2;
            end
end

end