FROM ubuntu:latest
RUN apt update
RUN apt upgrade -y
RUN apt install ca-certificates -y

# Extras
RUN apt install curl wget unzip -y --no-install-recommends -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Timezone (TZ)
RUN apt update && apt install tzdata -y
ENV TZ=Australia/Melbourne
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Bash shell & dependancies
RUN apt install bash -y

# Volumes
VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve

# Add ffmpeg 
#RUN apt install ffmpeg -y


# Add vlc
#RUN apt install vlc -y
#RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

# Add xTeve
RUN wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip
ADD entrypoint.sh /
ADD example_xteve.txt /

# Set executable permissions
RUN chmod +x /entrypoint.sh
#RUN chmod +x /cronjob.sh
RUN chmod +x /usr/bin/xteve

# Expose Port
EXPOSE 34400

# Entrypoint
ENTRYPOINT ["./entrypoint.sh"]
