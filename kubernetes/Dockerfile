
FROM golang:1.16-alpine

WORKDIR /app

#COPY go.mod ./
#COPY go.sum ./
#RUN go mod download

COPY main.go .

RUN go build main.go
RUN ls

EXPOSE 8080

CMD [ "./main" ]
