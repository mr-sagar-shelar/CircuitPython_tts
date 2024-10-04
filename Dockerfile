# ubunutu is the base image

FROM amd64/ubuntu:latest
LABEL maintainer="Sagar Shelar shaggy.shelar@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
# RUN apt-get install -y build-essential cmake git openssh-server git-lfs gettext mtools python3-full python3-pip python3-venv curl gcc wget
# RUN apt-get install -y wget xz-utils bc bison flex libssl-dev make libc6-dev libncurses5-dev crossbuild-essential-arm64
RUN apt-get install -y wget gcc gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu make file

RUN echo "\n\n ************************************** Uname **************************************" && \
    uname -a && \
    wget -nv https://gist.githubusercontent.com/ramsey/11072524/raw/62dace10c306381445a0110538097d5c02227f2d/hello1.c && \
    aarch64-linux-gnu-gcc hello1.c -o hello-aarch64 && \
    echo "\n\n ************************************** 111111 **************************************" && \
    # echo $(ls) && \
    gcc hello1.c -o hello-x86-64 && \
    echo "\n\n ************************************** 222222 **************************************" && \
    # echo $(ls) && \
    file hello-* && \
    # cd linux && \
    # KERNEL=kernel8 && \
    # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig && \
    make 124

# Clone Circuit Python Repo and fetch submodules
# RUN cd &&\
#     python3 -mvenv myEnv &&\
#     echo $(ls) &&\
#     . myEnv/bin/activate &&\
    # git clone https://github.com/adafruit/circuitpython.git && \
    # cd circuitpython && \ 
    # echo $(pwd) && \
    # echo $(ls) && \
    # pip3 install --upgrade -r requirements-dev.txt && \
    # echo $(pwd) && \
    # cd ports/broadcom && \
    # echo $(pwd) && \
    # make fetch-port-submodules

# Make mpy-cross
# RUN cd &&\
#     python3 -mvenv myEnv &&\
#     echo $(ls) &&\
#     . myEnv/bin/activate &&\
#     cd circuitpython &&\
#     echo "\n\n\n\n\n\n\n\n ************************************** Setting mpy-cross **************************************" && \
#     echo $(pwd) && \
#     echo $(ls) && \
#     make -C mpy-cross

# Download aarch64-none-elf-gcc
RUN echo "\n\n ************************************** Downloading aarch64-none-elf-gcc **************************************" && \
    cd && \
    wget -nv https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-aarch64-aarch64-none-elf.tar.xz &&\
    echo $(pwd) && \
    echo $(ls) && \
    # echo $(pwd) && \
    echo "\n\n ************************************** Extracting **************************************" && \
    tar -xf gcc-arm-10.3-2021.07-aarch64-aarch64-none-elf.tar.xz && \
    # echo $(pwd) && \
    # echo $(ls) && \
    cd gcc-arm-10.3-2021.07-aarch64-aarch64-none-elf && \
    # echo $(pwd) && \
    echo $(ls) && \
    PATH=/root/gcc-arm-10.3-2021.07-aarch64-aarch64-none-elf/bin:$PATH && \
    echo "\n\n ************************************** Updated PATH **************************************" && \
    echo $PATH && \
    cd bin && \
    wget -nv https://gist.githubusercontent.com/ramsey/11072524/raw/62dace10c306381445a0110538097d5c02227f2d/hello1.c && \
    echo "\n\n ************************************** Contents of Bin **************************************" && \
    echo $(pwd) && \
    echo $(ls) && \
    aarch64-none-elf-gcc -o hello hello1.c


# Compile sample C program
RUN echo "\n\n ************************************** Compiling C program **************************************" && \
    PATH=/root/gcc-arm-10.3-2021.07-aarch64-aarch64-none-elf/bin:$PATH && \
    echo $PATH && \
    cd && \
    wget https://gist.githubusercontent.com/ramsey/11072524/raw/62dace10c306381445a0110538097d5c02227f2d/hello1.c && \
    echo $(pwd) && \
    echo $(ls) && \
    cat hello1.c && \
    aarch64-none-elf-gcc -o hello hello1.c && \
    # echo $(pwd) && \
    # echo $(ls) && \
    file hello && \
    file hello12444


# Make raspberry pi zero board
# RUN cd &&\
#     # python3 -mvenv myEnv &&\
#     # echo $(ls) &&\
#     # . myEnv/bin/activate &&\
#     # cd circuitpython/ports/broadcom &&\
#     echo "\n\n\n\n\n\n\n\n ************************************** Making RPI Board **************************************" && \
#     # echo $(pwd) && \
#     which gcc-aarch64-none-elf-gcc && \
#     # echo $(ls -l) && \
#     make BOARD=raspberrypi_zero2w

# FileNotFoundError: [Errno 2] No such file or directory: 'aarch64-none-elf-gcc'

# docker build --progress=plain -t tts_circuitpython .
# gcc -dumpmachine
# "uname -m" 