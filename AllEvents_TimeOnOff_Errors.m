clear 
clc
close all

addpath(genpath('/Users/maansi/Desktop/Music-Stim/'))
directory = '/Users/maansi/Desktop/UCSF/Music-Stim/analysis';

%xlsread below contains all events around shock onset, so multiple errors,
%not just the first one:

[num,txt,raw] = xlsread('Error_types_all.xlsx');
start_error_type_sec = (num(:,2));
end_time_error_sec = num(:,4);
error_label_type = txt(:,9);

%shock times to match dimensions:
[num,txt,raw] = xlsread('Shock_times_all.xlsx');
start_time_shock_sec = num(:,2);
end_time_shock_sec = num(:,4);
shock_label = txt(:,8);

average_onset_error_types_all = sum(start_error_type_sec - start_time_shock_sec)/(length(start_error_type_sec))

error_labels = {'Arrest', 'Slow', 'Deletion', 'Substitution', 'Addition'};

%Arrest
arr = strcmpi(error_labels{1}, error_label_type);
row_num_arrest = find(arr==1);
arrest_rows = vertcat(start_error_type_sec(row_num_arrest));
arrest_rows_end = vertcat(end_time_error_sec(row_num_arrest));

shock_rows_arr = vertcat(start_time_shock_sec(row_num_arrest));
shock_rows_arr_end = vertcat(end_time_shock_sec(row_num_arrest));
average_arrest_onset = (sum(arrest_rows - shock_rows_arr)/length(arrest_rows));
average_arrest_offset = (sum(arrest_rows - end_time_shock_sec(row_num_arrest)))/length(arrest_rows);

%Slow
slow = strcmpi(error_labels{2}, error_label_type);
row_num_slow = find(slow==1);
slow_rows = vertcat(start_error_type_sec(row_num_slow));
slow_rows_end = vertcat(end_time_error_sec(row_num_slow));

shock_rows_slow = vertcat(start_time_shock_sec(row_num_slow));
shock_rows_slow_end = vertcat(end_time_shock_sec(row_num_slow));
average_slow_onset = (sum(slow_rows - shock_rows_slow)/length(slow_rows));
average_slow_offset = (sum(slow_rows - end_time_shock_sec(row_num_slow)))/length(slow_rows);

%Deletion
deletion = strcmpi(error_labels{3}, error_label_type);
row_num_deletion = find(deletion==1);
deletion_rows = vertcat(start_error_type_sec(row_num_deletion));
deletion_rows_end = vertcat(end_time_error_sec(row_num_deletion));

shock_rows_deletion = vertcat(start_time_shock_sec(row_num_deletion));
shock_rows_deletion_end = vertcat(end_time_shock_sec(row_num_deletion));

average_deletion_onset = (sum(deletion_rows - shock_rows_deletion)/length(deletion_rows));
average_deletion_offset = (sum(deletion_rows - end_time_shock_sec(row_num_deletion)))/length(deletion_rows);

%Substitution (onset and offset) -- all instances of sub. occured post stim
sub = strcmpi(error_labels{4}, error_label_type);
row_num_sub = find(sub==1);
sub_rows = vertcat(start_error_type_sec(row_num_sub));
sub_rows_end = vertcat(end_time_error_sec(row_num_sub));

shock_rows_sub = vertcat(start_time_shock_sec(row_num_sub));
shock_rows_sub_end = vertcat(end_time_shock_sec(row_num_sub));

average_sub_onset = (sum(sub_rows - shock_rows_sub)/length(sub_rows));
average_sub_offset = (sum(sub_rows - end_time_shock_sec(row_num_sub)))/length(sub_rows);

%Addition only one instance -- occurs after stim is over
add = strcmpi(error_labels{5}, error_label_type);
row_num_add = find(add==1);

add_rows = vertcat(start_error_type_sec(row_num_add));
add_rows_end = vertcat(end_time_error_sec(row_num_add));

shock_rows_add = vertcat(start_time_shock_sec(row_num_add));
shock_rows_add_end = vertcat(end_time_shock_sec(row_num_add));

average_add_onset = (sum(add_rows - shock_rows_add)/length(add_rows));
average_add_offset = (sum(add_rows - end_time_shock_sec(row_num_add)))/length(add_rows);

%difference for onset
diff_addition_on = add_rows - shock_rows_add;
diff_arrest_on = arrest_rows - shock_rows_arr;
diff_deletion_on = deletion_rows - shock_rows_deletion;
diff_slow_on = slow_rows - shock_rows_slow;
diff_substitution_on = sub_rows - shock_rows_sub;

%difference for Offset
diff_addition_off = add_rows_end - shock_rows_add_end;
diff_arrest_off = arrest_rows_end - shock_rows_arr_end;
diff_deletion_off = deletion_rows_end - shock_rows_deletion_end;
diff_slow_off = slow_rows_end - shock_rows_slow_end;
diff_substitution_off = sub_rows_end - shock_rows_sub_end;

%standard deviations onset 
A = std(diff_arrest_on);
E = std(diff_addition_on);
B = std(diff_slow_on);
C = std(diff_deletion_on);
D = std(diff_substitution_on);

%standard deviations offset
F = std(diff_arrest_off);
G = std(diff_slow_off);
H = std(diff_deletion_off);
I = std(diff_substitution_off);
J = std(diff_addition_off);

%Create Table
error_labeling_T = ({'Arrest'; 'Slow'; 'Deletion'; 'Substitution'; 'Addition'});
Onset_Averages = [average_arrest_onset, average_slow_onset, average_deletion_onset, average_sub_onset, average_add_onset]';
Offset_Averages = [average_arrest_offset, average_slow_offset, average_deletion_offset, average_sub_offset, average_add_offset]';
SD_Onset = [A, B, C, D, E]';
SD_Offset = [F, G, H, I, J]'; 


T=table(Onset_Averages,Offset_Averages,SD_Onset,SD_Offset,...
    'RowNames',error_labeling_T)

TString = evalc('disp(T)');
TString = evalc('disp(T)');

% Use TeX Markup for bold formatting and underscores.
TString = strrep(TString,'<strong>','\bf');
TString = strrep(TString,'</strong>','\rm');
TString = strrep(TString,'_','\_');

% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');

% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

savefig('AllEvents_around_ShockTimes')

%-----------------------------------------------------------------------%
%Bee swarm plot all points
figure
error_x = {arrest_rows; add_rows; slow_rows; sub_rows; deletion_rows};
plotSpread(error_x,...
    'xNames', {'Arrest', 'Addition', 'Slow', 'Substitution', 'Deletion'}, ...
    'distributionMarkers', {'o', '+', '.', '*', 'o'})
hold on

shock_timing_y = {shock_rows_arr; shock_rows_add; shock_rows_slow; shock_rows_sub; shock_rows_deletion};
plotSpread(shock_timing_y,...
    'yLabel', {'Time (s)'},...
    'distributionMarkers', {'o', '+', '.', '*', 'o'},'distributionColors', {'r'})
ylim([0 1050])
title('All Errors Plotted with All Stim Times')
legend('Error Time', 'Stim Time')
savefig('BeeSwarm-allPoints_errorsOnly_ALL')

%Bee Swarm plot for Onsets/Offsets
figure
BeeOnset = {diff_addition_on; diff_arrest_on; diff_deletion_on; diff_slow_on; diff_substitution_on};
plotSpread(BeeOnset,...
    'xNames', {'Addition', 'Arrest', 'Deletion', 'Slow', 'Substitution'}, ...
    'distributionMarkers', {'o', '+', '.', '*', 'o'}, 'distributionColors',{'k'})
%ylim([-2 8])
title('Onset and Offset plots: difference between error and stim times')

hold on
BeeOffset = {diff_addition_off; diff_arrest_off; diff_deletion_off; diff_slow_off; diff_substitution_off};
plotSpread(BeeOffset,...
    'yLabel', {'Time (s)'},...
    'distributionMarkers', {'o', '+', '.', '*', 'o'}, 'distributionColors',{'r'})
legend('Error Onset time', 'Error Offset time');
savefig('BeeSwarm-Onset_Offset_times_ALL')