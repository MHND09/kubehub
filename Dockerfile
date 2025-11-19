# Use Kubeflow's Jupyter base image (already configured to run as jovyan, etc.)
FROM ghcr.io/kubeflow/kubeflow/notebook-servers/jupyter:latest

USER root

# Install extra system packages if needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    scikit-learn

# Expose port 8888 (required by Kubeflow)
EXPOSE 8888

# Switch back to the jovyan user
USER ${NB_UID}

# Use the default notebook start script (or jupyter lab)
CMD ["start.sh", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888"]