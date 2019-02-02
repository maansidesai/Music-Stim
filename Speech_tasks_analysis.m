% Analysis for Speech Tasks - EC86: Music/Stim Paper


clear 
clc
close all

addpath(genpath('/Users/maansi/Desktop/Music-Stim/'))
directory = '/Users/maansi/Desktop/UCSF/Music-Stim/analysis';

%Repetition Task ---------------------------------------------------------
[num,txt,raw] = xlsread('Repetition_Speech.xlsx');
onset_diff_rep = num(:,17);
average_onset_diff_all_rep = sum(onset_diff_rep)/length(onset_diff_rep);
rep_start_sec = num(:,2);
rep_shock_start_sec = num(:,11);

rep_label = txt(:,9);

error_labels = {'Arrest', 'Slow', 'Deletion', 'Addition', 'Substitution'};

%arrests
arrests = find(strcmpi(error_labels{1}, rep_label));
% arrest_rows = vertcat(rep_shock_start_sec(arrests));
% avg_arrest_rows = sum(arrest_rows)/length(arrest_rows);
arrest_onset = vertcat(onset_diff_rep(arrests));
avg_arrest_onset = sum(arrest_onset)/length(arrest_onset)
A = std(arrest_onset)

%slow
slow = find(strcmpi(error_labels{2},rep_label));
slow_onset = vertcat(onset_diff_rep(slow));
avg_slow_onset = sum(slow_onset)/length(slow_onset)
B = std(slow_onset)

%deletion
deletion = find(strcmpi(error_labels{3},rep_label));
deletion_onset = vertcat(onset_diff_rep(deletion));
avg_deletion_onset = sum(deletion_onset)/length(deletion_onset)
C = std(deletion_onset)
%perceptual

%addition 
addition = find(strcmpi(error_labels{4}, rep_label));
addition_onset = vertcat(onset_diff_rep(addition));
avg_addition_onset = sum(addition_onset)/length(addition_onset)
D = std(addition_onset)

%create table for repetition
error_labeling_count = ({'Arrest'; 'Slow'; 'Deletion'; 'Addition'});
Onset_Averages_rep_name = [avg_arrest_onset, avg_slow_onset, avg_deletion_onset, avg_addition_onset]';
SD_Onset_pic_name = [A, B, C, D]'

T=table(Onset_Averages_rep_name,SD_Onset_pic_name,...
    'RowNames',error_labeling_count)
TStringCount = evalc('disp(T)');

% Use TeX Markup for bold formatting and underscores.
figure
TStringCount = strrep(TStringCount,'<strong>','\bf');
TStringCount = strrep(TStringCount,'</strong>','\rm');
TStringCount = strrep(TStringCount,'_','\_');

% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');

% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TStringCount,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);
%title('Repetition Task')


%Counting Task ---------------------------------------------------------
[num,txt,raw] = xlsread('Counting_Speech.xlsx');
onset_diff_count = num(:,9);
average_onset_diff_all_count = sum(onset_diff_count)/length(onset_diff_count);
count_start_time = num(:,2);
count_shock_start_time = num(:,13);

count_label = txt(:,9);

error_labels_count = {'Arrest', 'Slow'}; % 

%arrests
arrests_count = find(strcmpi(error_labels_count{1}, count_label));
avg_arrest_count = sum(vertcat(onset_diff_count(arrests_count)))/length(vertcat(onset_diff_count(arrests_count)));
E = std(onset_diff_count(arrests_count));

%slow
count_name_slow = find(strcmpi(error_labels_count{2}, count_label));
avg_slow_count = sum(vertcat(onset_diff_count(count_name_slow)))/length(vertcat(onset_diff_count(count_name_slow)));
F = std(vertcat(onset_diff_count(count_name_slow)));

%create table for Counting
error_labeling_count = ({'Arrest'; 'Slow'});
Onset_Averages_count_name = [avg_arrest_count, avg_slow_count]';
SD_Onset_pic_name = [E,F]'

T_Count=table(Onset_Averages_count_name,SD_Onset_pic_name,...
    'RowNames',error_labeling_count)
TStringCount = evalc('disp(T_Count)');

% Use TeX Markup for bold formatting and underscores.
figure
TStringCount = strrep(TStringCount,'<strong>','\bf');
TStringCount = strrep(TStringCount,'</strong>','\rm');
TStringCount = strrep(TStringCount,'_','\_');

% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');

% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TStringCount,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);
%title('Counting Task')

%Picture Naming Task ---------------------------------------------------------
[num,txt,raw] = xlsread('Picture_naming_speech.xlsx');
onset_diff_pic_name = num(:,9);
average_onset_diff_pic_name = sum(onset_diff_pic_name)/length(onset_diff_pic_name);
pic_name_sec = num(:,2);
pic_name_shock_sec = num(:,14);

pic_nam_label = txt(:,8);

error_labels_pic_name = {'Arrest', 'Slow', 'Substitution'};

%Arrest
pic_nam_arrest = find(strcmpi(error_labels_pic_name{1}, pic_nam_label));
avg_arrest_pic_name = sum(vertcat(onset_diff_pic_name(pic_nam_arrest)))/length(vertcat(onset_diff_pic_name(pic_nam_arrest)));
G = std(onset_diff_pic_name(pic_nam_arrest));

%slow
count_name_slow = find(strcmpi(error_labels_pic_name{2}, pic_nam_label));
avg_slow_pic_name = sum(vertcat(onset_diff_pic_name(count_name_slow)))/length(vertcat(onset_diff_pic_name(count_name_slow)));
H = std(vertcat(onset_diff_pic_name(count_name_slow)));

%Substitution
pic_name_sub = find(strcmpi(error_labels_pic_name{3}, pic_nam_label));
avg_sub_pic_name = sum(vertcat(onset_diff_pic_name(pic_name_sub))/length(vertcat(onset_diff_pic_name(pic_name_sub))));
I = std(vertcat(onset_diff_pic_name(pic_name_sub)));

%create table for Picture Naming 
error_labeling_pic_name = ({'Arrest'; 'Slow'; 'Substitution'});
Onset_Averages_pic_name = [avg_arrest_pic_name, avg_slow_pic_name,avg_sub_pic_name]';
SD_Onset_pic_name = [G,H,I]'

T_pic_name=table(Onset_Averages_pic_name,SD_Onset_pic_name,...
    'RowNames',error_labeling_pic_name)
TStringPicName = evalc('disp(T_pic_name)');

% Use TeX Markup for bold formatting and underscores.
figure
TStringPicName = strrep(TStringPicName,'<strong>','\bf');
TStringPicName = strrep(TStringPicName,'</strong>','\rm');
TStringPicName = strrep(TStringPicName,'_','\_');

% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');

% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TStringPicName,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);
%title('Counting Task')

%Auditory Naming Task ---------------------------------------------------------
[num,txt,raw] = xlsread('Auditory_naming_speech.xlsx');
onset_diff_aud_name = num(:,9);
average_onset_diff_aud_name = sum(onset_diff_aud_name)/length(onset_diff_aud_name)
aud_name_sec = num(:,2);
aud_name_shock_sec = num(:,15);

aud_nam_label = txt(:,8);

error_labels_aud_name = {'Arrest', 'Substitution'};

%Arrest
aud_nam_arrest = find(strcmpi(error_labels_aud_name{1}, aud_nam_label));
avg_arrest_aud_name = sum(vertcat(onset_diff_aud_name(aud_nam_arrest)))/length(vertcat(onset_diff_aud_name(aud_nam_arrest)));
L = std(onset_diff_aud_name(aud_nam_arrest));

%Substitution
aud_name_sub = find(strcmpi(error_labels_aud_name{2}, aud_nam_label));
avg_aud_name_sub = sum(vertcat(onset_diff_aud_name(aud_name_sub)))/length(vertcat(onset_diff_aud_name(aud_name_sub)));
K = std(onset_diff_aud_name(aud_name_sub));

%create table for Auditory Naming 
error_labeling_aud_name = {'Arrest', 'Substitution'};
Onset_Averages_aud_name = [avg_arrest_aud_name, avg_aud_name_sub]';
SD_Onset_aud_name = [L,K]'

T_pic_name=table(Onset_Averages_aud_name,SD_Onset_aud_name,...
    'RowNames',error_labeling_aud_name)
TStringAudName = evalc('disp(T_pic_name)');

% Use TeX Markup for bold formatting and underscores.
figure
TStringAudName = strrep(TStringAudName,'<strong>','\bf');
TStringAudName = strrep(TStringAudName,'</strong>','\rm');
TStringAudName = strrep(TStringAudName,'_','\_');

% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');

% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TStringAudName,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);
%title('Counting Task')

