%% DADOS DA AERONAVE
% 

% Conversões úteis:
kn2mps=0.514444;
%deg2rad;
rpm2radps=pi/30;


% Condições iniciais
h =100;             % m
M =0.15;            % m 
aa0 =deg2rad(13.4); % rad
gg0 = 0;            % rad
u0 =99.0*kn2mps;    % m/s 
flaps =deg2rad(40); % rad 
theta0=gg0+aa0;     % rad
g=9.81;             % m / s^2

% Inputs Iniciais:
th0 =0.34;
de0 =0.00;      % rad 
da0 =0.00;      % rad 
dr0 =0.00;      % rad 
Teng =0.50;     % s
demax =fixed.Interval(deg2rad(+28),deg2rad(-22));     % rad 
damax =fixed.Interval(0,deg2rad(18));                 % rad 
drmax =fixed.Interval(deg2rad(-23),deg2rad(23));      % rad 
flapmax=fixed.Interval(0,deg2rad(40));                % rad

% Dados Inerciais da aeronave:
m =6820;        % kg 
Ix =5526873;    % kg .m ^2;
Iy =65106;      % kg .m ^2;
Iz =5478044;    % kg .m ^2;
Ixz =1763;      % kg .m ^2

% wing data : 
S =25.55;               % m ^2
b =8.382;               % m
c =2.235;               % m
aamax =deg2rad(19.69);   % rad

% Derivadas ( no units or SI units ):
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

lbblin=lbb+Ixz*nbb/Ix;
nbblin=nbb+Ixz*lbb/Iz;

lplin=lp+Ixz/Ix*np;
nplin=np+Ixz*lp/Iz;

lrlin=lr+Ixz/Ix*nr;
nrlin=nr+Ixz/Iz*lr;

Ldalin=Lda+Ixz/Ix*Nda;
Ldrlin=Ldr+Ixz/Ix*Ndr;
Ndalin=Nda+Ixz/Iz*Lda;
Ndrlin=Ndr+Ixz/Iz*Ldr;




%% Modelo Dinâmico para o movimento lateral
% Matriz de estados X:
% X=[BB;   p ;   r ;    phi; lambda];

% Matriz de Controlo U:
% U=[da;dr];

% Matriz da Dinâmica A:[Linhas Por calcular]
A=[ybb/u0     yp/u0+aa0      yr/u0-1    g*cos(theta0)/u0 ;
   lbblin/u0     lplin         lrlin           0;
   nbblin/u0     nplin         nrlin           0;
   0           1          tan(theta0)          0];

% 5ªa linha para angulo de rumo
%
% ybb     (yp/u0+aa0)  (yr/u0-1)+1/(cos(theta0)) g*cos(theta0)/u0   0];

% Matriz de entrada B:
B=[ 0   Ydr/u0  ;
   Ldalin  Ldrlin;
   Ndalin  Ndrlin;
   0          0];

% 5ª linha para angulo de rumo
%   0       Ydr/u0];

% Polinómio característico:
damp(A)
