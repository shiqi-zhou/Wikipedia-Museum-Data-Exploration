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