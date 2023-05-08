%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'bkksimple';
M_.dynare_version = '5.4';
oo_.dynare_version = '5.4';
options_.dynare_version = '5.4';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = cell(1,1);
M_.exo_names_tex = cell(1,1);
M_.exo_names_long = cell(1,1);
M_.exo_names(1) = {'e_po'};
M_.exo_names_tex(1) = {'e\_po'};
M_.exo_names_long(1) = {'e_po'};
M_.endo_names = cell(6,1);
M_.endo_names_tex = cell(6,1);
M_.endo_names_long = cell(6,1);
M_.endo_names(1) = {'c'};
M_.endo_names_tex(1) = {'c'};
M_.endo_names_long(1) = {'c'};
M_.endo_names(2) = {'k'};
M_.endo_names_tex(2) = {'k'};
M_.endo_names_long(2) = {'k'};
M_.endo_names(3) = {'o'};
M_.endo_names_tex(3) = {'o'};
M_.endo_names_long(3) = {'o'};
M_.endo_names(4) = {'po'};
M_.endo_names_tex(4) = {'po'};
M_.endo_names_long(4) = {'po'};
M_.endo_names(5) = {'i'};
M_.endo_names_tex(5) = {'i'};
M_.endo_names_long(5) = {'i'};
M_.endo_names(6) = {'rk'};
M_.endo_names_tex(6) = {'rk'};
M_.endo_names_long(6) = {'rk'};
M_.endo_partitions = struct();
M_.param_names = cell(6,1);
M_.param_names_tex = cell(6,1);
M_.param_names_long = cell(6,1);
M_.param_names(1) = {'alpha_p'};
M_.param_names_tex(1) = {'alpha\_p'};
M_.param_names_long(1) = {'alpha_p'};
M_.param_names(2) = {'gamma_p'};
M_.param_names_tex(2) = {'gamma\_p'};
M_.param_names_long(2) = {'gamma_p'};
M_.param_names(3) = {'beta_p'};
M_.param_names_tex(3) = {'beta\_p'};
M_.param_names_long(3) = {'beta_p'};
M_.param_names(4) = {'delta_p'};
M_.param_names_tex(4) = {'delta\_p'};
M_.param_names_long(4) = {'delta_p'};
M_.param_names(5) = {'pobar_p'};
M_.param_names_tex(5) = {'pobar\_p'};
M_.param_names_long(5) = {'pobar_p'};
M_.param_names(6) = {'lFA_p'};
M_.param_names_tex(6) = {'lFA\_p'};
M_.param_names_long(6) = {'lFA_p'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 6;
M_.param_nbr = 6;
M_.orig_endo_nbr = 6;
M_.aux_vars = [];
M_ = setup_solvers(M_);
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
M_.surprise_shocks = [];
M_.heteroskedastic_shocks.Qvalue_orig = [];
M_.heteroskedastic_shocks.Qscale_orig = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
M_.orig_eq_nbr = 6;
M_.eq_nbr = 6;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 0 2 8;
 1 3 0;
 0 4 9;
 0 5 0;
 0 6 0;
 0 7 0;]';
M_.nstatic = 3;
M_.nfwrd   = 2;
M_.npred   = 1;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 1;
M_.ndynamic   = 3;
M_.dynamic_tmp_nbr = [6; 1; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , '1' ;
  2 , 'name' , '2' ;
  3 , 'name' , 'po' ;
  4 , 'name' , '4' ;
  5 , 'name' , 'k' ;
  6 , 'name' , 'rk' ;
};
M_.mapping.c.eqidx = [1 2 ];
M_.mapping.k.eqidx = [1 3 5 6 ];
M_.mapping.o.eqidx = [1 3 6 ];
M_.mapping.po.eqidx = [1 3 4 ];
M_.mapping.i.eqidx = [5 ];
M_.mapping.rk.eqidx = [2 6 ];
M_.mapping.e_po.eqidx = [4 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [2 ];
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(6, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(6, 1);
M_.endo_trends = struct('deflator', cell(6, 1), 'log_deflator', cell(6, 1), 'growth_factor', cell(6, 1), 'log_growth_factor', cell(6, 1));
M_.NNZDerivatives = [19; -1; -1; ];
M_.static_tmp_nbr = [5; 3; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
M_.params(6) = 0;
lFA_p = M_.params(6);
M_.params(1) = 0.3;
alpha_p = M_.params(1);
M_.params(2) = 0.025;
gamma_p = M_.params(2);
M_.params(3) = 0.95;
beta_p = M_.params(3);
M_.params(4) = 0.02;
delta_p = M_.params(4);
M_.params(5) = 0.07;
pobar_p = M_.params(5);
oo_.dr.eigval = check(M_,options_,oo_);
model_diagnostics(M_,options_,oo_);
steady;
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',1,'multiplicative',0,'periods',1:1,'value',0.5) ];
M_.exo_det_length = 0;
options_.periods = 300;
perfect_foresight_setup;
perfect_foresight_solver;


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'bkksimple_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bkksimple_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bkksimple_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bkksimple_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bkksimple_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bkksimple_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bkksimple_results.mat'], 'oo_recursive_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
