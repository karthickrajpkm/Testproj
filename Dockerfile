# start from an official image
FROM python:3.7.1

RUN mkdir -p /opt/services/djangoapp/src
WORKDIR /opt/services/djangoapp/src

COPY Pipfile Pipfile.lock /opt/services/djangoapp/src/
RUN pip install pipenv && pipenv install --system

COPY . /opt/services/djangoapp/src
RUN cd hello && python manage.py collectstatic --no-input  # <-- here

EXPOSE 8000
CMD ["gunicorn", "--chdir", "hello", "--bind", ":8000", "hello.wsgi:application"]
