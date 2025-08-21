function Graph_Highlight_Element(Element_ID, Node_Table, Element_Table, Unit, Global_Hinge, Size_Parameter, Boundary_H, Boundary_Q, Element_Q, Boundary_Movement)
    Graph_Boundary(Node_Table, Element_Table, Unit, Global_Hinge, Size_Parameter, Boundary_H, Boundary_Q, Element_Q, Boundary_Movement)
    hold on
    Line_Width = Size_Parameter/120;
    Marker_Size = Size_Parameter/30;
    Number_of_Element = size(Element_Table, 1);
    for i = 1 : Number_of_Element
        if i == Element_ID
            Node_X = [Node_Table(Element_Table(i, 2), 1), Node_Table(Element_Table(i, 3), 1)];
            Node_Y = [Node_Table( Element_Table(i, 2), 2), Node_Table(Element_Table(i, 3), 2)];
            X_i = [Node_Table(Element_Table(i, 2), 1); Node_Table(Element_Table(i, 2), 2)];
            X_j = [Node_Table(Element_Table(i, 3), 1); Node_Table(Element_Table(i, 3), 2)];
            L = norm( X_j - X_i );
            c = ( X_j(1) - X_i(1) ) / L;
            s = ( X_j(2) - X_i(2) ) / L;
            Loc = X_j-0.05*L *[c; s];
            plot(Loc(1), Loc(2), '^', 'Color','red', 'LineWidth',2*Line_Width, 'MarkerSize',2*Line_Width);
            Discription = 'Triangle indicates the end of the member'
            plot(Node_X,Node_Y, 'r', 'LineWidth',Line_Width)
            hinge_1 = Element_Table(i, 4);
            hinge_2 = Element_Table(i, 5);
            if hinge_1 == 1
                X_i = [Node_Table(Element_Table(i, 2), 1); Node_Table(Element_Table(i, 2), 2)];
                X_j = [Node_Table(Element_Table(i, 3), 1); Node_Table(Element_Table(i, 3), 2)];
                L = norm( X_j - X_i );
                c = ( X_j(1) - X_i(1) ) / L;
                s = ( X_j(2) - X_i(2) ) / L;
                Loc = X_i+0.1*L *[c; s];
                plot(Loc(1), Loc(2), 'o', 'Color','red', 'LineWidth',2*Line_Width, 'MarkerSize',2*Line_Width)
            elseif hinge_2 == 1
                X_i = [Node_Table(Element_Table(i, 2), 1); Node_Table(Element_Table(i, 2), 2)];
                X_j = [Node_Table(Element_Table(i, 3), 1); Node_Table(Element_Table(i, 3), 2)];
                L = norm( X_j - X_i );
                c = ( X_j(1) - X_i(1) ) / L;
                s = ( X_j(2) - X_i(2) ) / L;
                Loc = X_j-0.1*L *[c; s];
                plot(Loc(1), Loc(2), 'o', 'Color','red', 'LineWidth',2*Line_Width, 'MarkerSize',2*Line_Width)
            end
        end
    end
    title(['Highlighted Element ' num2str(Element_ID)])
    hold off
end