FROM debian

ARG REGION=ap
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y \
    wget unzip vim curl python3 sudo git

# Mengunduh dan menginstal code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Membuat pengguna baru dan menyiapkan lingkungan
RUN useradd -m coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /home/coder/project

USER coder
WORKDIR /home/coder/project

# Menjalankan code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "."]

EXPOSE 8080
