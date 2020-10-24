FROM alpine:3.11

RUN apk update

# Install the basics
RUN apk add \
  bash \
  make \
  curl \
  zip \
  python3 \
  python3-dev

RUN ln -sf python3 /usr/bin/python \
  && ln -sf pip3 /usr/bin/pip

# Upgrade pip
RUN pip install --upgrade pip

# Install required python modules
COPY requirements.txt .
RUN pip install -r requirements.txt

# Create a working directory for coding
RUN mkdir /code

# Create user w/ permissions
RUN addgroup -S developers && adduser -S dev -G developers
RUN chown dev:developers /code && chmod 775 /code
USER dev
