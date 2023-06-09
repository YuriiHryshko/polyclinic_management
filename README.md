# Clinic Management

Clinic Management is a web application built with Ruby on Rails, Tailwind CSS and Postgresql, that allows users to create appointments and browse doctors in a clinic.
You can visit website by thhe following link: https://clinic-management-tool.herokuapp.com/ 

## Features

- User authentication: Register and login as a patient using [devise gem](https://github.com/heartcombo/devise).
- Create appointments: Users can create and view appointments and their status.
- Manage doctors: Users can view and search for doctors by their category, view their profiles, and create appointment.
- Receive recommendation from doctor, after creating an appointment.
- Appointment verification: Doctors are verified based on the number of open appointments they have. Doctors with more than 10 open appointments are marked as unavailable.
- Responsive design: The application is designed to be mobile-friendly and responsive on different devices.

## Prerequisites

Before running the application, ensure that you have the following installed:

- Ruby (v3.0.0)
- Ruby on Rails (v7.0.4)
- PostgreSQL (v13 or higher)

## Getting Started

1. Clone the repository:

```shell
git clone https://github.com/IrynaBk/clinic-management.git
```

2. Install dependencies:

```shell
cd clinic-management
bundle install
```

3. Set up the database:

```shell
rails db:create
rails db:migrate
```

4. Set up tailwind css:

```shell
rails tailwindcss:install
```

5. Start the server:

```shell
bin/dev
```

or if there are some problems with command above:

```shell
 bundle exec foreman start -f Procfile.dev 
```

6. Visit `http://localhost:3000` in your web browser.

## Configuration

- Database configuration: Modify the `config/database.yml` file to set up the database connection.


## Acknowledgements

This project is built using the following technologies and libraries:

- Ruby (https://www.ruby-lang.org/)
- Ruby on Rails (https://rubyonrails.org/)
- PostgreSQL (https://www.postgresql.org/)

