FROM jupyter/datascience-notebook


RUN conda install -c conda-forge \
  jupyter_nbextensions_configurator \
  jupyter_contrib_nbextensions \
  yapf \
  jupyter_cms \
  jupyter_dashboards

# R packages
RUN conda install -y -c r r r-essentials

RUN conda install ipython-qtconsole

