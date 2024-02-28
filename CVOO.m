%% DADOS DA AERONAVE
% 
% Condições iniciais
h =100;         % m
M =0.15;        % m 
aa0 =13.4;      % deg
gg0 = 0;        % deg
u0 =99.0;       % kn 
flaps =40;      % deg 
theta0=gg0+aa0; % deg
g=9.81;         % m / s^2
% Inputs Iniciais:
th0 =0.34;
de0 =0.00;      % deg 
da0 =0.00;      % deg 
dr0 =0.00;      % deg 
Teng =0.50;     % s
demax =fixed.Interval(+28, -22); % deg 
damax =fixed.Interval(0,18);     % deg 
drmax =fixed.Interval(-23,23);   % deg 
flapmax=fixed.Interval(0,40);    % deg

% Dados Inerciais da aeronave:
m =6820;        % kg 
Ix =5526873;    % kg .m ^2;
Iy =65106;      % kg .m ^2;
Iz =5478044;    % kg .m ^2;
Ixz =1763;      % kg .m ^2

% wing data : 
S =25.55;       % m ^2
b =8.382;       % m
c =2.235;       % m
aamax =19.69;   % deg

% Derivadas ( no units or SI units ):
xu=-0.1079;
xw=0.1200;
zu=-0.4060;
zw= -0.6341 ;
zwp=-0.0067 ;
zq=-0.9134 ;
mu=0.0000 ;
mw=-0.0332 ; 
mq=-0.4465 ;
mwp=-0.0363;
ybb=-0.0385 ;
lbb=-0.0035;
nbb=0.0156 ;
yp= 0.0010 ;
lp=-0.1123 ;
np=0.0003 ;
yr=0.0027 ;
lr=0.0011 ; 
nr=-0.0034;
xde =0.000;
zde=-0.361 ;
mde=-0.423;
xdf=-0.479 ;
zdf=-1.713 ;
mdf= 0.015 ;
xdt=10.226;
zdt=0.000 ;
mdt=0.000;
Lda=-0.036;
Nda=-0.003 ;
Ydr=-0.008 ;
Ldr=-0.000 ;
Ndr= -0.002;

% Conversões úteis:
kn2mps=0.514444;
%deg2rad;
rpm2radps=pi/30;


%% Modelo Dinâmico para o movimento lateral
% Matriz de estados X:
% X=[BB;   p ;   r ;    phi];

% Matriz de Controlo U:
% U=[da;dr];

% Matriz da Dinâmica A:[ERRADA temos de considerar momentos de inercia]
A=[ybb yp+0   yr-u0*kn2mps g*cosd(theta0);
   lbb lp     lr           0             ;
   nbb np     nr           0             ;
   0   1      tand(theta0) 0             ];

% Matriz de entrada B:
B=[0    0  ;
   Lda  Ldr;
   Nda  Ndr;
   0    0];

% Polinómio característico:
damp(A)
