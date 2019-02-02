%{

Maansi Desai, July-August 2017 

Study: Music/Stim Analysis  

This script takes the Error types and shock times and finds the average
onset of each error in relation to the shock time, both overall and for
each error (i.e. Addition, Deletion, Slow, Arrest, and Substitution)

The excel files which are read into this script have already been filtered
out to only consist of the agreed upon errors which occured during
stimulation or no more than 5 seconds post stimulation. 

%}

clear 
clc

addpath(genpath('/Users/maansi/Desktop/Music-Stim/'))
directory = '/Users/maansi/Desktop/UCSF/Music-Stim/analysis';

[num,txt,raw] = xlsread('Error_types_1.xlsx');
start_error_type_sec = (num(:,2));
end_time_error_sec = num(:,4);
error_label_type = txt(:,8);

[num,txt,raw] = xlsread('Shock_times_1.xlsx');
start_time_shock_sec = num(:,2);
end_time_shock_sec = num(:,4);
shock_label = txt(:,8);

average_onset_all_events = sum(start_error_type_sec - start_time_shock_sec)/(length(start_error_type_sec))


error_labels = {'Arrest', 'Slow', 'Deletion', 'Substitution', 'Addition'};

%Arrest
arr = strcmpi(error_labels{1}, error_label_type);
row_num_arrest = find(arr==1);
arrest_rows = vertcat(start_error_type_sec(row_num_arrest));
shock_rows_arr = vertcat(start_time_shock_sec(row_num_arrest));
average_arrest_onset = (sum(arrest_rows - shock_rows_arr)/length(arrest_rows));
average_arrest_offset = (sum(arrest_rows - end_time_shock_sec(row_num_arrest)))/length(arrest_rows);

%Slow
slow = strcmpi(error_labels{2}, error_label_type);
row_num_slow = find(slow==1);
slow_rows = vertcat(start_error_type_sec(row_num_slow));
shock_rows_slow = vertcat(start_time_shock_sec(row_num_slow));
average_slow_onset = (sum(slow_rows - shock_rows_slow)/length(slow_rows));
average_slow_offset = (sum(slow_rows - end_time_shock_sec(row_num_slow)))/length(slow_rows);

%Deletion
deletion = strcmpi(error_labels{3}, error_label_type);
row_num_deletion = find(deletion==1);
deletion_rows = vertcat(start_error_type_sec(row_num_deletion));
shock_rows_deletion = vertcat(start_time_shock_sec(row_num_deletion));
average_deletion_onset = (sum(deletion_rows - shock_rows_deletion)/length(deletion_rows));
average_deletion_offset = (sum(deletion_rows - end_time_shock_sec(row_num_deletion)))/length(deletion_rows);

%Substitution (onset and offset) -- all instances of sub. occured post stim
sub = strcmpi(error_labels{4}, error_label_type);
row_num_sub = find(sub==1);
sub_rows = vertcat(start_error_type_sec(row_num_sub));
shock_rows_sub = vertcat(start_time_shock_sec(row_num_sub));
average_sub_onset = (sum(sub_rows - shock_rows_sub)/length(sub_rows));
average_sub_offset = (sum(sub_rows - end_time_shock_sec(row_num_sub)))/length(sub_rows);

%Addition only one instance -- occurs after stim is over
add = strcmpi(error_labels{5}, error_label_type);
row_num_add = find(add==1);
add_rows = vertcat(start_error_type_sec(row_num_add));
shock_rows_add = vertcat(start_time_shock_sec(row_num_add));
average_add_onset = (sum(add_rows - shock_rows_add)/length(add_rows));
average_add_offset = (sum(add_rows - end_time_shock_sec(row_num_add)))/length(add_rows);

%Create Table
error_labeling_T = ({'Arrest'; 'Slow'; 'Deletion'; 'Substitution'; 'Addition'});
Onset_Averages = [average_arrest_onset, average_slow_onset, average_deletion_onset, average_sub_onset, average_add_onset]';
Offset_Averages = [average_arrest_offset, average_slow_offset, average_deletion_offset, average_sub_offset, average_add_offset]';

T=table(Onset_Averages,Offset_Averages,...
    'RowNames',error_labeling_T)

