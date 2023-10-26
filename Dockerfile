# Stage 1: Build the V application
FROM thevlang/vlang:alpine-dev AS builder

WORKDIR /app

# Copy necessary files
COPY . .

# Build the V application
RUN v -prod -o /app/myapp .

# Stage 2: Create a lightweight image for the V application
FROM alpine:3.18.4

RUN apk --no-cache add ca-certificates libc6-compat libatomic

WORKDIR /app

# Copy the executable from the previous stage
COPY --from=builder /app/myapp /app/myapp

# Copy the assets folder
COPY --from=builder /app/assets /app/assets

# Run the V application
CMD ["/app/myapp"]
