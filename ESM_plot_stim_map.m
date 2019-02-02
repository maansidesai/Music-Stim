subj = 'EC86';
hemi = 'lh';
elec_sel = 'clinical';
elec_mode = 'elecs';
task = 'music'; % 'repetition', 'pic_naming', 'aud_naming', 'counting', 'days', 'music'

fld = {'repetition','pic_naming','aud_naming','counting','days','music'};
% fld = {'substitution','deletion','addition','slow','arrest'};

percent_error_flag = 1; % whether to plot percentages

%rootdir = '/Users/mattleonard/Documents/Research/data';
rootdir = '/Users/maansi/Documents/Research/data_store2/imaging/subjects';
localdir = '/Users/maansi/Desktop/Music-Stim/matfiles';


%% Load Data

load([rootdir '/' subj '/Meshes/EC86_lh_pial.mat']);
load([rootdir '/' subj '/elecs/hd_grid.mat']);

load([localdir '/' '/stim_results_' task '.mat']);

%% Plot Results

cmap = cbrewer('seq','Reds',101);

clrs = {[1 0 0],[0 0 1]};
elecmatrix(:,1) = elecmatrix(:,1) - 10;
switch elec_sel
    case 'research'
        elecs = elecmatrix;
    case 'clinical'
        idx_col = repmat([1 ; 0],size(elecmatrix,1)/2,1);
        idx_row = repmat([ones(sqrt(size(elecmatrix,1)),1) ; zeros(sqrt(size(elecmatrix,1)),1)],...
            sqrt(size(elecmatrix,1))/2,1);
        elecs = elecmatrix(find(idx_col & idx_row),:);
end

figure;
for j = 1:length(fld)
    fprintf('Plotting condition [%d] of [%d]\n',j,length(fld));
    p = plotGridPosition_new(j,length(fld),ceil(sqrt(length(fld))));
    axis off;
    axes('Position',p,'Visible','off');
%     subplot(3,2,j);
    ctmr_gauss_plot(cortex,[0 0 0],0,hemi);
    title(fld{j});
    
%     for i = 1:size(elecs,1)
%         scatter3(elecs(i,1),...
%             elecs(i,2),...
%             elecs(i,3),...
%             50,'k','filled');
% %         text(elecs(i,1),elecs(i,2),elecs(i,3),num2str(i));
%     end
    
    for i = 1:size(stim.(fld{j}).elecs,1)
        switch elec_mode
            case 'elecs'
                for k = 1:2
                    scatter3(elecs(stim.(fld{j}).elecs(i,k),1)+1,...
                        elecs(stim.(fld{j}).elecs(i,k),2),...
                        elecs(stim.(fld{j}).elecs(i,k),3),...
                        50,'k','filled');
                end
            case 'nums'
                for k = 1:2
                    text(elecs(stim.(fld{j}).elecs(i,k),1)+1,...
                        elecs(stim.(fld{j}).elecs(i,k),2),...
                        elecs(stim.(fld{j}).elecs(i,k),3),...
                        num2str(stim.(fld{j}).elecs(i,k)));
                end
        end
        h(i,j) = plot3([elecs(stim.(fld{j}).elecs(i,1),1)+1 elecs(stim.(fld{j}).elecs(i,2),1)+1],...
            [elecs(stim.(fld{j}).elecs(i,1),2) elecs(stim.(fld{j}).elecs(i,2),2)],...
            [elecs(stim.(fld{j}).elecs(i,1),3) elecs(stim.(fld{j}).elecs(i,2),3)],...
            'LineWidth',3);
        if percent_error_flag
            set(h(i,j),'Color',cmap(round((stim.(fld{j}).error_num(i) / stim.(fld{j}).num_stims(i))*100)+1,:));
        else
            if stim.(fld{j}).error(i) == 1
                set(h(i,j),'Color','r');
            else
                set(h(i,j),'Color',[1 1 1]);
            end
        end
    end
end

