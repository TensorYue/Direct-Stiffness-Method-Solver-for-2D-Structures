function F_E = Global_Force_Vector(Node_Table, Element_Table, Element_Q)
    % Global Force Vector
    Number_of_Element_Q = size(Element_Q, 1);
    Number_of_Node = size(Node_Table, 1);
    F_E = zeros(3*Number_of_Node, 1);
    
    for Element_Q_ID = 1 : Number_of_Element_Q
        Element_ID = Element_Q(Element_Q_ID, 1);
        Element_Q_Type = Element_Q(Element_Q_ID, 2);
        Element_Q_Parameter = Element_Q(Element_Q_ID, 3:end);
        F_element = Element_Force_Vector(Element_ID, Node_Table, Element_Table, Element_Q_Type, Element_Q_Parameter);
        a = 3 * ( Element_Table(Element_ID, 2) - 1 );
        b = 3 * ( Element_Table(Element_ID, 3) - 1 );

        Global_List = [a+1     a+2     a+3     b+1     b+2     b+3];

        for i = 1 : 6
            F_E(Global_List(i)) = F_E(Global_List(i)) + F_element(i);
        end
    end
end