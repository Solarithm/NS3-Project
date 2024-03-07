%% Delete node
function DisconnectedNode(nodes, node)
    nodes(node).status = 0;
    nodes(node).E_initial = 0;
end