ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /root

RUN apt-get update && apt-get install -y jq

ADD Linux/ /root/kr
ADD run.sh /root
RUN chmod a+x /root/run.sh

CMD [ "/root/run.sh" ]
