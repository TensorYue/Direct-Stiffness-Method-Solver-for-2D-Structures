function [P_temp, V_temp, M_temp] = Element_Diagram_Integral(f_element_Q, Number_of_Point, t, dt, w_P, w_V, W_P, W_V, W_M)

    P_temp = zeros(1, Number_of_Point);
    V_temp = zeros(1, Number_of_Point);
    M_temp = zeros(1, Number_of_Point);
    % Foward Integral
    FA_b = -f_element_Q(1);
    FS_b = f_element_Q(2);
    FM_b = -f_element_Q(3);
    FA_e = f_element_Q(4);
    FS_e = -f_element_Q(5);
    FM_e = f_element_Q(6);

    if abs(FA_b) < 1e-6
        FA_b = 0;
    end
    if abs(FS_b) < 1e-6
        FS_b = 0;
    end
    if abs(FM_b) < 1e-6
        FM_b = 0;
    end
    if abs(FA_e) < 1e-6
        FA_e = 0;
    end
    if abs(FS_e) < 1e-6
        FS_e = 0;
    end
    if abs(FM_e) < 1e-6
        FM_e = 0;
    end

    P_temp(1) = FA_b + W_P(1);
    V_temp(1) = FS_b + W_V(1);
    M_temp(1) = FM_b + W_M(1);

    % if abs(P_temp(1)) < 1e-6
    %    P_temp(1) = 0;
    % end
    % if abs(V_temp(1)) < 1e-6
    %     V_temp(1) = 0;
    % end
    % if abs(M_temp(1)) < 1e-6
    %     M_temp(1) = 0;
    % end
    
    for i = 2 : Number_of_Point

        P_temp(i) = P_temp(i - 1) + W_P(i) + 0.5 * ( w_P(i-1) + w_P(i) ) * dt;
        V_temp(i) = V_temp(i - 1) - W_V(i) - 0.5 * ( w_V(i-1) + w_V(i) ) * dt;
        M_temp(i) = M_temp(i - 1) + W_M(i) + V_temp(i) * dt + ( 1/3 * w_V(i-1) + 2/3 * w_V(i) ) * 0.5 * dt^2;

        % if abs(P_temp(i)) < 1e-6
        %     P_temp(i) = 0;
        % end
        % if abs(V_temp(i)) < 1e-6
        %     V_temp(i) = 0;
        % end
        % if abs(M_temp(i)) < 1e-6
        %     M_temp(i) = 0;
        % end
    end

    % Backward Correction
    P_temp = P_temp + t./t(end) .* ( FA_e - P_temp(end));
    V_temp = V_temp + t./t(end) .* ( FS_e - V_temp(end));
    M_temp = M_temp + t./t(end) .* ( FM_e - M_temp(end));
end