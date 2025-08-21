function F_R = Global_Boundary_Reaction(K_global, U_global, F_E, F_Q, Boundary_Restriction_List) 
    F_R = (K_global * U_global + F_E - F_Q) .* Boundary_Restriction_List; % F_H has been included in U_Global when processing
end