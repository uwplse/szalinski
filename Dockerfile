FROM rust:1.40-slim-buster

WORKDIR /usr/src/sz

RUN apt-get update && apt-get install -y \
  make g++ jq                            \
  openscad libcgal-dev                   \
  python3 python3-matplotlib python3-numpy

CMD ["make", "case-studies"]