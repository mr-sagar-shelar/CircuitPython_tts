# ubunutu is the base image

FROM amd64/ubuntu:latest
LABEL maintainer="Sagar Shelar shaggy.shelar@gmail.com"


# this is for timezone config
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
#-y is for accepting yes when the system asked us for installing the package
# RUN apt-get install -y build-essential cmake git openssh-server gdb pkg-config valgrind systemd-coredump
RUN apt-get install -y build-essential cmake git openssh-server git-lfs gettext mtools python3-full python3-pip python3-venv curl gcc

# Clone Circuit Python Repo and fetch submodules
RUN cd &&\
    python3 -mvenv myEnv &&\
    echo $(ls) &&\
    . myEnv/bin/activate &&\
    git clone https://github.com/adafruit/circuitpython.git && \
    cd circuitpython && \ 
    echo $(pwd) && \
    echo $(ls) && \
    pip3 install --upgrade -r requirements-dev.txt && \
    # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && \
    # . $HOME/.cargo/env  && \
    # rustc --version && \
    echo $(pwd) && \
    cd ports/broadcom && \
    echo $(pwd) && \
    make fetch-port-submodules

# Make mpy-cross
RUN cd &&\
    python3 -mvenv myEnv &&\
    echo $(ls) &&\
    . myEnv/bin/activate &&\
    cd circuitpython &&\
    echo "\n\n\n\n\n\n\n\n ************************************** Setting mpy-cross" && \
    echo $(pwd) && \
    echo $(ls) && \
    make -C mpy-cross

# Make raspberry pi zero board
RUN cd &&\
    python3 -mvenv myEnv &&\
    echo $(ls) &&\
    . myEnv/bin/activate &&\
    cd circuitpython/ports/broadcom &&\
    echo "\n\n\n\n\n\n\n\n ************************************** Making RPI Board **************************************" && \
    # echo $(pwd) && \
    # which gcc-aarch64-none-elf-gcc && \
    # echo $(ls -l) && \
    make BOARD=raspberrypi_zero2w

# FileNotFoundError: [Errno 2] No such file or directory: 'aarch64-none-elf-gcc'

# docker build --progress=plain -t tts_circuitpython .