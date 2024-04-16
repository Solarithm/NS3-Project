    n=30;
node(1,n) = Nodes();
node_critical = [2,9,10,11,12,15,17,20,28,29];

  MST_global = Prim_hirechical(node_critical,1,30,node,n);
