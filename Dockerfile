FROM python:3.8-slim

RUN groupadd -r -g 1000 dev \
  && useradd --no-log-init -r -g dev -u 1000 dev

RUN python -m venv /venv \
  && . /venv/bin/activate \
  && pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir pytest==6.1.1 pytest-factoryboy \
  && chown -R dev:dev /venv

ENV PATH /venv/bin:$PATH

COPY --chown=dev:dev . /app/
WORKDIR /app

USER dev

CMD ["pytest"]
