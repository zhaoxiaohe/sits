devAskNewPage(ask = FALSE)


# This demo shows different machine learning methods for clasification of time series

#load the sits library
library(sits)

#  A dataset containing a tibble with time series samples for the Mato Grosso state in Brasil.
#  The time series come from MOD13Q1 collection 6 images. The data set has the following classes:
#  Cerrado(400 samples), Fallow_Cotton (34 samples), Forest (138 samples), Pasture (370 samples),
#  Soy-Corn (398 samples),  Soy-Cotton (399 samples), Soy_Fallow (88 samples),
#  Soy_Millet (235 samples), and Soy_Sunflower (53 samples).
#  The tibble has 7 variables: (a) longitude: East-west coordinate of the time series sample (WGS 84);
#  latitude (North-south coordinate of the time series sample in WGS 84), start_date (initial date of the time series),
#  end_date (final date of the time series), label (the class label associated to the sample),
#  coverage (the name of the coverage associated with the data),
#  time_series (list containing a tibble with the values of the time series).

data("samples_MT_9classes")
# the tibble contains 9 classes of the Cerrado biome in Brazil
sits_labels(samples_MT_9classes)



# select NDVI, EVI, NIR and MIR
samples.tb <- sits_select(samples_MT_9classes, bands = c("ndvi", "evi", "nir", "mir"))


results <- list()

conf_svm.tb <- sits_kfold_validate(samples.tb, folds = 5, multicores = 2,
                                    ml_method   = sits_svm(kernel = "radial", cost = 10))

print("== Confusion Matrix = SVM =======================")
conf_svm.mx <- sits_conf_matrix(conf_svm.tb)

conf_svm.mx$name <- "svm_10"

results[[length(results) + 1]] <- conf_svm.mx

# Deep Learning

conf_dl.tb <- sits_kfold_validate(samples.tb, folds = 5, multicores = 1,
                                  ml_method   = sits_deeplearning(
                                      units            = c(512, 512, 512, 512),
                                      activation       = 'selu',
                                      dropout_rates    = c(0.4, 0.35, 0.3, 0.2),
                                      optimizer        = keras::optimizer_adam(),
                                      epochs           = 300,
                                      batch_size       = 128,
                                      validation_split = 0.2),
                                      adj_val          = 0)

print("== Confusion Matrix = DL =======================")
conf_dl.mx <- sits_conf_matrix(conf_dl.tb)

conf_dl.mx$name <- "dl"

results[[length(results) + 1]] <- conf_dl.mx

# =============== RFOR ==============================

# test accuracy of TWDTW to measure distances
conf_rfor.tb <- sits_kfold_validate(samples.tb, folds = 5, multicores = 1,
                                    ml_method   = sits_rfor(ntree = 2000))
print("== Confusion Matrix = RFOR =======================")
conf_rfor.mx <- sits_conf_matrix(conf_rfor.tb)
conf_rfor.mx$name <- "rfor"

results[[length(results) + 1]] <- conf_rfor.mx



# =============== LDA ==============================

# test accuracy of TWDTW to measure distances
conf_lda.tb <- sits_kfold_validate(samples.tb, folds = 5, multicores = 1,
                                   ml_method   = sits_lda())

print("== Confusion Matrix = LDA =======================")
conf_lda.mx <- sits_conf_matrix(conf_lda.tb)
conf_lda.mx$name <- "lda"

results[[length(results) + 1]] <- conf_lda.mx

# =============== QDA ==============================

# test accuracy of TWDTW to measure distances
conf_qda.tb <- sits_kfold_validate(samples.tb, folds = 5, multicores = 1,
                                   ml_method   = sits_qda())

print("== Confusion Matrix = QDA =======================")
conf_qda.mx <- sits_conf_matrix(conf_qda.tb)
conf_qda.mx$name <- "qda"

results[[length(results) + 1]] <- conf_qda.mx

# =============== MLR ==============================
# "multinomial log-linear (mlr)
conf_mlr.tb <- sits_kfold_validate(samples.tb, folds = 5, multicores = 1,
                                   ml_method   = sits_mlr())

# print the accuracy of the Multinomial log-linear
print("== Confusion Matrix = MLR =======================")
conf_mlr.mx <- sits_conf_matrix(conf_mlr.tb)
conf_mlr.mx$name <- "mlr"

results[[length(results) + 1]] <- conf_mlr.mx


WD = getwd()

sits_toXLSX(results, file = paste0(WD, "/accuracy_cerrado.xlsx"))


