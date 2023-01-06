# Remove possible existing container
docker rm min-battles

# Build all as one set of chained commands
docker build -t min-battles . && \
docker run --name min-battles min-battles && \
docker cp min-battles:/output/. ./output
