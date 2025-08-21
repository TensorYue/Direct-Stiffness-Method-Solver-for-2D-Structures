function Stability = Stability_Check(K_structural_special)
    dim = size(K_structural_special, 1);
    rk = rank(K_structural_special);
    if dim == rk
        Stability = 'Structure is stable';
    else
        Stability = 'Structure is unstable';
    end
end