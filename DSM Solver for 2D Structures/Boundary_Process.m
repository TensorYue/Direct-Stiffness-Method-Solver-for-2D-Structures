function [K_structural_special, F_structural_special, TK_global, Boundary_Restriction_List, Global_Hinge_List] = Boundary_Process(K_global, F_E, F_Q, F_H, Boundary_H, Global_Hinge)
    % Structural Stiffness Matrix
    % Could combine K_structural and F_H
    K_structural_special = [];
    F_global = F_Q - F_E - F_H;
    F_structural_special = [];
    Number_of_Variable = size(K_global, 1);
    TK_global = eye(Number_of_Variable);
    Number_of_Boundary_H = size(Boundary_H, 1);
    Boundary_Restriction_List = zeros(Number_of_Variable,1);
    for Boundary_ID = 1 : Number_of_Boundary_H
        Boundary_Direction = Boundary_H(Boundary_ID, 5);
        Boundary_Restriction = Boundary_H(Boundary_ID, 2:4);
        
        c = cosd(Boundary_Direction);
        s = sind(Boundary_Direction);
        TK_node = [c s 0; -s c 0; 0 0 1];
        
        % Evaluate TK_Global, Boundary_Restriction_List
        a = 3 * ( Boundary_H(Boundary_ID,1) - 1 ); 
        Global_List = [a+1     a+2     a+3];
        for i = 1 : 3
            Boundary_Restriction_List(Global_List(i)) = Boundary_Restriction(i); % Does not support multiple Boundary_H definition on the same node.
            for j = 1 : 3
                TK_global(Global_List(i), Global_List(j)) = TK_node(i, j);
            end
        end
    end

    K_global_special = TK_global * K_global;
    F_global_special = TK_global * F_global;
    
    % Evaluate Global_Hinge_List
    Number_of_Node = size(Global_Hinge, 1);
    Global_Hinge_List = zeros(Number_of_Variable,1);

    for Node_ID = 1 : Number_of_Node
        if Global_Hinge(Node_ID) == 1
            Global_Hinge_List(Node_ID*3) = 1;
        end
    end

    seed_i = 0;
    for i = 1 : Number_of_Variable
        if Boundary_Restriction_List(i) == 0 && Global_Hinge_List(i) == 0
            seed_i = seed_i + 1;
            seed_j = 0;
            for j = 1 : Number_of_Variable
                if Boundary_Restriction_List(j) == 0 && Global_Hinge_List(j) == 0
                    seed_j = seed_j + 1;
                    K_structural_special(seed_i, seed_j) = K_global_special(i, j);
                end
            end
            F_structural_special(seed_i, 1) = F_global_special(i, 1);
        end   
    end
end
