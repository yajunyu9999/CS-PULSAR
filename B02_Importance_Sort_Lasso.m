clear all

root_dataRead = '';
root_dataSave = '';

NumSelect = 5;
DF_Select = 20;

B_stat_abs = zeros(1386, 50);
B_stat_cnt = zeros(1386, 50);

RE_stat_abs = zeros(1386, 50);
RE_stat_cnt = zeros(1386, 50);

for num = 1:50

aa=load([root_dataRead, '\Img_FS_Lasso_all_delta_Loop',num2str(num),'.mat']);
B1=aa.B1;
FitInfo = aa.FitInfo;
RE = aa.RE;

DF = FitInfo.DF;
idx_DF = find(DF>=DF_Select);

bb_B=B1(:,idx_DF(end));
bb_RE=RE(:,idx_DF(end));

[cc_B, I_B]=sort(abs(bb_B), 'descend');

B_stat_abs(I_B(1:NumSelect), num) = cc_B(1:NumSelect);
B_stat_cnt(I_B(1:NumSelect), num) = 1;

[cc_RE, I_RE]=sort(abs(bb_RE), 'ascend');
idx = find(cc_RE~=0);

RE_stat_abs(I_RE(idx(1):idx(1)+NumSelect-1), num) = cc_RE(idx(1):idx(1)+NumSelect-1);
RE_stat_cnt(I_RE(idx(1):idx(1)+NumSelect-1), num) = 1;

end
    
B_stat_abs_avg = mean(B_stat_abs, 2);
B_stat_cnt_avg = mean(B_stat_cnt, 2);
RE_stat_abs_avg = mean(RE_stat_abs, 2);
RE_stat_cnt_avg = mean(RE_stat_cnt, 2);

[A1, I_B_stat_abs] = sort(B_stat_abs_avg, "descend");
[A2, I_B_stat_cnt] = sort(B_stat_cnt_avg, "descend");
[A3, I_RE_stat_abs] = sort(RE_stat_abs_avg, "descend");
[A4, I_RE_stat_cnt] = sort(RE_stat_cnt_avg, "descend");

save([root_dataSave, '\Rank_nonCS_NSelect',num2str(NumSelect),'.mat'],...
    "I_B_stat_abs","I_B_stat_cnt","I_RE_stat_abs","I_RE_stat_cnt")

