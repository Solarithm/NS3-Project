function [count_green, count_yellow, count_red] = analysisc_node(node, n)
  % This function analyzes the initial energy levels of nodes in a network.

  count_yellow = 0;
  count_green = 0;
  count_red = 0;

  for i = 1:n
    if 0.8 <= node(i).E_intial && node(i).E_intial < 1.5 
      count_yellow = count_yellow + 1; 
    elseif node(i).E_intial >= 1.5
      count_green = count_green + 1; 
    else
      count_red = count_red + 1; 
    end
  end
  
end