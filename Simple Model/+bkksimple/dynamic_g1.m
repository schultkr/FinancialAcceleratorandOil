function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = bkksimple.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(6, 10);
g1(1,2)=1;
g1(1,1)=(-(1-params(4)+T(2)*T(7)));
g1(1,3)=1;
g1(1,4)=y(5)-T(1)*getPowerDeriv(y(4),params(2),1);
g1(1,5)=y(4);
g1(2,2)=getPowerDeriv(y(2),(-1),1);
g1(2,8)=(-((1+y(7)-params(4))*params(3)*getPowerDeriv(y(8),(-1),1)));
g1(2,7)=(-T(3));
g1(3,1)=(-(T(4)*params(2)*T(7)));
g1(3,4)=(-(T(1)*params(2)*getPowerDeriv(y(4),params(2)-1,1)));
g1(3,5)=1;
g1(4,5)=1;
g1(4,10)=(-(params(5)*exp(x(it_, 1))));
g1(5,1)=(-(1-params(4)));
g1(5,3)=1;
g1(5,6)=(-1);
g1(6,3)=(-(T(6)*params(1)*getPowerDeriv(y(3),params(1)-1,1)));
g1(6,9)=(-(T(5)*getPowerDeriv(y(9),params(2),1)));
g1(6,7)=1;

end
