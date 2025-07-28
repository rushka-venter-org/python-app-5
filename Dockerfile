FROM python:3.12-alpine

COPY ./requirements.txt .

RUN pip install -r ./requirements.txt

COPY src /app

CMD python /app/app.py