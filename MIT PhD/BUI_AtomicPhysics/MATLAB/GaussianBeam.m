%%% Huan Q. Bui
%%% Gaussian Beam propagation calculator
%%% Remarkably, we can model the propagation of a Gaussian beam through a
%%% paraxial optical system by matrices
%%% Matrices multiply, but the transformation is the Mobius transformation

%%% INPUTS
% wavelength
% w0: beam waist
% theta: beam divergence
% P0: total power
% optics: distances to lenses + focal lengths

%%% OUTPUTS
% w0_p: new beam waist
% theta_p: new beam divergence
% max fiber coupling efficiency (overlap of output E and desired E)



global wavelength; % wavelength
global w0; % beam waist
global A0; % electric field amplitude
global zR; % Rayleigh range
global n; % index of refraction of air
global theta; % beam divergence


wavelength= 589e-9; % in meters
w0 = 35e-6; % in meters
A0 = 1; % arbitrary...
n = 1;
zR = pi*w0^2*n/wavelength;
theta = wavelength/(n*w0); % beam divergence, in rads





%%% SAMPLE PROBLEM %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% suppose we have at z1 a lens of focal length f1
% and at z2 a lens of focal length f2
% at z=0, w(z) = z0

z  = 0; % beam starts from waist
z1 = 0.10; % 10cm from z=0;
z2 = z1 + 0.20; % 20cm from lens 1
z3 = z2 + 0.10; % 10cm from lens 2 is where fiber tip is
f1 = 0.10; % some random focal length
f2 = 0.10; % some random focal length

%%% Propagation matrix:
% z0 to z1:
T01 = free_space(z1-z);
% lens at z1:
R1 = thin_lens(f1);
% lens 1 to lens 2:
T12 = free_space(z2-z1);
% lens at z2:
R2 = thin_lens(f2);
% lens 2 to z3:
T23 = free_space(z3-z2);
% propagation matrix:
M = T23*R2*T12*R1*T01;
% propagate! to find q(z3):
q_new = propagate(q(z),M);

% compute new beam size at z3:
w0_new = qz_to_w0(q_new,z3);
% compute new Rayleigh range:
%zR_new = qz_to_zR(q_new,z3);
% compute new radius of curvature:
Rz_new = qz_to_Rz(q_new);

%%% Display results
disp(['Old beam parameter: ' num2str(q(0))])
disp(['Old beam waist: ' num2str(w(0))])
disp('------')
disp(['New beam parameter: ' num2str(q_new)])
disp(['New beam waist: ' num2str(w0_new)])
disp(['New radius of curvature: ' num2str(Rz_new)])



%%%% FUNCTIONS %%%%%%%%%%

% beam size function w(z)
function beam_size = w(z)
    global w0
    global zR
    beam_size = w0*sqrt(1+(z/zR)^2);
end

% radius of curvature function 
function radius_of_curvature = R(z)
    global zR
    radius_of_curvature = z*sqrt(1+(zR/z)^2);
end

% Gouy phase
function Gouy_phase = zeta(z)
    global zR
    Gouy_phase = arctan(z/zR);
end

% Gaussian beam parameter q(z)
function beam_parameter_q = q(z)
    % global wavelength
    % global n
    global zR
    % beam_parameter_q = 1/(1/R(z) - 1i*wavelength/(n*pi*w(z)^2));
    beam_parameter_q = z + 1i*zR; % equivalent defn
end

% convert from q(z) to w(z)^2
function new_w0 = qz_to_w0(qz,z)
    global wavelength 
    global n
    % first find w(z)^2
    new_wz2 = (-1/imag(1/qz))*wavelength/pi;
    % how to go from w(z)^2 to w0_new^2?
    % use Mathematica to solve the equation relating w(z) and w0
    new_w0 = sqrt(n^2*pi^2*new_wz2 - z^2*wavelength^2)/(n*pi);
end


% convert from q(z) to R(z)
function new_Rz = qz_to_Rz(qz)
    new_Rz = 1/real(1/qz);
end

% Electric field in cylindrical coords
% The Gouy phase is already included in this defn
% see page 8/44 of 
% http://ecee.colorado.edu/~ecen5616/WebMaterial...
% .../24%20Gaussian%20beams%20and%20Lasers.pdf
function E_field = E(r,z)
    global w0
    global zR
    global A0
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field = 1i*A0*sqrt(1/(sqrt(pi)*w0))*(zR/q(z))...
        *exp(-1i*k*r^2/(2*q(z))-1i*k*z);
end



%%% ABCD matrices for Gaussian beams %%%

% propagation = Mobius transformation
function q_prime = propagate(q, M)
    q_prime = (M(1,1)*q + M(1,2))/(M(2,1)*q + M(2,2));
end

% free space propagation
function Tk = free_space(DeltaZ)
    % t is propagation distance
    % [A B ; C D] = [1 DeltaZ; 0 1]
    Tk = [1 DeltaZ ; 0 1];
end

% thin lens refraction
function Rk = thin_lens(f)
    % f is focal length
    % [A B ; C D] = [1 0 ; -f 1] ==> lens equation convention reversed
    Rk = [1 0 ; -1/f 1];
end

% thick lens refraction
function Nk = thick_lens(n2, R1, R2, t)
    % n2: index of refraction of lens
    % R1: radius of curvature of 1st surface
    % R2: radius of curvature of 2nd surface
    % t: center thickness of lens
    global n
    Nk = [1 0; (n2-n)/(R2*n) n2/n]*[1 t ; 0 1]*[1 0 ; (n-n2)/(R1*n2) n/n2];
end

% flat mirror reflection
function Sk = flat_mirror()
    Sk = [1 0 ; 0 1];
end


