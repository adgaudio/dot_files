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

COPY jupyter_nbconfig /home/jovyan/.jupyter/nbconfig
USER root
RUN chown -R jovyan:users /home/jovyan/.jupyter

RUN apt-get update && apt-get install -y less
RUN apt-get install -y libgtk2.0-dev && conda install -y opencv
USER jovyan

