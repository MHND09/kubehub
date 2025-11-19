# Start from Kubeflow's official Jupyter base image
FROM ghcr.io/kubeflow/kubeflow/notebook-servers/jupyter:latest

# Switch to root to install packages
USER root

# Install JupyterHub and dependencies
RUN apt-get update && apt-get install -y npm nodejs \
    && pip install jupyterhub

# Switch back to jovyan (required by Kubeflow)
USER jovyan

# Expose the correct port
EXPOSE 8888

# Run the single-user server instead of full JupyterHub
CMD ["jupyterhub-singleuser", "--ip=0.0.0.0", "--port=8888"]
