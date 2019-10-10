FROM alpine
RUN apk add --no-cache ca-certificates && update-ca-certificates
ADD https://get.aquasec.com/microscanner .
RUN chmod +x microscanner
EXPOSE 8080
RUN ./microscanner ODg0MjExYmNlYzEx
