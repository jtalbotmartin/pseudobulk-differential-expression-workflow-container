FROM rocker/tidyverse:4.2.3

## install linux libraries
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
apt-utils \
libglpk-dev \
libhdf5-dev \
libcairo2-dev \
libxt-dev \
patch \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

## install R packages from CRAN 
RUN install2.r -e argparse || echo "argparse installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e hdf5r || echo "hdf5r installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e Matrix || echo "Matrix installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e dplyr || echo "dplyr installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e purrr || echo "purrr installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e cli || echo "cli installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e matrixStats || echo "matrixStats installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e qs || echo "qs installation failed!" && rm -rf /tmp/downloaded_packages
RUN install2.r -e devtools || echo "devtools installation failed!" && rm -rf /tmp/downloaded_packages

## install R packages from bioconductor
COPY requirements-bioc.R .
RUN Rscript -e 'requireNamespace("BiocManager"); BiocManager::install(ask=F);' \
&& Rscript requirements-bioc.R \
&& rm -rf /tmp/downloaded_packages