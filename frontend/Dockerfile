FROM node:20.2.0-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install
RUN npm install typescript -g

# Copy the application code to the container
COPY . .
RUN /usr/local/bin/tsc

FROM node:20.2.0-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=build /app/build /app
CMD ["index.js"]