function Graph_Initial(Node_Table, Element_Table, Unit, Size_Parameter)
    % Plot Structure
    Number_of_Node = size(Node_Table, 1);
    Number_of_Element = size(Element_Table, 1);
    
    Line_Width = Size_Parameter/120;
    Marker_Size = Size_Parameter/30;
    
    figure;
    grid on
    hold on

    for i = 1 : Number_of_Element
        Node_X = [Node_Table(Element_Table(i, 2), 1), Node_Table(Element_Table(i, 3), 1)];
        Node_Y = [Node_Table(Element_Table(i, 2), 2), Node_Table(Element_Table(i, 3), 2)];
        plot(Node_X,Node_Y, 'b', 'LineWidth',Line_Width)
        X = sum(Node_X)/2;
        Y = sum(Node_Y)/2;
        text(X, Y, [newline 'Elem' ' ' num2str(i)], 'Color','red','FontSize',1.5*Marker_Size)
        hinge_1 = Element_Table(i, 4);
        hinge_2 = Element_Table(i, 5);
        if hinge_1 == 1
            X_i = [Node_Table(Element_Table(i, 2), 1); Node_Table(Element_Table(i, 2), 2)];
            X_j = [Node_Table(Element_Table(i, 3), 1); Node_Table(Element_Table(i, 3), 2)];
            L = norm( X_j - X_i );
            c = ( X_j(1) - X_i(1) ) / L;
            s = ( X_j(2) - X_i(2) ) / L;
            Loc = X_i+0.1*L *[c; s];
            plot(Loc(1), Loc(2), 'o', 'Color','blue', 'LineWidth',2*Line_Width, 'MarkerSize',2*Line_Width)
        end
        if hinge_2 == 1
            X_i = [Node_Table(Element_Table(i, 2), 1); Node_Table(Element_Table(i, 2), 2)];
            X_j = [Node_Table(Element_Table(i, 3), 1); Node_Table(Element_Table(i, 3), 2)];
            L = norm( X_j - X_i );
            c = ( X_j(1) - X_i(1) ) / L;
            s = ( X_j(2) - X_i(2) ) / L;
            Loc = X_j-0.1*L *[c; s];
            plot(Loc(1), Loc(2), 'o', 'Color','blue', 'LineWidth',2*Line_Width, 'MarkerSize',2*Line_Width)
        end
    end
    
    for i = 1 : Number_of_Node
        X = Node_Table(i, 1);
        Y = Node_Table(i, 2);
        text(X, Y, [newline 'Node' ' ' num2str(i)], 'Color','red','FontSize',1.5*Marker_Size)
    end

    title('Graph for Node and Element')
    xlabel(Unit(2));
    ylabel(Unit(2));

    hold off
end