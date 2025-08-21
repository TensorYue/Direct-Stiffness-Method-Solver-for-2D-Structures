function [New_Line, Token] = Graph_Token_Process(ID, Token)
    New_Line = zeros(1, Token(ID));
    for i = 1 : Token(ID)
        New_Line(i) = newline;
    end
    Token(ID) = Token(ID) + 1;
end