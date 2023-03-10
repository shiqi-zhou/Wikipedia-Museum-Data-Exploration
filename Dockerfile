FROM continuumio/miniconda3:4.10.3p1

WORKDIR /src

# Install ODBC driver and dependencies
RUN apt-get update && apt-get install -y \
    unixodbc-dev \
    gnupg \
    unixodbc \
    odbcinst \
    libodbc1 \
 && rm -rf /var/lib/apt/lists/*

# Download and install the ODBC driver for SQL Server
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN wget -qO- https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Add the ODBC driver to the ODBC configuration file
RUN echo "[ODBC Driver 17 for SQL Server]\nDescription=Microsoft ODBC Driver 17 for SQL Server\nDriver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.8.so.1.1\nUsageCount=1" >> /etc/odbcinst.ini

RUN pip3 install jupyterlab \
    unidecode \
    pyodbc \
    sqlalchemy \
    sqlalchemy-utils

COPY . /src

RUN pip3 install -r requirements.txt

CMD ["jupyter-lab","--ip=0.0.0.0","--no-browser","--allow-root"]
### conda ###

### image:3 ### 

# FROM python:3.9.1
# # FROM python:3.7-slim
# # FROM python:3.6-stretch

# # install build utilities
# RUN apt update \
#     && apt install -y python3-dev unixodbc-dev \
#     && rm -rf /var/lib/apt/lists/*

# # check our python environment
# RUN python3 --version
# RUN pip3 --version

# RUN pip install --upgrade pip \
#     && pip install unidecode \
#     && pip install sqlalchemy

# # install python dependencies
# COPY requirements.txt .
# RUN pip3 install -r requirements.txt

# COPY . src/
# RUN cd src/ \
#     && ls -la /src/*

# # running Python Application
# CMD ["python3", "src/museum_assignment.py"]

### image:3 ### 