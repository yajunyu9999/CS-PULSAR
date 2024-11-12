import numpy as np
import pandas as pd
from sklearn import svm
from sklearn.model_selection import GridSearchCV, RepeatedKFold, RepeatedStratifiedKFold
import os
import fnmatch
from scipy.io import loadmat

for M in [56]:
    for NS in [5]:

        for idx_norm in range(1, 11):

            accuracy_average = []
            accuracy_std = []
            NumOfFs = []
            arr_C = []
            arr_gamma = []

            rootpath = (r'...\FSelected_pytorch_delta_all_M'+str(M)+'_NS'+str(NS)+'\mat_norm'+str(idx_norm))

            for LoopNum in range(1, 51):

                directory = (rootpath + '\Loop'+str(LoopNum))

                output = np.zeros(NS)
                DecisionScore = np.zeros((NS, 15))
                TestLabel = np.zeros((NS, 15))
                PredictProb = np.zeros((NS, 15))
                PredictLabel = np.zeros((NS, 15))
                CoefWeight = np.zeros((1, NS))

                for sort_name in ['B_stat_abs', 'B_stat_cnt', 'RE_stat_cnt']:
                    cnt = 0
                    for NumFS in range(1, NS+1):


                        filepath_X_y = (directory + '\\'+sort_name+'_NumFS' + str(NumFS)+'.xlsx')
                        X_y_train = pd.read_excel(filepath_X_y, sheet_name='TrainSelect')
                        X_y_test = pd.read_excel(filepath_X_y, sheet_name='TestSelect')

                        label_train = X_y_train[X_y_train.columns[0]]
                        fs_train = X_y_train[X_y_train.columns[1:]]
                        label_test = X_y_test[X_y_test.columns[0]]
                        fs_test = X_y_test[X_y_test.columns[1:]]


                        # params
                        Cs = np.logspace(0, 10, 11, base=2)
                        # gammas = np.logspace(-40, 0, 21, base=2)
                        param_grid = dict(C=Cs)
                        grid = GridSearchCV(svm.SVC(kernel='linear'), param_grid=param_grid, cv=5).fit(fs_train, label_train)
                        print(grid.best_params_)
                        C = grid.best_params_['C']
                        # gamma = grid.best_params_['gamma']

                        cnt = cnt + 1

                        # model_svm_rkf = svm.SVC(kernel='rbf', C=C_rkf, gamma=gamma_rkf).fit(fs_train, label_train)
                        model_svm_rkf = svm.SVC(kernel='linear', C=C).fit(fs_train, label_train)
                        score_svm = model_svm_rkf.score(fs_test, label_test)
                        y_score = model_svm_rkf.decision_function(fs_test)
                        y_predict = model_svm_rkf.predict_proba(fs_test)[:, 1]
                        y_label = model_svm_rkf.predict(fs_test)
                        Coef = model_svm_rkf.coef_
                        # print(score_svm)
                        output[cnt - 1] = score_svm

                        DecisionScore[cnt - 1, 0:len(y_score)] = y_score
                        TestLabel[cnt - 1, 0:len(y_score)] = label_test
                        PredictProb[cnt - 1, 0:len(y_predict)] = y_predict
                        PredictLabel[cnt - 1, 0:len(y_predict)] = y_label
                        CoefWeight[cnt - 1, 0:len(y_predict)] = Coef

                    np.savetxt(directory + '\Z_DecisionScore_C'+str(C)+'_'+sort_name+'.txt', DecisionScore, fmt='%f')
                    np.savetxt(directory + '\Z_TestLabel_C'+str(C)+'_'+sort_name+'.txt', TestLabel, fmt='%d')
                    np.savetxt(directory + '\Z_PredictProb_C' + str(C) + '_' + sort_name + '.txt', PredictProb, fmt='%f')
                    np.savetxt(directory + '\Z_CoefWeight_C' + str(C) + '_' + sort_name + '.txt', CoefWeight, fmt='%f')

                    df1 = pd.DataFrame(
                        {'Accuracy': output})
                    df1.to_excel(directory + '\output_Linear_'+sort_name+'.xlsx', index=False)
