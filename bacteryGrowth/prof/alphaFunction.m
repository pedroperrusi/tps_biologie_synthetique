function ypoint = alphaFunction (t, y)
	 
	 global selector t_limit tau
     
     %  selector
	 %  1 = model constant
     %  2 = model exp
     
     % Equation set
     if selector == 1,
        % constant
        if t < t_limit,
            ypoint(1) = 0;
        else,
            ypoint(1) = 1;
        end
        
     else,
        % exp model
        ypoint(1) = 1 - exp(-t/tau)
        
     end
     
     ypoint = ypoint';