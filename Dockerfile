# Use the official Nginx base image
FROM nginx:alpine

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove the default Nginx welcome page
RUN rm -rf ./*

# Copy your custom HTML page to the container's working directory
COPY index.html .

# Expose port 80 to serve the application
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]

