function K_element = Element_Stiffness_Matrix(Element_ID, Node_Table, Element_Table, Element_Property)
    % Global Element Stiffness Matrix
    X_i = [Node_Table(Element_Table(Element_ID, 2), 1); Node_Table(Element_Table(Element_ID, 2), 2)];
    X_j = [Node_Table(Element_Table(Element_ID, 3), 1); Node_Table(Element_Table(Element_ID, 3), 2)];

    L = norm( X_j - X_i );
    c = ( X_j(1) - X_i(1) ) / L;
    s = ( X_j(2) - X_i(2) ) / L;

    E = Element_Property(Element_Table(Element_ID, 1), 1);
    A = Element_Property(Element_Table(Element_ID, 1), 2);
    I = Element_Property(Element_Table(Element_ID, 1), 3);

    % Consider Hinge
    hinge_1 = Element_Table(Element_ID, 4);
    hinge_2 = Element_Table(Element_ID, 5);
    
    if hinge_1 == 0 && hinge_2 == 0
        k_element = E*I/L^3 * [A*L^2/I      0           0           -A*L^2/I        0           0
                                0           12          6*L         0               -12         6*L
                                0           6*L         4*L^2       0               -6*L        2*L^2
                                -A*L^2/I    0           0           A*L^2/I         0           0
                                0           -12         -6*L        0               12          -6*L
                                0           6*L         2*L^2       0               -6*L        4*L^2];
    elseif hinge_1 == 1 && hinge_2 == 0
        k_element = E*I/L^3 * [A*L^2/I      0           0           -A*L^2/I        0           0
                                0           3           0           0               -3           3*L
                                0           0           0           0               0           0
                                -A*L^2/I    0           0           A*L^2/I         0           0
                                0           -3          0           0               3           -3*L
                                0           3*L         0           0               -3*L        3*L^2];
    elseif hinge_1 == 0 && hinge_2 == 1
        k_element = E*I/L^3 * [A*L^2/I      0           0           -A*L^2/I        0           0
                                0           3           3*L         0               -3          0
                                0           3*L         3*L^2       0               -3*L        0
                                -A*L^2/I    0           0           A*L^2/I         0           0
                                0           -3          -3*L        0               3           0
                                0           0           0           0               0           0];
    elseif hinge_1 == 1 && hinge_2 == 1
        k_element = E*I/L^3 * [A*L^2/I      0           0           -A*L^2/I        0           0
                                0           0           0           0               0           0
                                0           0           0           0               0           0
                                -A*L^2/I    0           0           A*L^2/I         0           0
                                0           0           0           0               0           0
                                0           0           0           0               0           0];   
    end

    T = [c      s       0       0       0       0
         -s     c       0       0       0       0
         0      0       1       0       0       0
         0      0       0       c       s       0
         0      0       0       -s      c       0
         0      0       0       0       0       1];

    K_element = T' * k_element * T;
end