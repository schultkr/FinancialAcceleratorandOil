@# define FA = 0
var c k o po i rk
@# if FA == 1
    n
    q
    r
@# endif
;
varexo e_po;
parameters alpha_p gamma_p beta_p delta_p pobar_p lFA_p
@# if FA == 1
    
@# endif
;
lFA_p = @{FA};
alpha_p=0.3;
gamma_p = 0.025;
beta_p=0.95;
delta_p=0.02;
pobar_p = 0.07;
model;
// model without financial accelerator
@# if FA == 0
    c + k + po * o = k(-1)^alpha_p * o^gamma_p + (1-delta_p)*k(-1);
    c^(-1) = beta_p*c(+1)^(-1)*(rk + 1 - delta_p);
    po = gamma_p * k(-1)^alpha_p * o^(gamma_p-1);
    po = pobar_p * exp(e_po);
    k = (1 - delta_p)*k(-1) + i;
    rk = alpha_p * k^(alpha_p-1)*o(+1)^gamma_p;
@# endif
// model with financial accelerator
@# if FA == 1
    c + k + po * o = k(-1)^alpha_p * o^gamma_p + (1-delta_p)*k(-1);
    c^(-1) = beta_p*c(+1)^(-1)*(rk + 1 - delta_p);
    po = gamma_p * k(-1)^alpha_p * o^(gamma_p-1);
    po = pobar_p * exp(e_po);
    k = (1 - delta_p)*k(-1) + i;
    rk = alpha_p * k^(alpha_p-1)*o(+1)^gamma_p;
@# endif

end;

check;
model_diagnostics;

steady;
shocks;
var e_po;
periods 1;
values 0.5;
end;

perfect_foresight_setup(periods=300);
perfect_foresight_solver;
