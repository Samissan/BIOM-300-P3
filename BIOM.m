function pop = BIOM(pop)
%Using the structure functionality in Matlab, this function takes a
%structure of a populations data from the ultrasound and blood pressure
%monitor to estimate cross-sectional compliance, distensibility,presure-strain elsastic modulus, and youngs
%modulus.  The following variables will be needed in the starting structure
%to run

%inputs
%sp = systolic pressure (mmhg)
%dp = diastolic pressure (mmhg)
%sd = systolic artiery diameter (cm)
%dd = diastoilic artiery diameter (cm)
%h = the thickness of the artery wall (cm)
%q1-8 answers to the loneliness survey

%outputs
%CC = Cross sectional compliance
%DC = Distensibility
%Ep = Pressure-strain youngs modulus
%E = youngs modulus 
%PVW = Pulse Wave Velocity


for i = 1:length(pop)
    pop(i).deltaP = pop(i).sp-pop(i).dp; %this is the change in systolic and diastolic pressure(cm)
    pop(i).deltaD = pop(i).sd-pop(i).dd; % change in the sstolic and diastolic diameter(cm)
    pop(i).Davg = (pop(i).sd+pop(i).dd)/2; % the average diameter of the arterial lumen(cm)
    pop(i).CC = pi*pop(i).sd^2*pop(i).deltaD/pop(i).sd/(2*pop(i).deltaP)/100^2/0.133322; % equation for cross sectional compliance m^2/kPa
    pop(i).DC = 2*pop(i).deltaD/pop(i).sd/(pop(i).deltaP)/0.133322; % equation for distensibility 1/kPa
    pop(i).Ep = (pop(i).deltaP/pop(i).deltaD)*pop(i).Davg*0.133322; % kPa
    pop(i).E = pop(i).deltaP/pop(i).deltaD*pop(i).Davg/pop(i).h*0.133322; %kPa/cm
    pop(i).PVW = sqrt(1/pop(i).DC);
end
%% In person interaction
subplot(2,2,1)
sgtitle('In-Person Interaction')
    plot([pop.IRL],[pop.CC],'o')
    title('Cross Sectional Compliance')
    ylabel('Cross Sectional Compliance (m^2/kPa)')
    xlabel('Amount of In-Person Interaction (hours/week)')
    xlim([14,34])
subplot(2,2,2)
    plot([pop.IRL],[pop.DC],'o')
    title('Disensibility')
    ylabel('Distensibility (1/kPa)')
    xlabel('Amount of In-Person Interaction (hours/week)')
    xlim([14,34])
subplot(2,2,3)
    plot([pop.IRL],[pop.E],'o')
    title('Youngs Modulus')
    ylabel('Youngs Modulus kPa/cm)')
    xlabel('Amount of In-Person Interaction (hours/week)')
    xlim([14,34])
subplot(2,2,4)
    plot([pop.IRL],[pop.PVW],'o')
    hold on
    title('Pulse Wave Velocity')
    ylabel('Pulse Wave Velocity (m/s)')
    xlabel('Amount of In-Person Interaction (hours/week)')
    ylim([3,4.5])
    xlim([14,34])
%% Virtual Interaction
figure(2)
subplot(2,2,1)
sgtitle('Virtual Interaction')
    plot([pop.VIR],[pop.CC],'o')
    title('Cross Sectional Compliance')
    ylabel('Cross Sectional Compliance (m^2/kPa)')
    xlabel('Amount of Virtual Interaction (hours/week)')
    xlim([0,18])
subplot(2,2,2)
    plot([pop.VIR],[pop.DC],'o')
    title('Disensibility')
    ylabel('Distensibility (1/kPa)')
    xlabel('Amount of Virtual Interaction (hours/week)')
    xlim([0,18])
subplot(2,2,3)
    plot([pop.VIR],[pop.E],'o')
    title('Youngs Modulus')
    ylabel('Youngs Modulus(kPa/cm)')
    xlabel('Amount of Virtual Interaction (hours/week)')
    xlim([0,18])
subplot(2,2,4)
    plot([pop.VIR],[pop.PVW],'o')
    title('Pulse Wave Velocity')
    ylabel('PWV (m/s)')
    xlabel('Amount of Virtual Interaction (hours/week)')
    ylim([3,4.5])
    xlim([0,18])
%% Linear significance
ccirl = fitlm([pop.IRL],[pop.CC])
ccvir = fitlm([pop.VIR],[pop.CC])
ccboth = fitlm([pop.IRL ; pop.VIR]',[pop.CC]')
end

