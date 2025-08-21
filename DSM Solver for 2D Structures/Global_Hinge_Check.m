function Global_Hinge = Global_Hinge_Check(Node_Table, Element_Table)
    Number_of_Node = size(Node_Table, 1);
    Number_of_Element = size(Element_Table, 1);
    Node_Connected_Element = zeros(Number_of_Node, 1); 
    Node_Element_Hinge = zeros(Number_of_Node, 1);
    for Element_ID = 1 : Number_of_Element
        Node_Connected_Element(Element_Table(Element_ID, 2)) = Node_Connected_Element(Element_Table(Element_ID, 2)) + 1;
        Node_Connected_Element(Element_Table(Element_ID, 3)) = Node_Connected_Element(Element_Table(Element_ID, 3)) + 1;
        Node_Element_Hinge(Element_Table(Element_ID, 2)) = Node_Element_Hinge(Element_Table(Element_ID, 2)) + Element_Table(Element_ID, 4);
        Node_Element_Hinge(Element_Table(Element_ID, 3)) = Node_Element_Hinge(Element_Table(Element_ID, 3)) + Element_Table(Element_ID, 5);
    end
    Global_Hinge = (Node_Connected_Element == Node_Element_Hinge);
end