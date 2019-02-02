%All speech data - Music/Stim Paper

% clear 
% clc
% close all

addpath(genpath('/Users/maansi/Desktop/Music-Stim/'))
directory = '/Users/maansi/Desktop/UCSF/Music-Stim/analysis';

%------------------- COMBINATION OF ALL SPEECH ----------------------------
[num,txt,raw] = xlsread('Speech_tasks_ALL.xlsx');
onsets = num(:,9);
average_onset = sum(onsets)/length(onsets);
start_time_error = num(:,2);
start_time_shock = num(:,13);

labels = txt(:,8);
both_offsets = num(:,4) - num(:,13);
error_labels = {'Arrest', 'Addition', 'Deletion', 'Slow', 'Substitution'};

%arrests
arrests = find(strcmpi(error_labels{1}, labels));
arrest_rows = vertcat(onsets(arrests)); %shock and error time diff.
avg_arrest = sum(arrest_rows)/length(arrest_rows);
A = std(arrest_rows);

%addition
addition = find(strcmpi(error_labels{2}, labels));
addition_rows = vertcat(onsets(addition));
avg_addition = sum(addition_rows)/length(addition_rows);
B = std(addition_rows);

%deletion
deletion = find(strcmpi(error_labels{3}, labels));
deletion_rows = vertcat(onsets(deletion));
avg_deletion = sum(deletion_rows)/length(deletion);
C = std(deletion_rows);

%slow
slow = find(strcmpi(error_labels{4}, labels));
slow_rows = vertcat(onsets(slow));
avg_slow = sum(slow_rows)/length(slow_rows);
D = std(slow_rows);

%substitution
substitution = find(strcmpi(error_labels{5}, labels));
substitution_rows = vertcat(onsets(substitution));
avg_substitution = sum(substitution_rows)/length(substitution_rows);
E = std(substitution_rows);

%create table
Error_Labels = ({'Arrest'; 'Addition'; 'Deletion'; 'Slow'; 'Substitution'});
Averages = [avg_arrest, avg_addition, avg_deletion, avg_slow, avg_substitution]';
Standard_Deviation = [A, B, C, D, E]'

T=table(Averages,Standard_Deviation,...
    'RowNames',Error_Labels)
TString = evalc('disp(T)');

figure
TString = strrep(TString,'<strong>','\bf');
TString = strrep(TString,'</strong>','\rm');
TString = strrep(TString,'_','\_');

% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');

% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

%create beeswarm 
figure
error_x = {arrest_rows; addition_rows; deletion_rows; slow_rows; substitution_rows};
%error_x_end = {arrest_rows_end; add_rows_end; slow_rows_end; sub_rows_end; deletion_rows_end};
plotSpread(error_x, ...
    'xNames', {'Arrest', 'Addition', 'Deletion', 'Slow', 'Substitution'}, ...
    'distributionMarkers', {'o', '+', '.', '*', 'o'})
title('Speech Tasks');
%xlabel('Error Types')
ylabel('Seconds')