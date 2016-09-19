FROM ubuntu:14.04
# for ubuntu:12.04
#FROM dliu/ubuntu-gcc-valgrind

#RUN \
	#apt-get install -y python-software-properties && \
	#add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"

RUN \
	apt-get update && \
	apt-get install -y openssl && \
	apt-get install -y libssl-dev && \
#	apt-get install -y GCC && \
  apt-get install -y build-essential && \
	apt-get install -y libpopt-dev && \
	apt-get install -y git && \
	apt-get install -y cmake

RUN \
	apt-get --no-install-recommends install -y texlive-latex-extra && \
	apt-get --no-install-recommends install -y xmlto && \
	apt-get --no-install-recommends install -y g++ && \
	apt-get --no-install-recommends install -y libboost-dev && \
	apt-get --no-install-recommends install -y libboost-all-dev  && \
	apt-get --no-install-recommends install -y libboost-program-options-dev

RUN \
	apt-get --no-install-recommends install -y liblog4cplus-dev && \
	apt-get --no-install-recommends install -y check && \
	apt-get --no-install-recommends install -y wget && \
	apt-get --no-install-recommends install -y rpm

RUN \
	rm -rf avro-cpp-1.7.5 && \
	wget https://archive.apache.org/dist/avro/avro-1.7.5/cpp/avro-cpp-1.7.5.tar.gz && \
	tar -zxvf avro-cpp-1.7.5.tar.gz && \
	cd avro-cpp-1.7.5 && \
	mkdir -p build && cd build && \
	cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo && \
	make && make test && make install && \
	cd / && rm -rf avro-cpp-1.7.5 avro-cpp-1.7.5.tar.gz

RUN \
	rm -rf rabbitmq-c && \
	git clone https://github.com/alanxz/rabbitmq-c.git && \
	cd rabbitmq-c && \
	git checkout -b v0.8.0 && \
	mkdir -p build && \
	cd build && cmake .. && \
	cmake --build . && \
	cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
	make && make install && \
	cd / && rm -rf rabbitmq-c

# install dockerize
ENV DOCKERIZE_VERSION v0.2.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

