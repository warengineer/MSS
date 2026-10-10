# Branch `course-v1.0`: changes and notes

This branch is the version of MSS used by the course *Marine Craft Hydrodynamics and Motion Control* (Prof. Dr. Serhat
YILMAZ, Volkan AKILLI). It starts from commit [724f267c36](https://github.com/cybergalactic/MSS/commit/724f267c36) of
[cybergalactic/MSS](https://github.com/cybergalactic/MSS) (7 Oct 2026) and adds 27 small corrections, one commit each.
Nothing else is changed. The `master` branch of this fork is that upstream commit, so
[master...course-v1.0](https://github.com/warengineer/MSS/compare/master...course-v1.0) shows every changed line. MSS
and these changes are under the MIT licence of MSS ([LICENSE](LICENSE)).

Part 1 lists the corrections. Part 2 lists observations that the course documents but leaves unchanged in the m-files.
The values come from runs of this branch in MATLAB R2026b and from the Python checks of the course.

## Part 1: Corrections

### Code (15 commits)

| Commit | File | Change |
|---|---|---|
| [6a46a74](https://github.com/warengineer/MSS/commit/6a46a74) | `mssExamples/exSMC.m` | `switch flag` with `case 1` and `case 2`. `case flag==1` compared `flag` with the value of the logical expression (0 or 1), so `flag = 2` ran the `otherwise` branch (`sat`) and `tanh` was never used. |
| [c6b988f](https://github.com/warengineer/MSS/commit/c6b988f) | `mssExamples/exSpline.m` | Interpolates at the path variable `varpi`; the script used the undefined variable `t`. |
| [dbb4d93](https://github.com/warengineer/MSS/commit/dbb4d93) | `GNC/crosstrackWpt3D.m` | `R_z(2,1) = sin(pi_h)`, the rotation matrix of `ALOS3D.m`. With `-sin(pi_h)` R_z was not a rotation: the cross-track error was unaffected, the along-track and vertical-track errors were wrong. |
| [ecc5921](https://github.com/warengineer/MSS/commit/ecc5921) | `LIBRARY/environment/isherwood72.m` | The relative wind angle is wrapped to [−π, π) before the tables and the signs of Y and N. An angle in (180°, 360°) took the sign of the unwrapped angle (wind from port gave a force to port), and for a vector of angles the mapping to 0–180° was applied only if all angles exceeded 180°. |
| [912de70](https://github.com/warengineer/MSS/commit/912de70) | `LIBRARY/environment/blendermann94.m` | C_N = (s_L/L_oa − 0.18 (γ_r − π/2)) C_Y holds for 0 ≤ γ_r ≤ π; it is now evaluated with the absolute value of γ_r (wrapped to [−π, π)), so C_N is antisymmetric like C_Y. At −90° C_N was −0.5035 instead of −0.0229 (vessel 11). |
| [c4b7bfd](https://github.com/warengineer/MSS/commit/c4b7bfd) | `mssExamples/exINSwaveFilter.m`, `mssExamples/exWaveFreqObserver.m` | `c2d` with the method `'tustin'`; it was spelled `'tutsin'` (MATLAB R2026b and GNU Octave accepted the misspelling). |
| [b77d757](https://github.com/warengineer/MSS/commit/b77d757) | `LIBRARY/kinematics/euler2q.m` | Normalizes with `norm(q)`; `q'*q` is the squared norm. The quaternion has unit norm by construction, so results change only at rounding level. |
| [e6dbde3](https://github.com/warengineer/MSS/commit/e6dbde3) | `GNC/utils/conversion.m` | Exact knot factors `MS2KNOTS = 3600/1852` and `KNOTS2MS = 1852/3600` (were 1.94270 and 0.51475). The comments of `D2R` and `R2D` were swapped. |
| [236a54b](https://github.com/warengineer/MSS/commit/236a54b) | `LIBRARY/motionSickness/HMmsi.m` | The encounter frequency enters μ_MSI in rad/s. With Hz the most provocative frequency lay at 1 Hz = 6.28 rad/s; with rad/s it lies at 1 rad/s = 0.16 Hz, close to the 0.167 Hz measured by McCauley et al. (1976). |
| [6b94ade](https://github.com/warengineer/MSS/commit/6b94ade) | `mssExamples/exResonance.m` | The heave curve is `w3^2./Zm3w`, the amplitude ratio ω_n²/(ω_e Z_m) used for roll and pitch. It was `w3^3./Zm3w`, scaled by ω₃ (0.9516 rad/s with `supply.mat`: 4.8 % low). |
| [e25f8a7](https://github.com/warengineer/MSS/commit/e25f8a7) | `LIBRARY/kinematics/llh2flat.m` | `dl = ssa(l - l0)`, as `flat2llh.m` wraps the longitude. For a point across the 180° meridian from the origin, y_n was off by 2π(R_N + h_ref) cos μ₀. |
| [b131090](https://github.com/warengineer/MSS/commit/b131090) | `HYDRO/utils/natfrequency.m` | 6-DOF option: the eigenvalues of the 2 × 2 heave–pitch block are sorted at each frequency; in `eig` order the modes could swap. With the WAMIT `tanker.mat` the 6-DOF periods (heave, roll, pitch) are 9.8227 / 12.4498 / 8.9282 s instead of 9.8227 / 12.4498 / 12.6400 s; the decoupled periods 9.6670 / 12.8522 / 9.1115 s are unchanged. |
| [e9d8705](https://github.com/warengineer/MSS/commit/e9d8705) | `HYDRO/wamit2vessel.m` | GM_L about the centre of flotation, (C55 − C35²/C33)/(m g): C55 about the CO includes ρ g A_wp LCF² = C35²/C33. For the tanker GM_L = 469.84 m, equal to the 469.8 m of the WAMIT hydrostatics (it was 470.9 m). The stored `tanker.mat` is not regenerated (Part 2). |
| [3cbc75f](https://github.com/warengineer/MSS/commit/3cbc75f) | `mssExamples/exObsCtr.m`, `mssExamples/exPassiveObs.m` | Bis scaling with `T = diag([1 1 1/L])` and `Tinv = diag([1 1 L])`, as in `supply.m` (the two were swapped): M₃₃ = 4.4524e9 kg m² and D₃₃ = 3.8481e8 N m s instead of 132.06 kg m² and 11.414 N m s; the ranks (9, 9, 12) are unchanged. First line of the header of `exPassiveObs.m` corrected. |
| [2619791](https://github.com/warengineer/MSS/commit/2619791) | `CRAFT/USV/models/otter.m` | The documented call `otter(x,n,mp,rp)` sets V_c = 0 and β_c = 0 (no current); MATLAB stopped at the undefined `V_c`. |

### Comments and help texts (12 commits)

| Commit | File | Change |
|---|---|---|
| [33e3134](https://github.com/warengineer/MSS/commit/33e3134) | `GNC/LOSchi.m`, `GNC/ALOSpsi.m`, `GNC/ILOSpsi.m` | The headers name the proportional LOS law and only m-files that exist in MSS; the update law of `ILOSpsi.m` reads `y_int[k+1] = y_int[k] + ...`. |
| [916b519](https://github.com/warengineer/MSS/commit/916b519) | `GNC/ALOS3D.m` | The update laws in the header use the previous estimate and the step h, as the code does. |
| [1f058f9](https://github.com/warengineer/MSS/commit/1f058f9) | `LIBRARY/signalFilters/waveFreqObserver.m` | The state vector is 3 × 1 (the help said 5 × 1). |
| [7837405](https://github.com/warengineer/MSS/commit/7837405) | `CRAFT/SHIP/models/osv.m` | The propeller speeds n3 and n4 are in rpm (K_thr = K_max/n_max² with n_max in rpm); the help said rps. |
| [74fe0b1](https://github.com/warengineer/MSS/commit/74fe0b1) | `mssExamples/exINSwaveFilter.m` | The notch frequency `w_0` is in rad/s, as `notchFilter.m` takes it; the comment said Hz. |
| [27f4c4b](https://github.com/warengineer/MSS/commit/27f4c4b) | `GNC/EKF_5states.m` | The output is the corrected state x̂[k]; the prediction for k + 1 is kept as a persistent variable. The help said the output was the predicted state. |
| [45e1cda](https://github.com/warengineer/MSS/commit/45e1cda) | `LIBRARY/modeling/wageningen.m`, `mssExamples/exWageningen.m` | Reference author Bernitsas (Bernitsas, Ray and Kinley 1981); it was spelled "Barnitsas". |
| [76e0a08](https://github.com/warengineer/MSS/commit/76e0a08) | `CRAFT/SHIP/models/tanker.m` | Header reference "Van Berlekom and Goddard (1972)"; the depth error message reads "The depth must be at least 18.5 m (draft T = 18.46 m)". |
| [8ac9e1d](https://github.com/warengineer/MSS/commit/8ac9e1d) | `CRAFT/SHIP/SIMosv.m` | The constant azimuth angles α₀ = ±28° minimize the condition number of T_thr K_max (minimum 32.652 at ±27.77°, 32.654 at ±28°), not that of T_thr (minimum 45.50 at ±30.60°, 48.62 at ±28°). |
| [4421d16](https://github.com/warengineer/MSS/commit/4421d16) | `HYDRO/computeManeuveringModel.m` | ω_p is the parameter of the PM spectrum S(ω) = α/ω⁵ exp(−0.74 (ω_p/ω)⁴); the spectral peak lies at (4 · 0.74/5)^(1/4) ω_p = 0.877 ω_p. The help called ω_p the peak frequency. |
| [597cdfb](https://github.com/warengineer/MSS/commit/597cdfb) | `GNC/LOSchi.m`, `GNC/ILOSpsi.m`, `GNC/ALOSpsi.m`, `GNC/ALOS3D.m`, `GNC/LOSobserver.m`, `GNC/refModel.m`, `CRAFT/AUV/SIMremus100.m` | The headers call `LOSobserver(..., h, K_f)` with five arguments, as the function takes them (T_f is computed from K_f); `LOSobserver.m` no longer names `LOSpsi.m`; `ALOS3D.m` switches inside the sphere of radius R_switch, as the code tests (the header said circle); `refModel.m` calls a_d the desired acceleration; in `SIMremus100.m` α_c = θ − γ is the vertical and β_c the horizontal crab angle (the names were swapped), and the citation reads "Automatica 194, 113149". |
| [b9e6db0](https://github.com/warengineer/MSS/commit/b9e6db0) | `LIBRARY/numericalMethods/euler2.m` | The help names one forward Euler step, a first-order method; it said Euler's second-order method. |

## Part 2: Observations, not changed

### Kinematics and numerical methods

| File | Observation |
|---|---|
| `LIBRARY/kinematics/Tzyx.m` | The singularity guard tests `cos(theta) == 0`, which does not happen at θ = π/2 in floating point (cos(π/2) = 6.1e-17): T then has entries of the order 1.6331e+16 instead of an error message. |
| `LIBRARY/numericalMethods/expm_taylor.m` | Adds Taylor terms until the infinity norm of the last term is at most 1e-6, without scaling and squaring. For a roll model the error against `expm` is 8.8e-10 at t = 0.05 s and 1.5e-07 at t = 2 s; at t = 5 s (‖At‖∞ = 374) it is above 1, and at 10 s the result is not finite. `expm_squaresPade.m` stays below 1e-12 on the same matrices. |
| `CRAFT/USV/models/otter.m` | The kinematics J = eulerang(η − η₀) use the angles relative to the trim, because η is shifted before J is formed; the restoring forces need the shifted η, the kinematics the actual attitude. The trim pitch with the default payload is −1.1147°, so the effect is small. |

### Guidance

| File | Observation |
|---|---|
| `GNC/LOSchi.m`, `GNC/ILOSpsi.m`, `GNC/ALOSpsi.m` with `CRAFT/USV/SIMotter.m` | The laws switch to the next leg by the along-track distance (d − x_e < R_switch), while `SIMotter.m` prints and plots a circle of acceptance of radius R_switch; the switch also happens when the craft passes outside that circle. |
| `GNC/LOSobserver.m` | The rate output is angle − low-pass(angle) = T_f s/(T_f s + 1) · angle, i.e. T_f times the derivative well below 1/T_f (T_f = 0.41746 s for K_f = 0.3). On a 5°/s ramp with h = 0.05 s it gives 2.2148°/s, and the filtered angle lags by 9.2840°. `SIMotter.m` and `SIMremus100.m` use the output as the desired yaw rate. |
| `GNC/ALOS3D.m` | The projection fades the update out between M_θ and M_θ + ε (ε = 0.001 rad), but one Euler step from inside the bound can carry the estimate past M_θ + ε (synthetic track, γ_h = γ_v = 0.02: 20.0935° for M_θ = 20°). |
| `CRAFT/USV/SIMotter.m` | The ILOS gain κ = 0.001 with Δ_h = 10 m equals ALOS with γ = κ/Δ_h² = 1e-5 (time constant 9993.3 s), so method 3 acts practically as proportional LOS. |
| `CRAFT/AUV/SIMremus100.m` | In method 3 the depth reference model writes `a_d`, which the heading controller also uses as its feedforward; for methods 3 and 4 figure 2 plots the measured depth as z_d. The yaw gain K_yaw = r_max/δ_max = 0.25 1/s is the linear gain of the model at 0.842 m/s; at 1300 rpm the model has K = 1.6532 1/s. The propeller rate limit of 0.1 rpm per step has no dead band (n alternates between 1300.0 and 1300.1 rpm). Methods 1 (PID, K_d = 0.5) and 2 (SMC, K_σ = 0.05, φ_b = 0.1) give the same run while σ stays inside the boundary layer (gain 0.5 in both). |
| `mssExamples/exPathGen.m` | Stores the time as (i − 1)h, so the sample where ϖ reaches 1 (after 671 steps of 0.1 s, t = 67.1 s) is labelled 67.0 s. |

### Vessel models and simulators

| File | Observation |
|---|---|
| `CRAFT/AUV/models/remus100.m` | The Munk-moment elements of C_A ((5,1), (5,3), (6,1), (6,2) and their counterparts) are set to zero, and the fin forces depend only on the fin angles (no lift at the local flow angle), so N_v = M_w = 0 in the linear model; with the Munk terms kept the linearized model has the eigenvalues +2.5550, +1.4350 and +0.1655 1/s. The header gives 2.5 m/s at 1525 rpm; the model reaches 2.5402 m/s. The horizontal current is rotated into BODY with the heading only (exact for φ = θ = 0). |
| `CRAFT/AUV/models/remus100.m`, `LIBRARY/modeling/imlay61.m`, `LIBRARY/modeling/forceLiftDrag.m` vs `LIBRARY/modeling/spheroid.m`, `LIBRARY/modeling/crossFlowDrag.m` | Two water densities in one model: 1026 and 1025 kg/m³. |
| `LIBRARY/modeling/crossFlowDrag.m` | The heave and pitch strips use w_r + x q with M = +Σ x Z, while the local heave velocity is w_r − x q (with M = −Σ x Z); for strips placed symmetrically about the CO both give the same sums (difference < 1e-13). |
| `CRAFT/AUV/models/DSRV.m` | Non-dimensional (prime-system) coefficients (e.g. m′ = 0.036391, I_y′ = 0.001925) are used in dimensional state equations, without the factors U/L and U²/L. |
| `CRAFT/AUV/models/npsauv.m`, `CRAFT/AUV/SIMnpsauv.m` | `npsauv()` without arguments evaluates B_δ with ε = −1 (n = u = 0), which `SIMnpsauv.m` uses for the allocation; in a straight run ε ≈ 0 and the stern-plane entry is 1.1453 times larger. The pitch strip of the cross-flow drag uses w_r + x q, the heave strip w_r − x q (60-s stern-plane dive: 18.567 m; 18.579 m with w_r − x q in both). |
| `CRAFT/AUV/SIMdsrv.m` | The pitch loop is a PI (K_i,θ = 0.1, no D term), which adds a slow pole at −0.0381 rad/s, so the bandwidth separation of the PD design does not hold; with a depth filter of 0.02 rad/s both integrators wind up (overshoot 83.422 m). |
| `LIBRARY/modeling/GM_surfaced2submerged.m` | The header defines α = 0 surfaced and 1 submerged with BM = (1 − α) I/∇; the code uses the complementary α = exp(−5 (z_n/T)²) (1 at the surface), with the same result. The range-check comment says 1000 m, the code 10000 m; the input description of `z_b_surface` says CG. |
| `CRAFT/SHIP/models/frigate.m`, `CRAFT/SHIP/models/zeefakkel.m` | Speeds of 5–12 and 1–7 m/s are accepted, but the data cover 6–12 and 2–6.2 m/s; outside the table the constants are extrapolated (`interp1` with `'extrap'`; frigate at 5 m/s: K = 0.0467 1/s, T = 17.67 s). |
| `CRAFT/SHIP/models/mariner.m`, `CRAFT/SHIP/models/tanker.m` | Sign conventions differ: `mariner.m` computes δ_c = −u_i (a positive input turns to starboard), `tanker.m` turns to port for a positive rudder angle, and both store −δ in x(7); `frigate.m` and `zeefakkel.m` turn to starboard. |
| `CRAFT/SHIP/models/tanker.m` | The straight-line trim rudder depends only on the water depth (0.5053° at 100 m, 0.5004° at 1000 m, the same at 50–80 rpm). The rudder limits of 10° and 2.33°/s rule out a 35° turning circle and a 20/20 zigzag, and the rudder inflow speed √(c_un u n + c_nn n²) becomes imaginary for a slightly negative shaft speed. |
| `LIBRARY/maneuvering/turncircle.m` | Keeps the rudder at zero until the execute and counts 90° and 180° of absolute heading. The constant yaw moment of `mariner.m` turns the ship by 8.0435° in 100 s, so the m-file reports an advance of 3.039 L and a tactical diameter of 6.581 L, against 3.556 L and 6.392 L from the straight-line trim. |
| `mssDemos/StabDemo.m` | K_d = (T/K)(2ζω_n + 1/T) instead of the pole-placement value (2ζω_n T − 1)/K: the closed loop has ζ_eff = ζ + 1/(ω_n T), 1.3333 and 0.4333 for the menu choices ζ = 1 and 0.1. The path is integrated with u₀ = 5 m/s, while K = 0.185 1/s and T = 107.3 s are the constants of the Mariner at 7.7 m/s. |
| `GNC/PIDnonlinearMIMO.m` | K_d = 2ζω_n M_diag without the damping term −D of pole placement; the D term is K_d ν in BODY instead of Rᵀ K_d R ν (equal only for equal surge and sway gains); the integral state uses η − η_d without `ssa`. |
| `CRAFT/SHIP/SIMsupply.m`, `CRAFT/SHIP/SIMsemisub.m` | The noise is added to the position and heading states in every step (a random walk: process noise rather than measurement noise). In `SIMsemisub.m` the current is constant in BODY (it turns with the platform). |
| `CRAFT/SHIP/SIMosv.m` with `CRAFT/SHIP/models/osv.m` | The allocation uses K_max = 300, 300, 655, 655 kN at n_max = 140, 140, 150, 150 rpm and l_x = −42 m for the azimuths; `osv.m` simulates 300, 300, 420, 655 kN at 140, 140, 150, 200 rpm and l_x = −41.5 m, so a command [100 kN, 200 kN, 5 MN m] gives [57.67 kN, 184.40 kN, 5.459 MN m]. `osv.m` has no limit on the shaft speeds (with ALLOC = 0 thruster 4 reaches 1.1887 times its 200 rpm). With ALLOC = 1, `fmincon` stops at its iteration limit in 1671 of 5001 samples, at a small step in 2790 and at a first-order optimum in 540. |

### Hydrodynamic data

| File | Observation |
|---|---|
| `HYDRO/vessels_wamit/tanker/tanker.frc` | M_RB(3,5) = M_RB(5,3) = −m x_g = −3.7186e8 kg m, but M_RB(2,6) = M_RB(6,2) = 0 instead of m x_g = +3.7186e8 kg m. |
| `HYDRO/vessels_wamit/tanker/tanker.mat` | Stores GM_L = 411.58 m, from an earlier estimate (A_wp = 0.8 L_pp B, LCF = −0.1 L_pp); `wamit2vessel.m` now gives 469.84 m. Above about 3.3 rad/s the panel data are not reliable (B33 or B55 < 0 at 3.65, 3.93, 4.19 and 4.49 rad/s); `computeManeuveringModel.m` uses the data up to 5.98 rad/s as they are. |
| `HYDRO/vessels_shipx/supply/supply.mat` | The surge drift is negative also in following seas (−19.5 kN at β = 0 for JONSWAP, H_s = 3 m, ω₀ = 0.8 rad/s) and positive only for β = 40–80°. For β and 360° − β the sway drift changes sign but the yaw drift does not (all 17 pairs), whereas a port–starboard symmetric hull gives a sign change. |

### Environment and signal processing

| File | Observation |
|---|---|
| `LIBRARY/environment/waveDirectionalSpectrum.m` | The spreading function is normalized with the trapezoidal rule over the random directions, but the amplitudes use the uniform Δμ = π/(M − 1): for 24 directions the variance factor Σ M(μ_i) Δμ lay between 0.9672 and 1.0303 (mean 0.9993) in 200 draws. |
| `LIBRARY/environment/vw2hs.m`, `LIBRARY/environment/hs2vw.m`, `LIBRARY/environment/waveSpectrum.m` | The factor 0.21 replaces 0.2092 = 2√(8.1e-3/0.74) of the PM sea (+0.36 % in H_s); the rounded coefficients of the modified PM spectrum (types 3–5) change 4√m₀ by the factors 0.99974, 1.00072 and 0.99697 and move the peak of type 5 to 0.99944 · 2π/T₀. |
| `LIBRARY/signalFilters/notchFilter.m` (option `'IIR'`) | The zeros lie on the unit circle, so a sinusoid at ω₀ is removed completely, but the gain at zero frequency is (2 − 2 cos ω₀h)/(1 − 2r cos ω₀h + r²) < 1 with r = e^(−ζω₀h): 0.8161 for ω₀ = 0.8 rad/s, ζ = 0.5, h = 0.05 s. The RK4 option passes a constant unchanged. |
| `mssExamples/exPassiveObs.m` | With its gains the phase of each loop transfer function h_i(s) dips to −94.85° at 0.690 rad/s, below the −90° of the SPR condition the plot is meant to show (with K3 = 0.02 K4 it stays above −90°). |
| `mssExamples/exRRD2.m` | The yaw states are low-passed at ω_l = 0.1 rad/s and the roll states high-passed at ω_h = 0.05 rad/s, the reverse of ω_yaw < ω_l < ω_h < ω_roll (in that order the roll reduction is 60.3 % instead of 61.9 %). The plot compares two windows of one run (on 350–750 s, off 800–1000 s: 42.6 %) instead of two runs in the same waves (61.9 %). |
| `mssExamples/exLQFinHor.m` | E = [0; 0]: the disturbance input cos t has no effect. |

### Inertial navigation

| File | Observation |
|---|---|
| `INS/functions/ins_euler.m` with `INS/SIMaidedINSeuler.m` | The gravity vector and the compass enter only together with a position fix, although `SIMaidedINSeuler.m` passes the compass at every step. |
| `INS/functions/ins_mekf.m`, `INS/functions/ins_mekf_psi.m` (sea-level pseudo-measurement) | The integral state is never propagated (its row and column of A are zero), so the option changes nothing: in the loop of `SIMaidedINSquat.m` the 16 states differ by less than 1e-9 and the integral state stays 0. |
| `INS/functions/ins_mekf.m`, `INS/functions/ins_mekf_psi.m` (gravity reference vector) | The measurement row has zeros in the bias columns, so an error of the accelerometer-bias estimate is taken for a tilt (0.1079° against 0.0647° RMS between 30 and 60 s). `ins_mekf.m` uses the option only with a magnetometer sample, `ins_mekf_psi.m` at every IMU step. |
| `INS/functions/ins_heave.m` | f_D = −f_x cos φ sin θ + f_y sin φ + f_z cos φ cos θ is the third row of R_x(φ)R_y(θ), the rotations in the other order (at most 0.0045 m/s² from the exact row); its single bias state along the down axis cannot follow a bias fixed in BODY. |
| `INS/functions/ins_ahrs.m`, `INS/functions/quatMEKF.m`, `INS/functions/ins_mekf.m` | `ins_ahrs.m` propagates the INS with the bias estimate from before the reset of the corrector, and its header lists attitude errors among its nine error states (it has p, v and b_acc). The usage lines of `ins_ahrs.m` and `quatMEKF.m` leave out T_acc and T_ars; the header of `ins_mekf.m` describes y_vel twice and calls P 15 × 15 (16 × 16 with the pseudo-measurement). |
| `INS/functions/quatObserver.m`, `INS/SIMquatObserver.m` | The comments speak of a first-order hold on ω (holding ω over a step is a zero-order hold). The injection is applied only at magnetometer or compass samples, so the effective bandwidths are k_i h f_slow (k_i/10 in `SIMquatObserver.m`). With the compass (reference vector #4) the forward axis is compared with a horizontal reference, so a pitched craft is estimated too level: at rest with 6° pitch the estimate settles at 5.8068° (k₁ = 1500, k₂ = 50). |
| `INS/functions/magneticField.m` | 30 entries with Moscow twice (indices 7 and 30). |
| `INS/SIMaidedINSeuler.m`, `INS/SIMaidedINSquat.m` | The options are chosen in dialog windows (`uiwait`), so the scripts do not run with `matlab -batch` or without a display. |

### GNU Octave

GNU Octave 8.4 with the control package 4.0.1; all of these m-files run in MATLAB R2026b.

| File | Observation |
|---|---|
| `CRAFT/USV/SIMotter.m`, `GNC/hermiteSpline.m` | `SIMotter.m` calls `hermiteSpline.m`, which uses `makima`, before its menu, so it stops for every method. |
| `mssExamples/exRefMod.m`, `mssExamples/exQuadProg.m` | `exRefMod.m` needs `ord2` and `yline`, `exQuadProg.m` needs `quadprog` (optim package). |
| `mssExamples/exFFT.m` | Stops at `bode`, which returns a column in GNU Octave, so `reshape(mag(1,:),1,1000)` fails; the Octave `lsim` has no method argument and discretizes continuous models with a first-order hold. |
| `mssExamples/exRRD1.m`, `mssExamples/exLQFinHor.m`, `mssExamples/exRRD2.m` | Need functions that GNU Octave lacks or handles differently (`modred`, `c2d` with more than one output, local functions in a script). |
