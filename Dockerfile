# Use the official Python image for the base image.
FROM --platform=linux/amd64 python:3.11-slim

# Set environment variables to make Python print directly to the terminal and avoid .pyc files.
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install system dependencies required for the project.
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    git \
    wget \
    unzip \
    libvips-dev \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*


# Install uv
RUN python3 -m pip install --no-cache-dir uv

# Set the working directory. IMPORTANT: can't be changed as needs to be in sync to the dir where the project is cloned
# to in the codespace
WORKDIR /workspaces/tianshou

# Copy the pyproject.toml and uv.lock files (if available) into the image.
COPY pyproject.toml uv.lock README.md /workspaces/tianshou/

RUN uv sync --no-dev --dev

# The entrypoint will perform an editable install, it is expected that the code is mounted in the container then
# If you don't want to mount the code, you should override the entrypoint
ENTRYPOINT ["/bin/bash", "-c", "uv sync --dev && uv run jupyter trust notebooks/*.ipynb docs/02_notebooks/*.ipynb && $0 $@"]