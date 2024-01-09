function [i_MPC_var,dt_MPC] = AssignMPCStage(t)

% This function is used for variable MPC dt in adaptive frequency MPC %

%  gait: walking = 1; hopping = 2; running = 3

global acc_t dt_MPC_vec i_MPC_var dt_MPC i_gait gait global_t

    global_t = t;
    % stand on two feet
    if t < 0.2
        gait = 0;
    % walk
    else
        gait = 1;
        idx = find(acc_t<t - 0.2 + 1e-3);  %Find indices of nonzero elements.
        i_MPC_var = idx(end); % get current MPC stage index
        dt_MPC = dt_MPC_vec(i_MPC_var);
        idx_gait = rem(i_MPC_var,10); % get current gait index
        if gait <= 2
            if 1 <= idx_gait && idx_gait <= 5
                i_gait = 1;
            else
                i_gait = 0;
            end
        elseif  gait == 3
            if 1 <= idx_gait && idx_gait <= 4
                i_gait = 1;
            elseif 6 <= idx_gait && idx_gait <= 9
                i_gait = 0;
            else
                i_gait = 2;
    
            end
        end
    end

end