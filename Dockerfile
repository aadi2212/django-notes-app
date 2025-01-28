# Use the official Python image from the Docker Hub
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app/backend

# Copy the requirements file into the container
COPY requirements.txt /app/backend/

# Install system dependencies and clean up the apt cache
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . /app/backend/

# Expose port 8000 for the Django app
EXPOSE 8000

# Run Django migrations (Uncomment these if necessary)
RUN python manage.py makemigrations
RUN python manage.py migrate

# Set the default command to run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
