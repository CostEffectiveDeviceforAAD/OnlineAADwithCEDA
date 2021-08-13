%% Real-time AAD analysis
%clear

sub = '_0812_LKS'
subject = 7

% sub = '_0811_JJH'
% subject = 5

%% Behavior
file = strcat('Behavior',sub, '.mat');
load(file)

beh_at = Behavior(:,3:4);
beh_un = Behavior(:,1:2);

correct_at = find(beh_at=='T');
correct_un = find(beh_un=='T');

accb_at = (length(correct_at)/60)*100;
accb_un = (length(correct_un)/60)*100;  

%% Bar plot - behavior

X = categorical({'Attended','Unattended'});

for sub = 1:size(C,1)
    be_at(sub) = table2array(C(sub, 5));
    be_un(sub) = table2array(C(sub, 6));
end

y = [be_at; be_un];
Y = [mean(be_at), mean(be_un)];

% plot

b = bar(X, Y); hold on
plot(X, y, '--ok');
grid on
ylim([0 100])
ylabel('Accuracy(%)')
set(gcf, 'color', 'white')
title('Behavior Result')

%% Accuracy Plot
%% Accuracy

file = strcat('Accuracy',sub, '.mat');
load(file)  % Acc

data = readtable('C:\Users\LeeJiWon\Desktop\OpenBCI\Recording data\result.xlsx');

overall = mean(Acc*100);
fixed = mean(Acc(1:12)*100);
switching = mean(Acc(13:16)*100);

%data = table(subject, overall, fixed, switching, accb_at, accb_un)  % first suvject
data = [data; table(subject, overall, fixed, switching, accb_at, accb_un)]

chance = 52.99

%% Write to Excel file 
writetable(data, 'C:\Users\LeeJiWon\Desktop\OpenBCI\Recording data\result.xlsx');

%% Read previous AAD result

pre_data = readtable('C:\Users\LeeJiWon\Desktop\OpenBCI\OnlineAAD_Performance.xlsx');


%% subject_total
%C = readtable('result_sample.xlsx');

X = reordercats(X,{'Overall','Fixed','Switching'});

y = table2array(C(:, 2:4));
Y = [mean(table2array(C(:,2))), mean(table2array(C(:,3))),...
    mean(table2array(C(:,4)))];


b = bar(X, Y);  hold on
plot(X, y, '--ok');
grid on
set(gcf, 'color', 'white')
ylim([50 80])
ylabel('Accuracy(%)')
% refline([0, chance]);
title('Total')

%% multi subject

%C = readtable('result_sample.xlsx');
Y = []
X = []

for sub = 1:length(data.subject)
    name = strcat('Sub', num2str(sub));
    X = [X, categorical({name})];
    Y = [Y; table2array(data(sub,2:4))];
    
end

b = bar(X, Y);
yline(52.99, '-.k')
hline.Color = 'r';
grid on
legend('overall','fixed','switching');
ylim([0 80])
set(gcf, 'color', 'white')
ylabel('Accuracy(%)')
xlabel('Subject')

%%
clear

load 'Accuracy_chloc.mat' 
train_trial_ori = mean(Acc(1:14));
test_ori = mean(Acc(15:30));
train_mean_ori = mean(Acc(31:end));

%% channel search
clear
%load 'C:\Users\user\Desktop\hy-kist\OpenBCI\save_data\Accuracy_chloc.mat' 
load 'C:\Users\LeeJiWon\Desktop\OpenBCI\save_data\Accuracy_chloc.mat' 

for i = 1:size(Acc,1)
    check_Acc(i) = mean(Acc(i,1:14))*100;
    test_Acc(i)  = mean(Acc(i,15:30))*100;
end

maxval = max(test_Acc);
index = find(test_Acc==maxval);

%% channel graph

%ch = ['T7' 'Fz' 'T8' 'P4' 'P7' 'C3' 'O2'...
%                'Fp1' 'O1' 'Pz' 'F3' 'Cz' 'C4' 'P3' 'P8' 'F4'];                   
            
%ac = [61.41, 65.76, 66.85, 67.39, 67.39, 66.17, 65.76...
%        63.72, 62.77, 61.96, 60.60, 59.78, 58.42, 56.79, 54.89, 54.62];
     
%ac = [71.47, 76.90, 76.22, 75.00, 72.83, 72.28, 70.38, 68.34, 67.39...
%        68.75, 69.43, 70.38, 71.88, 69.57]  % bsc

%ac = [62.36, 69.16, 69.57, 71.33, 73.10, 74.59, 76.36, 76.36, 76.77, 76.49, 76.77, 76.90, 75.54, 74.18, 71.60];     %kkm

ac = [68.75, 73.37, 74.05, 72.55, 75.68, 75.82, 76.36,...
       76.22, 75.27, 74.86, 73.64, 72.69, 73.37, 72.01, 64.95]


x = 1:15 

% plot
figure;
plot(x, ac,'-or');
set(gcf, 'color', 'white')
set(gca, 'xtick', [1:15])
%set(gca, 'xticklabel', char('T7', 'Fz', 'T8', 'P4', 'P7', 'C3', 'O2', 'Fp1'...
%                                'O1', 'Pz', 'F3', 'Cz', 'C4', 'P3', 'P8', 'F4'))   %ljw
%set(gca, 'xticklabel', char('Fp1', 'P7', 'T7', 'F4', 'Pz/P3', 'F7', 'P4',...
%                                'O2', 'Fz', 'C4', 'C3/P8', 'F3', 'T8', 'Cz'))       % bsc
%set(gca, 'xticklabel', char('T8', 'Cz', 'Fz','F3', 'F7', 'C4', 'C3','P3', 'Pz',...
%                                'P7', 'P4', 'P8', 'F4', 'F8', 'T7'))       % kkm                                
set(gca, 'xticklabel', char('P8', 'C3', 'F4','C4', 'Fz', 'P7','P3', 'T8', 'Cz', 'P4',...
                                'Pz', 'T7', 'F7', 'F3', 'F8'))       % ctm  

ylim([60 80])
grid on 
xlabel('Channel')
ylabel('Accuracy(%)')


%% Envelope
load 'Predict_L.mat'
load 'Allspeech.mat'
i = 20;
L = 960;
x = linspace(0, L/64, L);
%%
for i = 0
    figure()
    subplot(311)
    plot(x, Allspeech(31+i,1:960)')
    title('Speech-att')
    subplot(312)
    plot(x, Allspeech(1+i,1:960)')
    title('Speech-unatt')
    subplot(313)
    plot(x, pre(1,:)')
    title('Predicted')
end

%% 비교-envelope
tr = 24
pre_l = squeeze(Pre_L(tr,:,:));


for i = 16:20
    figure()
    subplot(211)
    plot(x, Allspeech(31+i, 64*(i)+1:64*(15+i))'); hold on
    plot(x, pre_l(i+1,:)*5')
    title('Speech-att')
    subplot(212)
    plot(x, Allspeech(1+i, 64*(i)+1:64*(15+i))'); hold on
    plot(x, pre_l(i+1,:)*5')
    title('Speech-unatt')
end


%% 겹치기-att
for (i = 9) %&& (i = 24:25)
    figure()
    plot(x, Allspeech(31+i,1:64*(15))', 'r'); hold on
    plot(x, (Pre_L{1+i}(1,:))', 'b')
    legend('Speech', 'Predicted')
    title(strcat('Trial - ', num2str(i)))
end
%%
for (i = 16:20)
    figure()
    plot(x, Allspeech(1+i,1:960)', 'r'); hold on
    plot(x, Pre_L{1+i}(1,:)', 'b')
    legend('speech', 'predicted')
end
%16,17,18,24,25,

%% bar and spot
Y=[]
X=[]
X = categorical({'Overall','Fixed','Switching'});
X = reordercats(X,{'Overall','Fixed','Switching'});

for sub = 1: length(data.subject)
    Y = [Y; table2array(data(sub,2:end))];
end

Ym = mean(Y(:,1:3), 1)

b = bar(X, Ym);  hold on
plot(X, Y(:,1:3)', '--o');
grid on
ylim([0 100])
ylabel('Accuracy(%)')
% refline([0, chance]);
title('Total')

%% bar and spot - comparision
Y=[];
X = categorical({'Overall','Fixed','Switching'});
X = reordercats(X,{'Overall','Fixed','Switching'});

for sub = 1: size(data,1)
    Y = [Y; table2array(data(sub,2:4))];
end

% previour result
pre_Y = table2array(pre_data(:,2:4));

Ym = [mean(Y, 1); mean(pre_Y, 1)];

b = bar(X, Ym);  hold on
%plot(X, Y', '-o');
grid on
ylim([0 100])
ylabel('Accuracy(%)')
set(gcf, 'color', 'white')
legend('OpenBCI', 'Neuroscan');
title('Comparison')
