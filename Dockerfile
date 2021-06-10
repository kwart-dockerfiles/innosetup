FROM ubuntu:20.04

ENV WINEDEBUG=-all,err+all \
    DISPLAY=:99

COPY bin/* /usr/bin/

RUN apt-get update \
    && apt-get install -y git curl wget unzip procps xvfb openjdk-8-jdk-headless osslsigncode \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -o APT::Immediate-Configure=false wine wine32 \
    && echo "Downloading Windows JREs" \
    && set -e \
    && wget -q -O /tmp/jre64.zip "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.8%2B10/OpenJDK11U-jre_x64_windows_hotspot_11.0.8_10.zip" \
    && unzip -d /opt /tmp/jre64.zip \
    && mv /opt/jdk* /opt/jre64 \
    && rm /tmp/jre64.zip \
    && set +e \
    && echo "Installing Launch4j" \
    && curl -s -SL https://sourceforge.net/projects/launch4j/files/launch4j-3/3.14/launch4j-3.14-linux-x64.tgz | tar xzf - -C /opt \
    && echo alias launch4j=/opt/launch4j/launch4j >> /root/.bashrc \
    && echo "Installing Apache Ant" \
    && curl -s -SL https://downloads.apache.org/ant/binaries/apache-ant-1.10.9-bin.tar.gz | tar xzf - -C /opt \
    && mv /opt/apache-ant* /opt/ant \
    && ln -s /opt/ant/bin/ant /usr/bin/ant \
    && echo "Installing Apache Maven" \
    && curl -s -SL https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz | tar xzf - -C /opt \
    && mv /opt/apache-maven* /opt/maven \
    && ln -s /opt/maven/bin/mvn /usr/bin/mvn \
    && echo "Installing Inno Setup binaries" \
    && wget -q -O is.exe "http://files.jrsoftware.org/is/6/innosetup-6.0.5.exe" \
    && wine-x11-run wine is.exe /SP- /VERYSILENT /ALLUSERS /SUPPRESSMSGBOXES \
    && rm -rf is.exe /tmp/commons-daemon.zip /var/lib/apt/lists/*
