
Paper: Integrating compressed sensing with radiomics for personalized ultra-fractionated stereotactic adaptive radiotherapy (PULSAR)

Authors: Yajun Yu, Haozhao Zhang, Steve Jiang, Robert Timmerman, Hao Peng

Description:

This README file describes the data and codes accompanying the above publication. 

Files:

1. Random_meaturement_matrix folder: Including 10 random binary or Gaussian matrices.

2. Train_test_index folder: Including 50 random train-test split indices.

3. Features_preprocessed_delta.xlsx: 1386 preprocessed delta-radiomic features.

4. Label.xlsx: GTV ratios at follow-up and labels.

Codes:

5. A01_Train_Test_Generation.m: Generating train-test splits.

6. B01_Importance_Generation_CS.m: Generating importance scores for CS method.

7. B01_Importance_Generation_Lasso.m: Generating importance scores for Lasso method.

8. B02_Importance_Sort_CS.m: Sorting importance scores for CS method.

9. B02_Importance_Sort_Lasso.m: Sorting importance scores for Lasso method.

10. B03_Select_Features_CS.m: Determining CS-selected features.

11. B03_Select_Features_Lasso.m: Determining Lasso-selected features.

12. C01_SVM_Construction_Metrics_CS.py: Constructing SVM models and outputting model evalutaion metrics for CS method.

13. C01_SVM_Construction_Metrics_Lasso.py: Constructing SVM models and outputting model evalutaion metrics for Lasso method.
