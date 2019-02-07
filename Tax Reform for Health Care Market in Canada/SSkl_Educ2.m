function KLout = SSkl(Guess,ParaIn,TaxesIn)

% SScalc.m
%----------------------------------------------------------------------
%The function calculates the SS capital and labor
% It takes in three vectors as arguments:
%   -Guess (1x2)
        %k
        %l
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
%________________________________________________________________________

%   Need to keep k>0 and ell\in(0,1]
k=(Guess(1,1))^2;       
l=1/(1+(exp(Guess(1,2)))); 

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

%Calculate Prices given the guess of k,l

Y= (k^alpha)*((N*l*(z^1.2))^(1-alpha));
i = ((1/beta)-1)/(1+ta);
r = (1-tx)*alpha*(k^(alpha-1))*((N*l*(z^1.2))^(1-alpha));
w = (1-tl)*(1-alpha)*(k^alpha)*((N*l*(z^1.2))^(-alpha));
x = delta*k;
c = Y-G+T-x;


%Now check if HH would really choose our guess of k,l given the equilibrium prices
%implied by our guess of k,l

%Important: F-solve needs Equations organized such that they're equal to zero.
%   -First equation uses intra temp. euler
%   -Second equation gives capital using the euler of the HH and prices

KLout = [theta*c*(1+tc)-w*(1-l),alpha*(l/k)^(1-alpha)-(i+delta)/r];

