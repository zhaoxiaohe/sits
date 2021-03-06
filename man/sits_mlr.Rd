% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sits_machine_learning.R
\name{sits_mlr}
\alias{sits_mlr}
\title{Train a SITS classifiaction model using multinomial log-linear regions via neural networks}
\usage{
sits_mlr(distances_DT = NULL, formula = sits_formula_linear(),
  n_weights = 20000, maxit = 2000, ...)
}
\arguments{
\item{distances_DT}{set of distance measures for each training sample}

\item{formula}{symbolic description of the model to be fit. SITS offers a set of such formulas (default: sits_formula_logref)}

\item{n_weights}{maximum number of weights (should be proportional to size of input data)}

\item{maxit}{maximum number of iterations (default 300)}

\item{...}{other parameters to be passed to nnet::multinom function}
}
\value{
result          a model function to be passed in sits_predict
}
\description{
Use multinomial log-linear (mlr) fitting model via neural networks to classify data.
These attributes are distance metrics between patterns and observations, obtained by a distance
function in SITS (see \code{\link[sits]{sits_distances}}).
This function is a front-end to the "multinom" method in the "nnet" package.
Please refer to the documentation in that package for more details.
}
\examples{
\donttest{
# Retrieve the set of samples for the Mato Grosso region (provided by EMBRAPA)
data(samples_MT_ndvi)
# get a point with a 16 year time series
data(point_ndvi)
# classify the point
class.tb <- sits_classify (point_ndvi, samples_MT_ndvi, ml_method = sits_mlr())
}
}
\author{
Alexandre Xavier Ywata de Carvalho, \email{alexandre.ywata@ipea.gov.br}

Rolf Simoes, \email{rolf.simoes@inpe.br}

Gilberto Camara, \email{gilberto.camara@inpe.br}
}
