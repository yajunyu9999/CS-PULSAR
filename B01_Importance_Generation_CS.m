clear all

root_dataRead1 = '';
root_dataRead2 = '';
root_dataSave = '';

for idx_norm = 1:10
file_rand =[root_dataRead1, '\MeasurementMatrix\Mtx',num2str(idx_norm),'.mat'];
aa = load(file_rand);

mat_norm0=aa.int; % Binary matrix
% mat_norm0=aa.mat_norm; % Gaussian matrix

for num = 1:50
sheetname = [root_dataRead2, '\Data_Loop',num2str(num),'.xlsx'];
    TrainData = readtable(sheetname, 'Sheet','TrainData');
    TestData = readtable(sheetname, 'Sheet','TestData');

    train_arr = table2array(TrainData);

    train_label = train_arr(:,1);
    train_fs = train_arr(:,2:end);

    [s11,s22] = size(train_fs);
    mat_norm = mat_norm0(:,1:s11);

    train_fs_new = mat_norm*train_fs;
    train_label_new = mat_norm*train_label;


[B1, FitInfo] = lasso(train_fs_new,train_label_new,'MaxIter',1e8,'Options',statset('UseParallel',true),'Alpha',1,'NumLambda',100,'LambdaRatio',1e-2);

RE = zeros(size(B1));
[row, col] = find(B1~=0);

for kk = 1:size(col,1)
    idx1 = row(kk);
    idx2 = col(kk);
    xx = B1(idx1, idx2);
    Fi = train_fs(:,idx1);

    res = norm((train_label-Fi*xx), 2);
    RE(idx1, idx2) = res;
end

save([root_dataSave,'\mat_norm',num2str(idx_norm),'\Img_FS_Lasso_all_delta_Loop',num2str(num),'.mat'],"B1","FitInfo","RE")

end
end

