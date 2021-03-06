% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sits_cluster.R
\name{sits_cluster_frequency}
\alias{sits_cluster_frequency}
\title{Cluster contigency table}
\usage{
sits_cluster_frequency(data.tb)
}
\arguments{
\item{data.tb}{tibble with `cluster` column.}
}
\value{
result.mtx      matrix containing all frequencies of labels in clusters
}
\description{
Computes the contingency table between labels and clusters.
This function needs as input a SITS tibble with `cluster` column.
}
\examples{
\donttest{
# Load the "dtwclust" package
library(dtwclust)
# load a simple data set with two classes
data(cerrado_2classes)
# calculate the dendrogram
dendro <- sits_dendrogram (cerrado_2classes, bands = c("ndvi"))
# include the cluster info in the SITS tibble
# create 6 clusters by cutting the dendrogram
clusters.tb <- sits_cluster(cerrado_2classes, dendro, k = 6)
# show clusters samples frequency
sits_cluster_frequency(clusters.tb)
}
}
\author{
Rolf Simoes, \email{rolf.simoes@inpe.br}
}
