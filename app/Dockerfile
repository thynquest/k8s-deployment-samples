FROM golang:1.17-alpine AS build


#RUN apk --no-cache add git 
WORKDIR /target-folder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
COPY --from=build /target-folder/app /app
EXPOSE 8080 8086 9101
ENTRYPOINT ["/app"]
