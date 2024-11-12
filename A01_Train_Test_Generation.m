clear all

root_dataRead = '';
root_dataSave = '';

T1 = readtable([root_dataRead,'\Features_preprocessed_delta.xlsx']);
T1_arr = table2array(T1);
fs_names = T1.Properties.VariableNames;

for num = 1:50
    aa=load([root_dataRead,'\train_test_index\train_test_idx_',num2str(num),'.mat']);
    train_idx = aa.train_idx;
    test_idx = aa.test_idx;
    train_fs = T1_arr(train_idx,2:end);
    train_label = T1_arr(train_idx,1);
    test_fs = T1_arr(test_idx,2:end);
    test_label = T1_arr(test_idx,1);

    train_data = array2table([train_label, train_fs], "VariableNames",fs_names);
    test_data = array2table([test_label, test_fs], "VariableNames",fs_names);

file_w=[root_dataSave, '\Data_Loop',num2str(num),'.xlsx'];
writetable(train_data, file_w, 'Sheet','TrainData')
writetable(test_data, file_w, 'Sheet','TestData')

end
