%Monte-Carlo analysis: Music-Stim paper
% Load all stim_results_ (task name) 

clear all
close all

addpath(genpath('/Users/maansi/Desktop/Music-Stim/matfiles'))
% tasks = {'repetition','pic_naming','aud_naming','counting','music'};

directory = '/Users/maansi/Desktop/Music-Stim/matfiles/';

all_sites = [];

addition = [];
arrest = [];
deletion = [];
slow = [];
substitution = [];

matfiles = dir('*.mat');
for i=1:numel(matfiles)
    A = load(matfiles(i).name);
    all_sites = [A(1).stim; all_sites];
end


for i=1:length(all_sites)
    addition = [getfield(all_sites(i), 'addition'); addition];
    arrest = [getfield(all_sites(i), 'arrest'); arrest];
    deletion = [getfield(all_sites(i), 'deletion'); deletion];
    slow = [getfield(all_sites(i), 'slow'); slow];
    substitution = [getfield(all_sites(i), 'substitution'); substitution];
end

%%
%Substition 
nStim_sub = [];
numStim_sub = [];
error_sub = [];

for i=1:length(substitution)
    nStim_sub = [nStim_sub; substitution(i).elecs];
    numStim_sub = [numStim_sub; substitution(i).num_stims];
%     error_sub = [error_sub; substitution(i).error];
    error_sub = [error_sub; substitution(i).error_num]; % MKL
end
concat_sub = [nStim_sub error_sub numStim_sub];

%%
%Slow

nStim_slow = [];
numStim_slow = [];
error_slow = [];

for i=1:length(slow)
    nStim_slow = [nStim_slow; slow(i).elecs];
    numStim_slow = [numStim_slow; slow(i).num_stims];
%     error_slow = [error_slow; slow(i).error];
    error_slow = [error_slow; slow(i).error_num]; % MKL
end
concat_slow = [nStim_slow error_slow numStim_slow];

%%
%Deletion 

nStim_del = [];
numStim_del = [];
error_del = [];

for i=1:length(deletion)
    nStim_del = [nStim_del; deletion(i).elecs];
    numStim_del = [numStim_del; deletion(i).num_stims];
%     error_del = [error_del; deletion(i).error];
    error_del = [error_del; deletion(i).error_num]; % MKL
end
concat_del = [nStim_del error_del numStim_del];


%%
%Arrest 

nStim_arr = [];
numStim_arr = [];
error_arr = [];

for i=1:length(arrest)
    nStim_arr = [nStim_arr; arrest(i).elecs];
    numStim_arr = [numStim_arr; arrest(i).num_stims];
%     error_arr = [error_arr; arrest(i).error];
    error_arr = [error_arr; arrest(i).error_num]; % MKL
end
concat_arr = [nStim_arr error_arr numStim_arr];

%%
%Addition 
nStim_add = [];
numStim_add = [];
error_add = [];

for i=1:length(addition)
    nStim_add = [nStim_add; addition(i).elecs];
    numStim_add = [numStim_add; addition(i).num_stims];
%     error_add = [error_add; addition(i).error];
    error_add = [error_add; addition(i).error_num]; % MKL
end
concat_add = [nStim_add error_add numStim_add];

%%
concat_all_errors = [concat_add; concat_arr; concat_del; concat_slow; concat_sub]; %create large array of all error types

for i = 1:size(concat_all_errors,1)
    elec_str{i} = [num2str(concat_all_errors(i,1)) '-' num2str(concat_all_errors(i,2))];
    
end

elec_str_mat = zeros(size(concat_all_errors(:,1:3)));

errors_all = num2cell(concat_all_errors(:,3));
num_stim_all = num2cell(concat_all_errors(:,4));
elec_str_mat = [(elec_str') errors_all num_stim_all];


[ii,jj,kk] = unique(elec_str_mat(:,1));
output_errorsum=[ii num2cell(accumarray(kk,[elec_str_mat{:,2}]'))]; %sums all error based on unique elec pairs
output_numstim_sum = [ii num2cell(accumarray(kk,[elec_str_mat{:,3}]'))]; %sums all "total number of stims" based on unique elec pairs

output_MC = [output_errorsum output_numstim_sum(:,2)];
%%
%Create permutation based on output_errorsum and output_numstim_sum arrays

pct_errs = cell2mat(output_MC(:,2))./cell2mat(output_MC(:,3));
null_data = [];
for i = 1:1000
    idx=randperm(size(pct_errs,1));
    null_data(i,:) = pct_errs(idx);
end

for i = 1:size(null_data,2)
    null_CI(i,:,:) = (mean(null_data(:,i))) + (tinv([0.025 0.975],length(null_data(:,i))-1) * (std(null_data(:,i)) / sqrt(length(null_data(:,i)))));
end

tmp = concat_all_errors(:,3:4);
for i = 1:size(tmp,1)
    if tmp(i,1) == 0
        tmp_sig(i) = 2;
    elseif (tmp(i,1) > 0) & ((tmp(i,1)/tmp(i,2)) >= (mean(mean(null_data)) + max(max(max(null_CI)))))
        tmp_sig(i) = 1;
    else
        tmp_sig(i) = 0;
    end
end

length(find(tmp_sig == 1))