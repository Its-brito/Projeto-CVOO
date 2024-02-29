%% DADOS DA AERONAVE
% 
% Condições iniciais
h =1000;         % m
M =0.40;        % m 
aa0 =2.5*pi/180;      % rad
gg0 = 0;        % deg
u0 =134.4758;   % m/s
flaps =0;      % deg 
theta0=gg0+aa0; % rad
g=9.81;         % m / s^2
% Inputs Iniciais:
th0 =0.19;
de0 =0.00;      % deg 
da0 =0.00;      % deg 
dr0 =0.00;      % deg 
Teng =0.50;     % s
demax =fixed.Interval(+28, -22); % deg 
damax =fixed.Interval(0,18);     % deg 
drmax =fixed.Interval(-23,23);   % deg 
flapmax=fixed.Interval(0,40);    % deg

% Dados Inerciais da aeronave:
m =9211;        % kg 
Ix =1783099;    % kg .m ^2;
Iy =65106;      % kg .m ^2;
Iz =1734269;    % kg .m ^2;
Ixz =1763;      % kg .m ^2

% wing data : 
S =25.55;       % m ^2
b =8.382;       % m
c =2.235;       % m
aamax =19.69;   % deg

% Derivadas ( no units or SI units ):
xu=-0.0279;
xw=0.0464;
zu=-0.1544;
zw= -1.1253 ;
zwp=-0.0045 ;
zq=-1.6353 ;
mu=0.0000 ;
mw=-0.0803 ; 
mq=-1.0798 ;
mwp=-0.0333;
ybb=-0.0689 ;
lbb=-0.0696;
nbb=0.3144 ;
yp= 0.0007 ;
lp=-0.8419 ;
np=0.0019;
yr=0.0018 ;
lr=0.0084 ; 
nr= -0.0256;
xde =0.000;
zde=-0.012 ;
mde=-0.020;
xdf=-2.263 ;
zdf=-8.096 ;
mdf= 0.097 ;
xdt=8.760;
zdt=0.000 ;
mdt=0.000;
Lda=-0.702;
Nda=-0.052 ;
Ydr=-0.005 ;
Ldr=-0.002;
Ndr= -0.013;

% Conversões úteis:
kn2mps=0.514444;
%deg2rad;
rpm2radps=pi/30;


%% Modelo Dinâmico para o movimento lateral
% Matriz de estados X:
% X=[BB;   p ;   r ;    phi; lambda];

% Matriz de Controlo U:
% U=[da;dr];

% Matriz da Dinâmica A:[Linhas Por calcular]
A=[ybb     (yp/u0+aa0)      yr/u0-1    g*cos(theta0)/u0           0;
   lvlin*u0     lplin          lrlin           lpplin                 0;
   nvlin*u0     nplin         nrlin             npplin               0;
   0           1          tan(theta0)          0                   0;
   ybb     (yp/u0+aa0)  (yr/u0-1)+1/(cos(theta0)) g*cos(theta0)/u0   0];
 
% Matriz de entrada B:
B=[ 0   Ydr/u0  ;
   Ldalin  Ldrlin;
   Ndalin  Ndrlin;
   0          0
   0       Ydr/u0];

% Polinómio característico:
damp(A)
