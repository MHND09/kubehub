FROM jupyter/base-notebook:latest

USER root

# Install JupyterHub and JupyterLab
RUN pip install --no-cache-dir jupyterhub jupyterlab

EXPOSE 8888

USER ${NB_UID}

# Start JupyterHub on port 8888, listen on all interfaces
CMD ["jupyterhub", "--ip=0.0.0.0", "--port=8888"]
