function [ys,params,check,exo] = bkksimple_steadystate(ys,exo,M_,options_)
% computes the steady state for ces_energy_v1.mod and uses a numerical
% solver to do so
% Inputs: 
%   - ys        [vector] vector of initial values for the steady state of
%                   the endogenous variables
%   - exo       [vector] vector of values for the exogenous variables
%   - M_        [structure] dynare model structure
%   - options_  [structure] dynare model options structure
%
%
% Output: 
%   - ys        [vector] vector of steady state values for the endogenous variables
%   - params    [vector] vector of parameter values of the model
%   - exo       [vector] vector of exogenous variables of the model

    check = false;
    options_ = options_;%#ok

    % read out parameters to access them with their name
    NumberOfParameters = M_.param_nbr;
    for ii = 1:NumberOfParameters
      paramname = char(M_.param_names(ii,:));
      eval([ paramname ' = M_.params(' int2str(ii) ');']);
      strpar.(paramname) = M_.params(ii);
    end
    
    % read out endogenous variables to access them with their name
    NumberOfEndo = M_.endo_nbr;
    strys.Init = nan;
    for ii = 1:NumberOfEndo
      varname = char(M_.endo_names(ii,:));
      strys.(varname) = ys(ii);
    end
    
    % read out exogenous variables to access them with their name
    NumberOfExo = M_.exo_nbr;
    strexo.Init = nan;
    for ii = 1:NumberOfExo
      exoname = char(M_.exo_names(ii,:));
      strexo.(exoname) = exo(ii);
    end

    %% end own model equations
    % findqtemp = @(x)findq(x, strys, strpar, strexo);
%     strys.q = fsolve (@(x) findqtemp(x), 0.5); 
    
    strys.po = strpar.pobar_p * exp(strexo.e_po);
    strys.rk = 1/strpar.beta_p  - 1 + strpar.delta_p;
    % strys.rk = strpar.alpha_p *  strys.k^(strpar.alpha_p-1) * strys.o^strpar.gamma_p;
    % strys.po = strpar.gamma_p * strys.k^strpar.alpha_p * strys.o^(strpar.gamma_p-1);
    % strys.o = strys.k*strys.rk/strys.po* strpar.gamma_p/strpar.alpha_p;
    tempterm = (strys.rk/strys.po* strpar.gamma_p/strpar.alpha_p)^(strpar.gamma_p-1);
    strys.k = (strys.po/(strpar.gamma_p*tempterm))^(1/(strpar.alpha_p + strpar.gamma_p - 1));
    strys.o = strys.k*strys.rk/strys.po* strpar.gamma_p/strpar.alpha_p;
    strys.c = strys.k^strpar.alpha_p * strys.o^strpar.gamma_p - ...
                strpar.delta_p * strys.k - strys.po * strys.o;
    strys.i = strpar.delta_p * strys.k;
    
    % check production fucntion
    % strys.y - (strpar.gamma^(1/strpar.sigma) * (strys.ae*strys.ey)^((strpar.sigma-1)/strpar.sigma) + (1-strpar.gamma)^(1/strpar.sigma) * (strys.a*strys.k^strpar.alpha*strys.n^(1-strpar.alpha))^((strpar.sigma-1)/strpar.sigma))^(strpar.sigma/(strpar.sigma-1));
    % check foc cap
    % strys.y - (strpar.gamma^(1/strpar.sigma) * (strys.ae*strys.ey)^((strpar.sigma-1)/strpar.sigma) + (1-strpar.gamma)^(1/strpar.sigma) * (strys.a*strys.k^strpar.alpha*strys.n^(1-strpar.alpha))^((strpar.sigma-1)/strpar.sigma))^(strpar.sigma/(strpar.sigma-1));
    %strys.r + strpar.delta = strys.a * (1-strpar.gamma)^(1/strpar.sigma) * (strys.a*strys.k^strpar.alpha*strys.n^(1-strpar.alpha)/strys.y)^(-1/strpar.sigma) * strpar.alpha * (strys.k/strys.n)^(strpar.alpha-1);
    for iter = 1:length(M_.params) %update parameters set in the file
      M_.params(iter) = strpar.(char(M_.param_names(iter,:)));
    end
    params = M_.params;
    
    NumberOfEndogenousVariables = M_.orig_endo_nbr; %auxiliary variables are set automatically
    for ii = 1:NumberOfEndogenousVariables
      varname = char(M_.endo_names(ii,:));
      ys(ii) = strys.(varname);
    end
    
    NumberOfExogenousVariables = M_.exo_nbr; %auxiliary variables are set automatically
    for ii = 1:NumberOfExogenousVariables
      varname = char(M_.exo_names(ii,:));
      exo(ii) = strexo.(varname);
    end
end

% function [feval, strys, strpar, strexo] = findq(x, strys, strpar, strexo)
% 
%     % as before
%     strys.q = x; 
%     strys.e = 1;
%     strys.ey = 0.5;
%     strys.ce = strys.e-strys.ey;
%     for hh = 1:strpar.hhric
%         strys.(['r' num2str(hh)]) = 1/strpar.(['beta' num2str(hh)]) - 1;
%     end
%     strys.a = strpar.a_ss;
%     strys.ae = strpar.ae_ss;
%     strpar.gamma = strys.ae^(1-strpar.sigma) * strpar.eshare * strys.q^(strpar.sigma-1);     
% 
%     % real wage from aggregate price index
%     strys.prod = 1;
%     for hh = 1:strpar.hhric 
%     strys.prod = strys.prod * (...
%                 ((strys.(['r' num2str(hh)]) + strpar.(['delta' num2str(hh)]))...
%                 /strpar.(['alpha' num2str(hh)])) ^ strpar.(['alpha' num2str(hh)]) ); 
%     end
%     strys.w = (strys.a * ((1 - strpar.gamma * strys.q^(1-strpar.sigma))/(1-strpar.gamma))^(1/(1-strpar.sigma)) / ...
%                  strys.prod)^(1/(1-strpar.sumalpha)) * (1-strpar.sumalpha);
% 
%     % as before
%     strys.y = strys.ae^(1-strpar.sigma) * strys.q^strpar.sigma * strys.ey / strpar.gamma;
%     for hh = 1:strpar.hhric
%         strys.(['k' num2str(hh)]) = strpar.(['kshare' num2str(hh)]) * strys.y / (strys.(['r' num2str(hh)]) + strpar.(['delta' num2str(hh)]));
%     end
% 
%     % aggregate labor supply from labor share
%     strys.n = strpar.nshare * strys.y / strys.w;
% 
%     % as before
%     for hh = 1:strpar.hhric
%         strys.(['i' num2str(hh)]) = strpar.(['delta' num2str(hh)])*strys.(['k' num2str(hh)]);
%     end
% 
%     % aggregate investment
%     strys.i = 0;
%     for hh = 1:strpar.hhric
%     strys.i = strys.i + strys.(['i' num2str(hh)]); 
%     end
% 
%     strys.cne = strys.y - strys.i - strys.q*strys.e; 
% 
%      for hh = 1:strpar.numberhh
% 
%         % RoT labor supply from labor supply condition % budget constraint
%         if hh > strpar.hhric 
%         strys.(['n' num2str(hh)]) = 0.5;
%        end
%      end
% 
%      % total hours worked by RoT hh
%      strys.sumnRoT = 0;
%         for hh = strpar.hhric+1 : strpar.numberhh
%             strys.sumnRoT = strys.sumnRoT + strys.(['n' num2str(hh)]);
%         end
%      strys.res = strys.n - strys.sumnRoT;
% 
%     for hh = 1:strpar.numberhh
% 
%         % define energy consumption by household
%         strys.(['ce' num2str(hh)]) = strys.ce / strpar.numberhh;
% 
%         % Ric labor supply: assume same labor hours
%         if hh <= strpar.hhric 
%         strys.(['n' num2str(hh)]) = strys.res*strpar.(['nshare' num2str(hh)]);
%         end
%     end 
% 
%     % value added
%     strys.sumk = 0;
%     for hh = 1:strpar.hhric
%     strys.sumk = strys.sumk + strpar.(['alpha' num2str(hh)])*log(strys.(['k' num2str(hh)])); 
%     end
%     strys.va = exp(log(strys.a) + (1-strpar.sumalpha)*log(strys.n) + strys.sumk);
% 
%     for hh = 1:strpar.numberhh
% 
%         % define non-energy consumption by household and capital & investment per
%         % Ricardian household
%         if hh > strpar.hhric
%             strys.(['cne' num2str(hh)]) = strys.w * strys.(['n' num2str(hh)]) - strys.q * strys.(['ce' num2str(hh)]);
%         else
%             strys.(['cne' num2str(hh)]) = strys.w * strys.(['n' num2str(hh)]) + strys.(['r' num2str(hh)]) * strys.(['k' num2str(hh)]) - strys.q * strys.(['ce' num2str(hh)]);
%         end
% 
%         % get utility weight for energy 
%         strpar.(['psi' num2str(hh)]) = (strys.q^strpar.epsilon*strys.(['ce' num2str(hh)])/strys.(['cne' num2str(hh)])) /...
%             (1+(strys.q^strpar.epsilon*strys.(['ce' num2str(hh)])/strys.(['cne' num2str(hh)])));
%         % aggregate consumption per hh
%         strys.(['c' num2str(hh)]) = (strpar.(['psi' num2str(hh)]) ^(1/strpar.epsilon)*strys.(['ce' num2str(hh)])^((strpar.epsilon-1)/strpar.epsilon) +...
%             (1-strpar.(['psi' num2str(hh)]) )^(1/strpar.epsilon)*strys.(['cne' num2str(hh)])^((strpar.epsilon-1)/strpar.epsilon))^(strpar.epsilon/(strpar.epsilon-1));
%         % hh-specific consumer price index
%         strys.(['p' num2str(hh)]) = (strpar.(['psi' num2str(hh)])*strys.q^(1-strpar.epsilon) + (1-strpar.(['psi' num2str(hh)])))^(1/(1-strpar.epsilon));
%         % marginal utility
%         strys.(['lam' num2str(hh)]) = (strys.(['p' num2str(hh)])*strys.(['c' num2str(hh)]))^(-1);   
%      end
% 
%      strys.c = 0;
%      for hh = 1:strpar.numberhh
%         % aggregate consumption
%         strys.c = strys.c + strys.(['c' num2str(hh)]);
%         % calibrate disutility parameter
%         strpar.(['al' num2str(hh)]) = strys.w * strys.(['lam' num2str(hh)]) / strys.(['n' num2str(hh)])^strpar.varphi;
%      end
% 
%     lhs = strys.w * strys.lam1;
%     rhs = strpar.al1*strys.n1^strpar.varphi;
% 
%     feval = 1-lhs/rhs;
% 
% end