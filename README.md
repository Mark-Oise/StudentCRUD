# Student CRUD REST API

This repository contains a Django Rest Framework API for managing student records.

## Local Setup Instructions

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/student-api.git
    cd student-api
    ```

2. Create a virtual environment and activate it:
    ```sh
    python -m venv venv
    source venv/bin/activate  # On Windows, use venv\Scripts\activate
    ```

3. Install dependencies:
    ```sh
    pip install -r requirements.txt
    ```

4. Set up environment variables:
    Create a `.env` file in the root directory and add the following:
    ```env
    DATABASE_URL=sqlite:///db.sqlite3
    DEBUG=True
    SECRET_KEY=your_secret_key_here
    ```

5. Run migrations:
    ```sh
    make migrate
    ```

6. Run the server:
    ```sh
    make run
    ```

## API Documentation

For API documentation and testing, please refer to the Postman collection in the `postman` directory.

## Running Tests

To run the unit tests:
    ```sh
    make test
    ```

## Docker Setup

### Building the Docker Image

To build the Docker image, run:
    ```sh
    make docker-build
    ```

### Running the Docker Container

To run the Docker container, use:
    ```sh
    make docker-run
    ```
    This will start the API server on [http://localhost:8000](http://localhost:8000).

### Environment Variables

You can inject environment variables when running the Docker container. For example:
    ```sh
    docker run -p 8000:8000 -e DEBUG=False -e SECRET_KEY=your_secret_key student-api:1.0.0
    ```

## Available Make Commands

- `make run`: Run the development server
- `make migrate`: Run database migrations
- `make test`: Run unit tests
- `make docker-build`: Build the Docker image
- `make docker-run`: Run the Docker container

## Vagrant Deployment

1. Install Vagrant and VirtualBox on your local machine.
2. Clone this repository.
3. Navigate to the project directory.
4. Run `vagrant up` to create and provision the Vagrant box.
5. SSH into the Vagrant box with `vagrant ssh`.
6. Navigate to the app directory: `cd /home/vagrant/app`.
7. Deploy the services: `make deploy`.
8. Access the API at `http://localhost:8080`.

To stop the services, run `make docker-compose down` inside the Vagrant box.