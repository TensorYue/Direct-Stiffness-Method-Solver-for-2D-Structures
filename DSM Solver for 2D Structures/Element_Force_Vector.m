function F_element = Element_Force_Vector(Element_ID, Node_Table, Element_Table, Element_Q_Type, Element_Q_Parameter)
    % Global Element Force Vector
    X_i = [Node_Table(Element_Table(Element_ID, 2), 1); Node_Table(Element_Table(Element_ID, 2), 2)];
    X_j = [Node_Table(Element_Table(Element_ID, 3), 1); Node_Table(Element_Table(Element_ID, 3), 2)];

    L = norm( X_j - X_i );
    c = ( X_j(1) - X_i(1) ) / L;
    s = ( X_j(2) - X_i(2) ) / L;
    
    l_1 = L * Element_Q_Parameter(3);
    l_2 = L * Element_Q_Parameter(4);

    if Element_Q_Type == 1
        W = Element_Q_Parameter(1);

        FS_b = W * l_2^2 / L^3 * ( 3 * l_1 + l_2 );
        FM_b = W * l_1 * l_2^2 / L^2;
        FS_e = W * l_1^2 / L^3 * ( l_1 + 3 * l_2 );
        FM_e = - W * l_1^2 * l_2 / L^2;
        FA_b = 0;
        FA_e = 0;
    elseif Element_Q_Type == 2
        M = Element_Q_Parameter(1);

        FS_b = - 6 * M * l_1 * l_2 / L^3;
        FM_b = M * l_2 / L^2 * ( l_2 - 2 * l_1);
        FS_e = 6 * M * l_1 * l_2 / L^3;
        FM_e = M * l_1 / L^2 * ( l_1 - 2 * l_2);
        FA_b = 0;
        FA_e = 0;
    elseif Element_Q_Type == 3
        w = Element_Q_Parameter(1);

        FS_b = w * L / 2 * ( 1 - l_1 / L^4 * ( 2 * L^3 - 2 * l_1^2 * L + l_1^3 ) - l_2^3 / L^4 * ( 2 * L - l_2 ) );
        FM_b = w * L^2 / 12 * ( 1 - l_1^2 / L^4 * ( 6 * L^2 - 8 * l_1 * L + 3 * l_1^2 ) - l_2^3 / L^4 * ( 4 * L - 3 * l_2 ) );
        FS_e = w * L / 2 * ( 1 - l_1^3 / L^4 * ( 2 * L - l_1 ) - l_2 / L^4 * ( 2 * L^3 - 2 * l_2^2*L + l_2^3 ) );
        FM_e = - w * L^2 / 12 * ( 1 - l_1^3 / L^4 * ( 4 * L - 3 * l_1 ) - l_2^2 / L^4 * ( 6 * L^2 - 8 * l_2 * L + 3 * l_2^2 ) );
        FA_b = 0;
        FA_e = 0;
    elseif Element_Q_Type == 4
        w_1 = Element_Q_Parameter(1);
        w_2 = Element_Q_Parameter(2);

        FS_b = w_1*(L - l_1)^3/(20*L^3)*( (7*L+8*l_1) - l_2*(3*L+2*l_1)/(L-l_1) * ( 1 + l_2/(L-l_1) + l_2^2/(L-l_1)^2 ) + 2*l_2^4/(L-l_1)^3 ) + w_2*(L-l_1)^3/(20*L^3) * ( (3*L+2*l_1) * ( 1 + l_2/(L-l_1) + l_2^2/(L-l_1)^2 ) - l_2^3/(L-l_1)^2* ( 2 + (15*L-8*l_2)/(L-l_1) ) );
        FM_b = w_1*(L - l_1)^3/(60*L^2)*( 3*(L+4*l_1) - l_2*(2*L+3*l_1)/(L-l_1) * ( 1 + l_2/(L-l_1) + l_2^2/(L-l_1)^2 ) + 3*l_2^4/(L-l_1)^3 ) + w_2*(L-l_1)^3/(60*L^2) * ( (2*L+3*l_1) * ( 1 + l_2/(L-l_1) + l_2^2/(L-l_1)^2 ) - 3*l_2^3/(L-l_1)^2* ( 1 + (5*L-4*l_2)/(L-l_1) ) );
        FS_e = (w_1+w_2) / 2*(L-l_1-l_2) - FS_b;
        FM_e = ( L - l_1 - l_2 ) / 6 * ( w_1*(-2*L+2*l_1-l_2) - w_2*(L-l_1+2*l_2) ) + FS_b * L - FM_b;
        FA_b = 0;
        FA_e = 0;
    elseif Element_Q_Type == 5
        W = Element_Q_Parameter(1);

        FA_b = W * l_2 / L;
        FA_e = W * l_1 / L;
        FS_b = 0;
        FM_b = 0;
        FS_e = 0;
        FM_e = 0;
    elseif Element_Q_Type == 6  
        w = Element_Q_Parameter(1);

        FA_b = w / 2 / L * ( L - l_1 - l_2 ) * ( L - l_1 + l_2 );
        FA_e = w / 2 / L * ( L - l_1 - l_2 ) * ( L + l_1 - l_2 );
        FS_b = 0;
        FM_b = 0;
        FS_e = 0;
        FM_e = 0;
    end
    
    % Consider Hinge
    hinge_1 = Element_Table(Element_ID, 4);
    hinge_2 = Element_Table(Element_ID, 5);
    if hinge_1 == 0 && hinge_2 == 0
        f_element = [FA_b    FS_b    FM_b    FA_e    FS_e    FM_e]';
    elseif hinge_1 == 1 && hinge_2 == 0
        f_element = [FA_b    FS_b    0    FA_e    FS_e    FM_e]'    + [0    -3/(2*L)*FM_b       0           0       3/(2*L)*FM_b    -1/2*FM_b]';
    elseif hinge_1 == 0 && hinge_2 == 1
        f_element = [FA_b    FS_b    FM_b    FA_e    FS_e    0]'    + [0    -3/(2*L)*FM_e       -1/2*FM_e   0       3/(2*L)*FM_e    0]';
    elseif hinge_1 == 1 && hinge_2 == 1
        f_element = [FA_b    FS_b    0    FA_e    FS_e    0]'       + [0    -1/L*(FM_e+FM_b)    0           0       1/L*(FM_e+FM_b) 0]'; 
    end

    T = [c      s       0       0       0       0
         -s     c       0       0       0       0
         0      0       1       0       0       0
         0      0       0       c       s       0
         0      0       0       -s      c       0
         0      0       0       0       0       1];

    F_element = T' * f_element;
end