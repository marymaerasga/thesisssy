FROM python:3.10 AS thesisssy-poetry
RUN apt update && apt install -y curl
RUN curl -sSL https://install.python-poetry.org | python3 -


FROM thesisssy-poetry AS thesisssy-final
WORKDIR /thesisssy
COPY pyproject.toml .
COPY poetry.lock .
RUN ~/.local/share/pypoetry/venv/bin/poetry config virtualenvs.create false
RUN ~/.local/share/pypoetry/venv/bin/poetry install --only main
COPY . .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--proxy-headers"]