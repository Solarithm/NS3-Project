      for i = 1:length(node_critical)
                 index_to_remove = find(obj.neighbor == node_critical(i));
                    if ~isempty(index_to_remove)
                .neighbor(index_to_remove) = [];
                obj.d(index_to_remove) = [];
                obj.link(index_to_remove) = [];
                if(isempty(obj.E_tx))
                    break;
                else
                obj.E_tx(index_to_remove) = [];
                end
                    end
      end