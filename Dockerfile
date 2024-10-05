# ubunutu is the base image

FROM amd64/ubuntu:latest
LABEL maintainer="Sagar Shelar shaggy.shelar@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y build-essential cmake git openssh-server git-lfs gettext mtools python3-full python3-pip python3-venv curl gcc wget xz-utils file parted udev zip
# RUN apt-get install -y wget xz-utils file
# RUN apt-get install -y wget gcc gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu make file

# RUN echo "\n\n ************************************** Uname **************************************" && \
#     uname -m && \
#     wget -nv https://gist.githubusercontent.com/ramsey/11072524/raw/62dace10c306381445a0110538097d5c02227f2d/hello1.c && \
#     aarch64-linux-gnu-gcc hello1.c -o hello-aarch64 && \
#     echo "\n\n ************************************** 111111 **************************************" && \
#     # echo $(ls) && \
#     gcc hello1.c -o hello-x86-64 && \
#     echo "\n\n ************************************** 222222 **************************************" && \
#     # echo $(ls) && \
#     file hello-* && \
#     # cd linux && \
#     # KERNEL=kernel8 && \
#     # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig && \
#     make 124

# Clone Circuit Python Repo and fetch submodules
RUN echo "\n\n\n ************************************** Clone Circuit Python Repo **************************************" && \
    cd &&\
    python3 -mvenv myEnv &&\
    echo $(ls) &&\
    . myEnv/bin/activate &&\
    git clone https://github.com/adafruit/circuitpython.git && \
    cd circuitpython && \ 
    echo $(pwd) && \
    echo $(ls) && \
    pip3 install --upgrade -r requirements-dev.txt && \
    echo $(pwd) && \
    cd ports/broadcom && \
    echo $(pwd) && \
    make fetch-port-submodules

# Make mpy-cross
RUN echo "\n\n\n ************************************** Setting mpy-cross **************************************" && \
    cd &&\
    python3 -mvenv myEnv &&\
    echo $(ls) &&\
    . myEnv/bin/activate &&\
    cd circuitpython &&\
    echo $(pwd) && \
    # echo $(ls) && \
    echo "\n\n\n ************************************** make -C mpy-cross **************************************" && \
    make -C mpy-cross

# Download aarch64-none-elf-gcc
RUN echo "\n\n ************************************** Downloading aarch64-none-elf-gcc **************************************" && \
    uname -m && \
    cd && \
    wget -nv https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-elf.tar.xz && \
    echo $(pwd) && \
    echo $(ls) && \
    # echo $(pwd) && \
    echo "\n\n ************************************** Extracting **************************************" && \
    tar -xf arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-elf.tar.xz && \
    # echo $(pwd) && \
    # echo $(ls) && \
    cd arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-elf && \
    # echo $(pwd) && \
    echo $(ls) && \
    export PATH=/root/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-elf/bin:$PATH && \
    echo "\n\n ************************************** Updated PATH **************************************" && \
    echo $PATH && \
    cd bin && \
    # wget -nv https://gist.githubusercontent.com/ramsey/11072524/raw/62dace10c306381445a0110538097d5c02227f2d/hello1.c && \
    echo "\n\n ************************************** Contents of Bin **************************************" && \
    echo $(pwd)
    # echo $(ls -l)


# # Compile sample C program
# RUN echo "\n\n ************************************** Compiling C program **************************************" && \
#     PATH=/root/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-elf/bin:$PATH && \
#     echo $PATH && \
#     cd && \
#     wget https://gist.githubusercontent.com/ramsey/11072524/raw/62dace10c306381445a0110538097d5c02227f2d/hello1.c && \
#     echo $(pwd) && \
#     echo $(ls) && \
#     cat hello1.c && \
#     aarch64-none-elf-gcc -o hello hello1.c && \
#     # echo $(pwd) && \
#     # echo $(ls) && \
#     file hello && \
#     file hello12444


# Download dosfstools
RUN echo "\n\n\n ************************************** Download dosfstools **************************************" && \
    cd &&\
    wget -nv https://github.com/dosfstools/dosfstools/releases/download/v4.2/dosfstools-4.2.tar.gz && \
    tar -xf dosfstools-4.2.tar.gz && \
    cd dosfstools-4.2 && \
    ./configure && \
    echo "\n\n\n ************************************** Making DOSFSTools **************************************" && \
    make && \
    echo "\n\n\n ************************************** Contents of DOSFSTools **************************************" && \
    echo $(pwd) && \
    echo "\n\n\n ************************************** Installing DOSFSTools **************************************" && \
    make install && \
    echo $(ls)


# Make raspberry pi zero board
RUN echo "\n\n\n ************************************** Setting Python Env **************************************" && \
    cd &&\
    python3 -mvenv myEnv &&\
    . myEnv/bin/activate &&\
    cd circuitpython/ports/broadcom &&\
    echo "\n\n\n ************************************** Making RPI Board **************************************" && \
    export PATH=/root/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-elf/bin:$PATH && \
    echo $PATH && \
    # echo $(pwd) && \
    # echo $(ls -l) && \
    make BOARD=raspberrypi_zero2w && \
    echo $(pwd) && \
    echo $(ls)
    cd build-raspberrypi_zero2w && \
    echo $(ls)

# FileNotFoundError: [Errno 2] No such file or directory: 'aarch64-none-elf-gcc'

# docker build --progress=plain -t tts_circuitpython .
# gcc -dumpmachine
# "uname -m" 

#on Mac download it from https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
# from section macOS (Apple silicon) hosted cross toolchains
# Direct URL: https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-darwin-arm64-aarch64-none-elf.tar.xz
# Once downloaded execute: tar -xf arm-gnu-toolchain-13.3.rel1-darwin-arm64-aarch64-none-elf.tar.xz 
# Add global path variable: "sudo nano /etc/paths" and add the path

# Once docker image is ready then run it using
# docker run -it tts_circuitpython