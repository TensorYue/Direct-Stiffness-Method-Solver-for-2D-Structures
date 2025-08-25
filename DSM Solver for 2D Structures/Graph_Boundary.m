function Graph_Boundary(Node_Table, Element_Table, Unit, Global_Hinge, Size_Parameter, Boundary_H, Boundary_Q, Element_Q, Boundary_Movement)
    % Plot Structure
    Number_of_Node = size(Node_Table, 1);
    Number_of_Element = size(Element_Table, 1);
    Number_of_Boundary_H = size(Boundary_H, 1);
    Number_of_Boundary_Q = size(Boundary_Q, 1);
    Number_of_Boundary_Movement = size(Boundary_Movement, 1);
    Number_of_Element_Q = size(Element_Q, 1);
    
    Discription = ['RED Square and H on Node indicate the essential boundary condition on node' newline 'Magenta Star and Q on Node indicate the natural boundary condition on node (if defined)' newline 'Magenta EQ on Element indicate the natural boundary condition on element' newline 'Green Pentagram and U on Node indicate the boundary movement on node' newline 'BLUE Solid Circle on Element indicate hinge on element end' newline 'BLUE Hollow Circle on Node indicate global hinge on node']

    Line_Width = Size_Parameter/120;
    Marker_Size = Size_Parameter/30;

    % Create Token
    Token_Node = zeros(Number_of_Node, 1);
    Token_Element = zeros(Number_of_Element, 1);

    figure;
    grid on
    hold on
    
    % Element Geometry
    for i = 1 : Number_of_Element
        Node_X = [Node_Table(Element_Table(i, 2), 1), Node_Table(Element_Table(i, 3), 1)];
        Node_Y = [Node_Table(Element_Table(i, 2), 2), Node_Table(Element_Table(i, 3), 2)];
        plot(Node_X,Node_Y, 'b', 'LineWidth',Line_Width)
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

    % Element Boundary
    for i = 1 : Number_of_Element_Q
        Node_X = [Node_Table(Element_Table(Element_Q(i, 1), 2), 1), Node_Table(Element_Table(Element_Q(i, 1), 3), 1)];
        Node_Y = [Node_Table(Element_Table(Element_Q(i, 1), 2), 2), Node_Table(Element_Table(Element_Q(i, 1), 3), 2)];
        X = sum(Node_X)/2;
        Y = sum(Node_Y)/2;
        B_1 = Element_Q(i, 2);
        B_2 = Element_Q(i, 3);
        B_3 = Element_Q(i, 4);
        B_4 = Element_Q(i, 5);
        B_5 = Element_Q(i, 6);
        [New_Line, Token_Element] = Graph_Token_Process(Element_Q(i, 1), Token_Element); % Update line space with Token
        text(X, Y, [newline New_Line New_Line '   EQ [' num2str(B_1) ', ' num2str(B_2) ', ' num2str(B_3) ', ' num2str(B_4) ', ' num2str(B_5) ']'], 'Color','magenta','FontSize',1.5*Marker_Size)
    end
    
    % Node Geometry
    for i = 1 : Number_of_Node
        if Global_Hinge(i) == 1
            X = Node_Table(i, 1);
            Y = Node_Table(i, 2);
            plot(X, Y, 'o', 'Color','blue', 'LineWidth',Line_Width, 'MarkerSize',1.5*Marker_Size)
        end
    end

    % Node Boundary
    for i = 1 : Number_of_Boundary_H
        X = Node_Table(Boundary_H(i, 1), 1);
        Y = Node_Table(Boundary_H(i, 1), 2);
        plot(X, Y, 'square', 'Color','red', 'LineWidth',Line_Width, 'MarkerSize',2*Marker_Size)
        B_1 = Boundary_H(i, 2);
        B_2 = Boundary_H(i, 3);
        B_3 = Boundary_H(i, 4);
        B_4 = Boundary_H(i, 5);
        [New_Line, Token_Node] = Graph_Token_Process(Boundary_H(i, 1), Token_Node); % Update line space with Token
        text(X, Y, [newline New_Line New_Line '   H [' num2str(B_1) ', ' num2str(B_2) ', ' num2str(B_3) ', ' num2str(B_4) ' deg' ']'], 'Color','red', 'FontSize',1.5*Marker_Size)
    end

    for i = 1 : Number_of_Boundary_Movement
        X = Node_Table(Boundary_Movement(i, 1), 1);
        Y = Node_Table(Boundary_Movement(i, 1), 2);
        plot(X, Y, 'pentagram', 'Color','green', 'LineWidth',Line_Width, 'MarkerSize',1.5*Marker_Size)
        B_1 = Boundary_Movement(i, 2);
        B_2 = Boundary_Movement(i, 3);
        B_3 = Boundary_Movement(i, 4);
        [New_Line, Token_Node] = Graph_Token_Process(Boundary_Movement(i, 1), Token_Node); % Update line space with Token
        text(X, Y, [newline New_Line New_Line '   U [' num2str(B_1) ', ' num2str(B_2) ', ' num2str(B_3) ']'], 'Color','green', 'FontSize',1.5*Marker_Size)
    end

    for i = 1 : Number_of_Boundary_Q
        X = Node_Table(Boundary_Q(i, 1), 1);
        Y = Node_Table(Boundary_Q(i, 1), 2);
        plot(X, Y, '*', 'Color','magenta', 'LineWidth',Line_Width, 'MarkerSize',1.5*Marker_Size)
        B_1 = Boundary_Q(i, 2);
        B_2 = Boundary_Q(i, 3);
        B_3 = Boundary_Q(i, 4);
        [New_Line, Token_Node] = Graph_Token_Process(Boundary_Q(i, 1), Token_Node); % Update line space with Token
        text(X, Y, [newline New_Line New_Line '   Q [' num2str(B_1) ', ' num2str(B_2) ', ' num2str(B_3) ']'], 'Color','magenta', 'FontSize',1.5*Marker_Size)
    end


    title('Graph for Boundary Condition')
    xlabel(Unit(2));
    ylabel(Unit(2));
    daspect([1 1 1])
    hold off
end   