function xnext = euler2(xdot,x,h)
% EULER2  Integrate a system of ordinary differential equations using 
%	  Euler's method (first order: one forward Euler step).
%
% xnext = euler2(xdot,x,h)
%
% xdot  - dx/dt(k) = f(x(k)
% x     - x(k)
% xnext - x(k+1)
% h     - step size
%
% Author:   Thor I. Fossen
% Date:     14th June 2001
% Revisions: 2026-10-09 help text: first-order method (was "2nd-order")

xnext = x + h*xdot;