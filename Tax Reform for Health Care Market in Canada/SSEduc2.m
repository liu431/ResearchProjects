function SSout = SScalc(ParaIn,TaxesIn)

% SScalc.m
%----------------------------------------------------------------------
% This function calculates the steady state in an economy with Fiscal Policy
%   It takes in two vectors as arguments:
%   -Parameters (1x6)
        % p1 = depreciation, delta;
        % p2 = love of leisure, theta;
        % p3 = discount rate, beta;
        % p4 = capital share, alpha;
        % p5 = population, N;
        % p6 = TFP, z;
%   -Fiscal Policy (1x6)
        % t1:Household Investment tax/credit
        % t2:Labor Income Tax
        % t3:Consumption Tax (VAT)
        % t4:Lumpsum Tax/Transfer
        % t5:Banks' capital income tax
        % t6:Government expenditures
%The function calculates the SS equilibrium (SScalc): 
        % SScalc1: Interest rate (i)
        % SScalc2: HH Consumption (c)
        % SScalc3: HH Savings (a)
        % SScalc4: Investment (x)
        % SScalc5: Capital Stock (k)
        % SScalc6: Labor (ell)
        % SScalc7: Rental Rate (r)
        % SScalc8: Wage
        % SScalc9: GDP
        % SScalc10: Actual Govn't Surplus (Rev-Expend)
%________________________________________________________________________

delta = ParaIn(1,1);
theta = ParaIn(1,2);
beta = ParaIn(1,3);
alpha = ParaIn(1,4);
N = ParaIn(1,5);
z = ParaIn(1,6);

ta = TaxesIn(1,1);
tl = TaxesIn(1,2);
tc = TaxesIn(1,3);
T = TaxesIn(1,4);
tx = TaxesIn(1,5);
G = TaxesIn(1,6);


%Calculate K,L using nonlinear equation solver
klOut = [5,0.5];    %Note: guess of k must be >0, l must be in (0,1)
options = []; 
steady = fsolve(@SSkl_Educ2,klOut,options,ParaIn,TaxesIn);
k = (steady(1,1)^2);   
l = 1/(1+(exp(steady(1,2))));

%Now find remaining objects
Y= (k^alpha)*((N*(z^1.2)*l)^(1-alpha));
i = ((1/beta)-1)/(1+ta);
r = (1-tx)*alpha*(k^(alpha-1))*((N*(z^1.2)*l)^(1-alpha));
w = (1-tl)*(1-alpha)*(k^alpha)*((N*l*(z^1.2))^(-alpha));
x = delta*k;
c = Y-G+T-x;
a = (1+i)*k; %Deposits
GRev = tl*l*w+tc*c+T+tx*r*k-G+ta*i*a-0.2*w*l; %Government Revenues

    SSout(1,1)= i;
    SSout(1,2)= c;
    SSout(1,3)= a;
    SSout(1,4)= x;
    SSout(1,5)= k;
    SSout(1,6)= l;
    SSout(1,7)= r;
    SSout(1,8)= w;
    SSout(1,9)= Y;
    SSout(1,10)= GRev;