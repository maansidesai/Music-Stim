rootdir = '/Users/maansi/Desktop/Music-Stim/Final Items/matfiles';

tasks = {'repetition','pic_naming','aud_naming','counting','music'};

elec_pairs = [];
nStims = [];
for i = 1:length(tasks)
    load([rootdir '/stim_results_' tasks{i} '.mat']);
    elec_pairs = [elec_pairs ; stim.substitution.elecs];
    nStims = [nStims ; stim.substitution.num_stims];
end

unique_elec_pairs = unique(elec_pairs,'rows');

%%
figure;


ctmr_gauss_plot(cortex,[0 0 0],0,'lh');

for i = 1:size(unique_elec_pairs,1)
    scatter3(elecmatrix(unique_elec_pairs(i,1),1)-2,elecmatrix(unique_elec_pairs(i,1),2),elecmatrix(unique_elec_pairs(i,1),3),...
        20,'r','filled');
    hold on;
    scatter3(elecmatrix(unique_elec_pairs(i,2),1)-2,elecmatrix(unique_elec_pairs(i,2),2),elecmatrix(unique_elec_pairs(i,2),3),...
        20,'r','filled');
    text(elecmatrix(unique_elec_pairs(i,1),1)-2,elecmatrix(unique_elec_pairs(i,1),2),elecmatrix(unique_elec_pairs(i,1),3),...
        num2str(unique_elec_pairs(i,1)));
    text(elecmatrix(unique_elec_pairs(i,2),1)-2,elecmatrix(unique_elec_pairs(i,2),2),elecmatrix(unique_elec_pairs(i,2),3),...
        num2str(unique_elec_pairs(i,2)));
    plot3([elecmatrix(unique_elec_pairs(i,1),1) elecmatrix(unique_elec_pairs(i,2),1)],...
        [elecmatrix(unique_elec_pairs(i,1),2) elecmatrix(unique_elec_pairs(i,2),2)],...
        [elecmatrix(unique_elec_pairs(i,1),3) elecmatrix(unique_elec_pairs(i,2),3)],...
        'Color','r');
end

%%

for i = 1:size(unique_elec_pairs,1)
    elec_anat(i,1) = anatomy(unique_elec_pairs(i,1),4);
    elec_anat(i,2) = anatomy(unique_elec_pairs(i,2),4);
end

%%

for i = 1:size(elec_pairs,1)
    anat_stim(i,1) = anatomy(elec_pairs(i,1),4);
    anat_stim(i,2) = anatomy(elec_pairs(i,2),4);
end

%%

unique_stim_sites = unique(stim_sites);
for i = 1:length(unique_stim_sites)
    total_nStims(i) = sum(nStims(find(strcmpi(stim_sites,unique_stim_sites(i)))));
end