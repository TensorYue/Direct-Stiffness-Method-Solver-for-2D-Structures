function U_global = Global_Displacement(U_structural_special, TK_global, Boundary_Restriction_List, Global_Hinge_List, Boundary_Movement)
    Number_of_Variable = size(TK_global, 1);
    U_global_special = zeros(Number_of_Variable, 1);

    seed_i = 0;
    for i = 1 : Number_of_Variable
        if Boundary_Restriction_List(i) == 0 && Global_Hinge_List(i) == 0
            seed_i = seed_i + 1;
            U_global_special(i) = U_structural_special(seed_i);
        end   
    end

    U_H = zeros(Number_of_Variable, 1);

    Number_of_Boundary_Movement = size(Boundary_Movement, 1);
    for Boundary_Movement_ID = 1 : Number_of_Boundary_Movement
        Boundary_Movement_Restriction = Boundary_Movement(Boundary_Movement_ID, 2:4);
        a = 3 * ( Boundary_Movement(Boundary_Movement_ID, 1) - 1 );
        Global_List = [a+1     a+2     a+3];
        for i = 1 : 3
            U_H(Global_List(i)) = Boundary_Movement_Restriction(i);
        end
    end

    U_global = TK_global' * U_global_special + U_H;
end