FROM registry.access.redhat.com/ubi8/ubi-minimal

LABEL maintainer="SouthWinds Tech Ltd"

ARG UNAME=artdocs

ENV UID=100000000
ENV GID=100000000
ENV APP_FOLDER=/site

RUN microdnf install shadow-utils.x86_64 -y && \
    microdnf clean all && rm -rf /var/cache/yum && \
    groupadd -g $GID -o $UNAME && \
    # user home under /home/runtime
    useradd -u $UID -g $GID $UNAME && \
    # app folder
    mkdir -p $APP_FOLDER && chown $UNAME $APP_FOLDER && chmod a+rwx $APP_FOLDER

COPY art /usr/bin/
COPY ./site /site/

WORKDIR /site/

# permissions on artisan CLI
RUN chmod ug+x /usr/bin/art

CMD ["sh", "-c", "art u serve --default-root /intro -p 8080 /site"]

USER $UNAME
