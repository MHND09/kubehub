# Start from Kubeflow's official Jupyter base image
FROM ghcr.io/kubeflow/kubeflow/notebook-servers/jupyter:latest

# Switch to root to install packages
USER root

# Install JupyterHub and dependencies
USER root
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest
RUN pip install jupyterhub

# Switch back to jovyan (required by Kubeflow)
USER jovyan

# Expose the correct port
EXPOSE 8888

# Run the single-user server instead of full JupyterHub
CMD ["jupyterhub-singleuser", "--ip=0.0.0.0", "--port=8888"]
