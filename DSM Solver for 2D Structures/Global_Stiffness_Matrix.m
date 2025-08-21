function K_global = Global_Stiffness_Matrix(Node_Table, Element_Table, Element_Property)
    % Global Stiffness Matrix
    Number_of_Element = size(Element_Table, 1);
    Number_of_Node = size(Node_Table, 1);
    K_global = zeros(3*Number_of_Node);

    for Element_ID = 1 : Number_of_Element
        K_element = Element_Stiffness_Matrix(Element_ID, Node_Table, Element_Table, Element_Property);

        a = 3 * ( Element_Table(Element_ID, 2) - 1 );
        b = 3 * ( Element_Table(Element_ID, 3) - 1 );

        Global_List = [a+1     a+2     a+3     b+1     b+2     b+3];

        for i = 1 : 6
            for j = 1 : 6
                K_global(Global_List(i), Global_List(j)) =  K_global(Global_List(i), Global_List(j)) + K_element(i, j);
            end
        end
    end
end