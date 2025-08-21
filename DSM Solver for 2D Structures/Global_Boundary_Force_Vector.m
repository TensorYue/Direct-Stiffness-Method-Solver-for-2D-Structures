function [F_Q, F_H] = Global_Boundary_Force_Vector(K_global, Boundary_Q, Boundary_Movement)
    % Force from boundary condition, use negative F_H & F_E when combining with F_Q 
    System_Degree_of_freedom = size(K_global, 1);
    F_Q = zeros(System_Degree_of_freedom, 1);

    Number_of_Boundary_Q = size(Boundary_Q, 1);
    for Boundary_Q_ID = 1 : Number_of_Boundary_Q
        Boundary_Q_Restriction = Boundary_Q(Boundary_Q_ID, 2:4);
        a = 3 * ( Boundary_Q(Boundary_Q_ID, 1) - 1 );
        Global_List = [a+1     a+2     a+3];
        for i = 1 : 3
            F_Q(Global_List(i)) = Boundary_Q_Restriction(i);
        end
    end

    U_H = zeros(System_Degree_of_freedom, 1);

    Number_of_Boundary_Movement = size(Boundary_Movement, 1);
    for Boundary_Movement_ID = 1 : Number_of_Boundary_Movement
        Boundary_Movement_Restriction = Boundary_Movement(Boundary_Movement_ID, 2:4);
        a = 3 * ( Boundary_Movement(Boundary_Movement_ID, 1) - 1 );
        Global_List = [a+1     a+2     a+3];
        for i = 1 : 3
            U_H(Global_List(i)) = Boundary_Movement_Restriction(i);
        end
    end
    
    F_H = K_global * U_H;
end