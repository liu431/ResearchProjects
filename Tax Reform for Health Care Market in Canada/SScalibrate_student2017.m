function [paraout,SSout] = SScalibrate_student2017(TargetsIn)

% SScalibrate.m
%----------------------------------------------------------------------
% This function takes in one vectors as arguments:
%   -Calibration Targets (1x6)
        % f1:Average Capital to Output Ratio
        % f2:Average Investment to Output Ratio
        % f3:Average Population Growth Rate
        % f4:Average RGDP/N growth Rate
        % f5:Capital Share
        % f6:Average Labor in Production
%The function produces two vectors of output :
%   -Parameters (1x4)
        % paraout1: TFP growth rate (gamma)
        % paraout2: Depreciation rate (delta)
        % paraout3: Love of leisure (theta) 
        % paraout4: Discount rate (beta)
%   -Steady State Prices & Allocation (1x8)        
        % SSout1: Interest rate (i)        
        % SSout2: HH Consumption (c)
        % SSout3: HH Savings (a)
        % SSout4: Investment (x)
        % SSout5: Capital Stock (k)
        % SSout6: Labor (ell)
        % SSout7: Rental Rate (r)
        % SSout8: Wage (w)
%------------------------------------------------------------------------
%Reference: Problem Set 3 & Lecture Notes 5,6
%________________________________________________________________________

%Some objects calculated directly from data:
eta = TargetsIn(1,3);
alpha= TargetsIn(1,5);
g = TargetsIn(1,4);
ell = TargetsIn(1,6);

%Now calibrate parameters:
gamma =g ; %Balanced growth growth-rate
delta =(0.2513)/4.0816-g-eta-(g*eta) ; %Depreciation
irate = alpha/4.0816-delta; %Balanced growth interest rate
beta =(1+g)/(1+irate) ; %Balanced growth discount factor
theta =((1-ell)/ell)*(1-alpha)* ((1-0.2513)^(-1)); %Preference parameter on leisure

%And backout endogenous objects (normalize z_0 =1)
k =ell*(4.0816^(1/(1-alpha))) ; %Steady-state capital
w =(1-alpha)*((k/ell)^alpha) ; %Steady-state wage
r = irate+delta; %Steady-state interest rate
x = delta+g+eta+g*eta; %Steady-state investment
y = (k^alpha)*(ell^(1-alpha)); %Steady-state output
c = y-x ; %Steady-state consumption
a = k*(1+r+delta)/(1+irate); %Steady-state deposits
%Place in Vector to Print
    paraout(1,1)= gamma;
    paraout(1,2)= delta; 
    paraout(1,3)= theta;
    paraout(1,4)= beta;
    SSout(1,1)= irate;
    SSout(1,2)= c;
    SSout(1,3)= a;
    SSout(1,4)= x;
    SSout(1,5)= k;
    SSout(1,6)= ell;
    SSout(1,7)= r;
    SSout(1,8)= w;


