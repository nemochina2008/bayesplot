% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mcmc-traces.R
\name{MCMC-traces}
\alias{MCMC-traces}
\alias{mcmc_trace}
\alias{mcmc_trace_highlight}
\title{Traceplot (time series plot) of MCMC draws}
\usage{
mcmc_trace(x, pars = character(), regex_pars = character(),
  transformations = list(), facet_args = list(), ..., n_warmup = 0,
  window = NULL, size = NULL)

mcmc_trace_highlight(x, pars = character(), regex_pars = character(),
  transformations = list(), facet_args = list(), ..., n_warmup = 0,
  window = NULL, size = NULL, alpha = 0.2, highlight = 1)
}
\arguments{
\item{x}{A 3-D array, matrix, list of matrices, or data frame of MCMC draws.
The \link{MCMC-overview} page provides details on how to specify each these
allowed inputs.}

\item{pars}{An optional character vector of parameter names. If neither
\code{pars} nor \code{regex_pars} is specified then the default is to use
\emph{all} parameters.}

\item{regex_pars}{An optional \link[=grep]{regular expression} to use for
parameter selection. Can be specified instead of \code{pars} or in addition
to \code{pars}.}

\item{transformations}{An optional named list specifying transformations to
apply to parameters. The name of each list element should be a parameter
name and the content of each list element should be a function (or any item
to match as a function via \code{\link{match.fun}}, e.g. a string naming a
function). If a function in the list of transformations is specified by its
name as a string (e.g. \code{"log"}), then it can be used to construct a
new parameter label for the appropriate parameter (e.g.
\code{"log(sigma)"}). If a function itself is specified (e.g. \code{log} or
\code{function(x) log(x)}) then \code{"t"} is used in the new parameter
label to indicate that the parameter is transformed (e.g.
\code{"t(sigma)"}).}

\item{facet_args}{Arguments (other than \code{facets}) passed to
\code{\link[ggplot2]{facet_wrap}} to control faceting.}

\item{...}{Currently ignored.}

\item{n_warmup}{An integer; the number of warmup iterations included in
\code{x}. The default is \code{n_warmup = 0}, i.e. to assume no warmup
iterations are included. If \code{n_warmup > 0} then the background for
iterations \code{1:n_warmup} is shaded gray.}

\item{window}{An integer vector of length two specifying the limits of a
range of iterations to display.}

\item{size}{An optional value to override the default line size (if calling
\code{mcmc_trace}) or the default point size (if calling
\code{mcmc_trace_highlight}).}

\item{alpha}{For \code{mcmc_trace_highlight}, passed to
\code{\link[ggplot2]{geom_point}} to control the transparency of the points
for the chains not highlighted.}

\item{highlight}{For \code{mcmc_trace_highlight}, an integer specifying one
of the chains that will be more visible than the others in the plot.}
}
\value{
A ggplot object that can be further customized using the
  \pkg{ggplot2} package.
}
\description{
Traceplot of MCMC draws. See the \strong{Plot Descriptions} section, below,
for details.
}
\section{Plot Descriptions}{

\describe{
  \item{\code{mcmc_trace}}{
   Standard traceplots of MCMC draws.
  }
  \item{\code{mcmc_trace_highlight}}{
   Traces are plotted using points rather than lines and the opacity of all
   chains but one (specified by the \code{highlight} argument) is reduced.
  }
}
}
\examples{
# some parameter draws to use for demonstration
x <- example_mcmc_draws(chains = 4, params = 6)
dim(x)
dimnames(x)

# traceplots of the betas
color_scheme_set("brightblue")
mcmc_trace(x, regex_pars = "beta")

# can use a mixed color scheme to better differentiate the chains
color_scheme_set("mix-blue-red")
mcmc_trace(x, regex_pars = "beta")

# use traditional ggplot discrete color scale
mcmc_trace(x, pars = c("alpha", "sigma")) +
 ggplot2::scale_color_discrete()

# zoom in on a window of iterations, increase line size,
# add tick marks, and move legend to the top
mcmc_trace(x, window = c(100, 130), size = 1) + legend_move("top")

\dontrun{
# parse facet label text
color_scheme_set("purple")
p <- mcmc_trace(
  x,
  regex_pars = "beta\\\\[[1,3]\\\\]",
  facet_args = list(labeller = ggplot2::label_parsed)
)
p + facet_text(size = 15)

# mark first 100 draws as warmup
mcmc_trace(x, n_warmup = 100)


# plot as points, highlighting chain 2
color_scheme_set("brightblue")
mcmc_trace_highlight(x, pars = "sigma", highlight = 2, size = 2)
}

}
\seealso{
Other MCMC: \code{\link{MCMC-combos}},
  \code{\link{MCMC-diagnostics}},
  \code{\link{MCMC-distributions}},
  \code{\link{MCMC-intervals}}, \code{\link{MCMC-nuts}},
  \code{\link{MCMC-overview}},
  \code{\link{MCMC-scatterplots}}
}

