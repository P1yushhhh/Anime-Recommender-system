FROM python:3.11-slim

##Essential environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive

##Work directory
WORKDIR /app

##Install system dependencies (combine and clean in one layer)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*
    
##Upgrade pip tooling early
RUN python -m pip install --upgrade pip setuptools wheel

Copy only dependency files first to leverage Docker layer caching
##Adjust these lines depending on how dependencies are declared
COPY requirements.txt ./
## Install Python dependencies
RUN pip install -r requirements.txt
##Copy the rest of the source
COPY . .

Expose Streamlit port
EXPOSE 8501

##Run the app
CMD ["streamlit", "run", "app/app.py", "--server.port=8501", "--server.address=0.0.0.0", "--server.headless=true"]