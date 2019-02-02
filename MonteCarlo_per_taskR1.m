%Monte-Carlo analysis: Music-Stim paper
% Load all stim_results_ (task name) 
% Per task - collapsed across errors, not concat across all tasks/errors

clear all
close all

addpath(genpath('/Users/maansi/Desktop/Music-Stim/matfiles'))

rootdir = '/Users/maansi/Desktop/Music-Stim/matfiles'; 

tasks = {'repetition','pic_naming','aud_naming','counting','music'};

repetition = load([rootdir '/stim_results_' tasks{1} '.mat']);
pic_naming = load([rootdir '/stim_results_' tasks{2} '.mat']);
aud_naming = load([rootdir '/stim_results_' tasks{3} '.mat']);
counting = load([rootdir '/stim_results_' tasks{4} '.mat']);
music = load([rootdir '/stim_results_' tasks{5} '.mat']);

%errors_nStim = {'stim.substitution.num_stims','stim.deletion.num_stims','stim.addition.num_stims','stim.slow.num_stims','stim.arrest.num_stims'};
%errors_error_num = {'stim.substitution.error_num','stim.deletion.error_num','stim.addition.error_nums','stim.slow.error_num','stim.arrest.error_num'};
%%
%repetition 
rep_elec_pairs = [];
rep_error_num = [];
rep_nStim = [];
for i=1:length(repetition) 
   rep_elec_pairs = [rep_elec_pairs; repetition.stim.substitution.elecs]; 
   rep_error_num = [rep_error_num; repetition.stim.substitution.error_num repetition.stim.deletion.error_num repetition.stim.addition.error_num repetition.stim.slow.error_num repetition.stim.arrest.error_num];
   rep_nStim = [rep_nStim; repetition.stim.substitution.num_stims repetition.stim.deletion.num_stims repetition.stim.addition.num_stims repetition.stim.slow.num_stims repetition.stim.arrest.num_stims];   
end
rep_concat = [rep_elec_pairs rep_error_num rep_nStim];


for i = 1:size(rep_concat,1)
    elec_str{i} = [num2str(rep_concat(i,1)) '-' num2str(rep_concat(i,2))];
end

%tally up error_num
rep_error_num_sum = num2cell(sum(rep_concat(:,3:7),2));
rep_nStim_sum = num2cell(sum(rep_concat(:,8:12),2));

output_rep = [[elec_str]' rep_error_num_sum rep_nStim_sum];
pct_errs_rep = cell2mat(output_rep(:,2))./cell2mat(output_rep(:,3));

%create permutation for repetition task (all errors collapsed)
null_data_rep = [];
for i = 1:1000
    idx_rep=randperm(size(pct_errs_rep,1));
    null_data_rep(i,:) = pct_errs_rep(idx_rep);
end

for i = 1:size(null_data_rep,2)
    null_CI_rep(i,:,:) = (mean(null_data_rep(:,i))) + (tinv([0.025 0.975],length(null_data_rep(:,i))-1) * (std(null_data_rep(:,i)) / sqrt(length(null_data_rep(:,i)))));
end

tmp_rep = cell2mat(output_rep(:,2:3));
for i = 1:size(tmp_rep,1)
    if tmp_rep(i,1) == 0
        tmp_sig(i) = 2;
    elseif (tmp_rep(i,1) > 0) & ((tmp_rep(i,1)/tmp_rep(i,2)) >= (mean(mean(null_data_rep)) + max(max(max(null_CI_rep)))))
        tmp_sig(i) = 1;
    else
        tmp_sig(i) = 0;
    end
end

length(find(tmp_sig == 1))
%%
%pic_naming 
picN_elec_pairs = [];
picN_error_num = [];
picN_nStim = [];
for i=1:length(pic_naming) 
   picN_elec_pairs = [picN_elec_pairs; pic_naming.stim.substitution.elecs]; 
   picN_error_num = [picN_error_num; pic_naming.stim.substitution.error_num pic_naming.stim.deletion.error_num pic_naming.stim.addition.error_num pic_naming.stim.slow.error_num pic_naming.stim.arrest.error_num];
   picN_nStim = [picN_nStim; pic_naming.stim.substitution.num_stims pic_naming.stim.deletion.num_stims pic_naming.stim.addition.num_stims pic_naming.stim.slow.num_stims pic_naming.stim.arrest.num_stims];
    
end
picN_concat = [picN_elec_pairs picN_error_num picN_nStim];

%elec_str_picN = [];
for i = 1:size(picN_concat,1)
    elec_str_picN{i} = [num2str(picN_concat(i,1)) '-' num2str(picN_concat(i,2))];
    %elec_str_picN = elec_str_picN';
end

%tally up error_num
picN_error_num_sum = num2cell(sum(picN_concat(:,3:7),2));
picN_nStim_sum = num2cell(sum(picN_concat(:,8:12),2));

output_picN = [[elec_str_picN]' picN_error_num_sum picN_nStim_sum];
pct_errs_picN = cell2mat(output_picN(:,2))./cell2mat(output_picN(:,3));

%create permutation for picture naming task (all errors collapsed)
null_data_picN = [];
for i = 1:1000
    idx_picN=randperm(size(pct_errs_picN,1));
    null_data_picN(i,:) = pct_errs_picN(idx_picN);
end

for i = 1:size(null_data_picN,2)
    null_CI_picN(i,:,:) = (mean(null_data_picN(:,i))) + (tinv([0.025 0.975],length(null_data_picN(:,i))-1) * (std(null_data_picN(:,i)) / sqrt(length(null_data_picN(:,i)))));
end

tmp_picN = cell2mat(output_picN(:,2:3));
for i = 1:size(tmp_picN,1)
    if tmp_picN(i,1) == 0
        tmp_sig(i) = 2;
    elseif (tmp_picN(i,1) > 0) & ((tmp_picN(i,1)/tmp_picN(i,2)) >= (mean(mean(null_data_picN)) + max(max(max(null_CI_picN)))))
        tmp_sig(i) = 1;
    else
        tmp_sig(i) = 0;
    end
end

length(find(tmp_sig == 1))

%%
%aud_naming
audN_elec_pairs = [];
audN_error_num = [];
audN_nStim = [];
for i=1:length(aud_naming) 
   audN_elec_pairs = [audN_elec_pairs; aud_naming.stim.substitution.elecs]; 
   audN_error_num = [audN_error_num; aud_naming.stim.substitution.error_num aud_naming.stim.deletion.error_num aud_naming.stim.addition.error_num aud_naming.stim.slow.error_num aud_naming.stim.arrest.error_num];
   audN_nStim = [audN_nStim; aud_naming.stim.substitution.num_stims aud_naming.stim.deletion.num_stims aud_naming.stim.addition.num_stims aud_naming.stim.slow.num_stims aud_naming.stim.arrest.num_stims];
    
end
audN_concat = [audN_elec_pairs audN_error_num audN_nStim];

for i = 1:size(audN_concat,1)
    elec_str_audN{i} = [num2str(audN_concat(i,1)) '-' num2str(audN_concat(i,2))];
    %elec_str_picN = elec_str_picN';
end

%tally up error_num
audN_error_num_sum = num2cell(sum(audN_concat(:,3:7),2));
audN_nStim_sum = num2cell(sum(audN_concat(:,8:12),2));

output_audN = [[elec_str_audN]' audN_error_num_sum audN_nStim_sum];
pct_errs_audN = cell2mat(output_audN(:,2))./cell2mat(output_audN(:,3));

%create permutation for auditory naming task (all errors collapsed)
null_data_audN = [];
for i = 1:1000
    idx_audN=randperm(size(pct_errs_audN,1));
    null_data_audN(i,:) = pct_errs_audN(idx_audN);
end

for i = 1:size(null_data_audN,2)
    null_CI_audN(i,:,:) = (mean(null_data_audN(:,i))) + (tinv([0.025 0.975],length(null_data_audN(:,i))-1) * (std(null_data_audN(:,i)) / sqrt(length(null_data_audN(:,i)))));
end

tmp_audN = cell2mat(output_audN(:,2:3));
for i = 1:size(tmp_audN,1)
    if tmp_audN(i,1) == 0
        tmp_sig(i) = 2;
    elseif (tmp_audN(i,1) > 0) & ((tmp_audN(i,1)/tmp_audN(i,2)) >= (mean(mean(null_data_audN)) + max(max(max(null_CI_audN)))))
        tmp_sig(i) = 1;
    else
        tmp_sig(i) = 0;
    end
end

length(find(tmp_sig == 1))


%%
%counting 
count_elec_pairs = [];
count_error_num = [];
count_nStim = [];
for i=1:length(counting) 
   count_elec_pairs = [count_elec_pairs; counting.stim.substitution.elecs]; 
   count_error_num = [count_error_num; counting.stim.substitution.error_num counting.stim.deletion.error_num counting.stim.addition.error_num counting.stim.slow.error_num counting.stim.arrest.error_num];
   count_nStim = [count_nStim; counting.stim.substitution.num_stims counting.stim.deletion.num_stims counting.stim.addition.num_stims counting.stim.slow.num_stims counting.stim.arrest.num_stims];
    
end
count_concat = [count_elec_pairs count_error_num count_nStim];

for i = 1:size(count_concat,1)
    elec_str_count{i} = [num2str(count_concat(i,1)) '-' num2str(count_concat(i,2))];
    %elec_str_picN = elec_str_picN';
end

%tally up error_num
count_error_num_sum = num2cell(sum(count_concat(:,3:7),2));
count_nStim_sum = num2cell(sum(count_concat(:,8:12),2));

output_count = [[elec_str_count]' count_error_num_sum count_nStim_sum];
pct_errs_count = cell2mat(output_count(:,2))./cell2mat(output_count(:,3));

%create permutation for counting task (all errors collapsed)
null_data_count = [];
for i = 1:1000
    idx_count=randperm(size(pct_errs_count,1));
    null_data_count(i,:) = pct_errs_count(idx_count);
end

for i = 1:size(null_data_count,2)
    null_CI_count(i,:,:) = (mean(null_data_count(:,i))) + (tinv([0.025 0.975],length(null_data_count(:,i))-1) * (std(null_data_count(:,i)) / sqrt(length(null_data_count(:,i)))));
end

tmp_count = cell2mat(output_count(:,2:3));
for i = 1:size(tmp_count,1)
    if tmp_count(i,1) == 0
        tmp_sig(i) = 2;
    elseif (tmp_count(i,1) > 0) & ((tmp_count(i,1)/tmp_count(i,2)) >= (mean(mean(null_data_count)) + max(max(max(null_CI_count)))))
        tmp_sig(i) = 1;
    else
        tmp_sig(i) = 0;
    end
end

length(find(tmp_sig == 1))
%%
%music 
music_elec_pairs = [];
music_error_num = [];
music_nStim = [];
for i=1:length(music) 
   music_elec_pairs = [music_elec_pairs; music.stim.substitution.elecs]; 
   music_error_num = [music_error_num; music.stim.substitution.error_num music.stim.deletion.error_num music.stim.addition.error_num music.stim.slow.error_num music.stim.arrest.error_num];
   music_nStim = [music_nStim; music.stim.substitution.num_stims music.stim.deletion.num_stims music.stim.addition.num_stims music.stim.slow.num_stims music.stim.arrest.num_stims];
    
end
music_concat = [music_elec_pairs music_error_num music_nStim];

for i = 1:size(music_concat,1)
    elec_str_music{i} = [num2str(music_concat(i,1)) '-' num2str(music_concat(i,2))];
    %elec_str_picN = elec_str_picN';
end

%tally up error_num
music_error_num_sum = num2cell(sum(music_concat(:,3:7),2));
music_nStim_sum = num2cell(sum(music_concat(:,8:12),2));

output_music = [[elec_str_music]' music_error_num_sum music_nStim_sum];
pct_errs_music = cell2mat(output_music(:,2))./cell2mat(output_music(:,3));

%create permutation for music task (all errors collapsed)
null_data_music = [];
for i = 1:1000
    idx_music=randperm(size(pct_errs_music,1));
    null_data_music(i,:) = pct_errs_music(idx_music);
end

for i = 1:size(null_data_music,2)
    null_CI_music(i,:,:) = (mean(null_data_music(:,i))) + (tinv([0.025 0.975],length(null_data_music(:,i))-1) * (std(null_data_music(:,i)) / sqrt(length(null_data_music(:,i)))));
end

tmp_music = cell2mat(output_music(:,2:3));
for i = 1:size(tmp_music,1)
    if tmp_music(i,1) == 0
        tmp_sig(i) = 2;
    elseif (tmp_music(i,1) > 0) & ((tmp_music(i,1)/tmp_music(i,2)) >= (mean(mean(null_data_music)) + max(max(max(null_CI_music)))))
        tmp_sig(i) = 1;
    else
        tmp_sig(i) = 0;
    end
end

length(find(tmp_sig == 1))