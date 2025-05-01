# Taskeny

## Description
Taskeny is a task management application built with Ruby on Rails 8, designed to help users organize and track their projects and tasks efficiently.

## Tech Stack
- Ruby on Rails 8
- PostgreSQL
- Tailwind CSS 4
- Stimulus JS
- Turbo

## Prerequisites
- Ruby 3.2+
- PostgreSQL 14+
- Node.js 18+
- Yarn 1.22+

## Installation

### Clone the repository
```bash
git clone https://github.com/juanvisbal/taskeny.git
cd taskeny
```

### Setup the application
```bash
# Install Ruby dependencies
bundle install

# Install JavaScript dependencies
yarn install

# Setup the database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed # Optional, if you want sample data
```

## Running the application

### Development server
```bash
# Start the Rails server
bin/rails server

# In a separate terminal, start the asset compilation
bin/rails tailwindcss:watch
```

Visit `http://localhost:3000` in your browser to access the application.

## Features
- Task creation and tracking
- Real-time updates with Turbo
- Responsive design with Tailwind CSS
- Interactive elements powered by Stimulus
- User dark mode

## Development

### Todos

[] System dark mode
[] User accounts
[] iOS/Android apps


## License
[MIT](https://choosealicense.com/licenses/mit/)

## Contact
Juan Visbal - [me@juanvisbal.com](mailto:me@juanvisbal.com)

Project Link: [https://github.com/juanvisbal/taskeny](https://github.com/juanvisbal/taskeny)
