FROM --platform=linux/arm64 python:3 AS build

WORKDIR /app

COPY requirements.txt ./

RUN pip3 install -r requirements.txt

COPY . .

CMD ["pwd"]
CMD ["ls -lrt"]
CMD ["python3", "./go-spider.py"]