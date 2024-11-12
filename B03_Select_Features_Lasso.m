clear all

root_dataRead1 = '';
root_dataRead2 = '';
root_dataSave = '';

NumSelect = 5;

aa=load([root_dataRead1, '\Rank_nonCS_NSelect',num2str(NumSelect),'.mat']);
I_B_stat_abs = aa.I_B_stat_abs;
I_B_stat_cnt = aa.I_B_stat_cnt;
I_RE_stat_cnt = aa.I_RE_stat_cnt;

for num = 1:50
sheetname=[root_dataRead2, '\Data_Loop',num2str(num),'.xlsx'];
    TrainData = readtable(sheetname, 'Sheet','TrainData');
    TestData = readtable(sheetname, 'Sheet','TestData');

%%
    for num_fs = 1:NumSelect
        idx = I_B_stat_abs(1:num_fs);
        TrainSelect = TrainData(:, [1; idx+1]);
        TestSelect = TestData(:, [1; idx+1]);
file_w=[root_dataSave, '\Loop',num2str(num),'\B_stat_abs_NumFS',num2str(num_fs),'.xlsx'];
        writetable(TrainSelect, file_w, 'Sheet','TrainSelect')
        writetable(TestSelect, file_w, 'Sheet','TestSelect')
    end
%%
    for num_fs = 1:NumSelect
        idx = I_B_stat_cnt(1:num_fs);
        TrainSelect = TrainData(:, [1; idx+1]);
        TestSelect = TestData(:, [1; idx+1]);
file_w=[root_dataSave, '\Loop',num2str(num),'\B_stat_cnt_NumFS',num2str(num_fs),'.xlsx'];
        writetable(TrainSelect, file_w, 'Sheet','TrainSelect')
        writetable(TestSelect, file_w, 'Sheet','TestSelect')
    end
%%
    for num_fs = 1:NumSelect
        idx = I_RE_stat_cnt(1:num_fs);
        TrainSelect = TrainData(:, [1; idx+1]);
        TestSelect = TestData(:, [1; idx+1]);
file_w=[root_dataSave, '\Loop',num2str(num),'\RE_stat_cnt_NumFS',num2str(num_fs),'.xlsx'];
        writetable(TrainSelect, file_w, 'Sheet','TrainSelect')
        writetable(TestSelect, file_w, 'Sheet','TestSelect')
    end

end
