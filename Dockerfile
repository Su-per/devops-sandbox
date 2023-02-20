# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim

EXPOSE 8000

# Install pip requirements
COPY . .
RUN python3 -m pip install -r requirements.txt

CMD ["uvicorn", "main:app", "--port", "8000", "--host", "0.0.0.0"]