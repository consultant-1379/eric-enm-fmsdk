ARG ERIC_ENM_SLES_EAP7_IMAGE_NAME=eric-enm-sles-eap7
ARG ERIC_ENM_SLES_EAP7_IMAGE_REPO=armdocker.rnd.ericsson.se/proj-enm
ARG ERIC_ENM_SLES_EAP7_IMAGE_TAG=1.64.0-32

FROM ${ERIC_ENM_SLES_EAP7_IMAGE_REPO}/${ERIC_ENM_SLES_EAP7_IMAGE_NAME}:${ERIC_ENM_SLES_EAP7_IMAGE_TAG}



ARG BUILD_DATE=unspecified
ARG IMAGE_BUILD_VERSION=unspecified
ARG GIT_COMMIT=unspecified
ARG ISO_VERSION=unspecified
ARG RSTATE=unspecified


LABEL \
com.ericsson.product-number="CXC Placeholder" \
com.ericsson.product-revision=$RSTATE \
enm_iso_version=$ISO_VERSION \
org.label-schema.name="ENM FM SDK Base Image" \
org.label-schema.build-date=$BUILD_DATE \
org.label-schema.vcs-ref=$GIT_COMMIT \
org.label-schema.vendor="Ericsson" \
org.label-schema.version=$IMAGE_BUILD_VERSION \
org.label-schema.schema-version="1.0.0-rc1"

RUN zypper install -y ERICserviceframework4_CXP9037454 \
    ERICmediationengineapi2_CXP9038435 \
    ERICpib2_CXP9037459 \
    ERICdpsruntimeimpl_CXP9030468 \
    ERICpmmedcom2_CXP9038438 \
    ERICmediationresolverspi2_CXP9038532 \
    ERICtpattributeresolver2_CXP9038530 \
    ERICdpsattributeresolver2_CXP9038437 \
    ERICtssresolver2_CXP9038531 \
    ERICconfigureattributeresolver2_CXP9038528 \
    ERICrequestattributeresolver2_CXP9038529 \
    ERICsfkattributeresolver2_CXP9039758 \
    ERICmodelservice_CXP9030595 \
    ERICddc_CXP9030294 \
    ERICserviceframeworkmodule4_CXP9037453 \
    ERICmodelserviceapi_CXP9030594 \
    ERICdpsruntimeapi_CXP9030469 \
    ERICcryptographyservice_CXP9031013 \
    ERICcryptographyserviceapi_CXP9031014 \
    ERICenterpriseheartbeatconnectorrar_CXP9035229 \
    ERICenterpriseheartbeatconnectorapi_CXP9031706 \
    ERICsnmpheartbeatprovider_CXP9031707 \
    ERICsnmpenterpriseconnector_CXP9031525 \
    ERICsnmpenterpriseconnectorapi_CXP9031534 \
    ERICsnmpconnector_CXP9031526 \
    ERICsnmpconnectorapi_CXP9031535 \
    ERICsnmpfmengine2_CXP9038385 \
    ERICtransportapi_CXP9031610 \
    ERICsessionmanagerapi_CXP9031998 \
    ERICsessionmanager_CXP9031997 \
    ERICsnmpfmhandler2_CXP9038382 \
    EXTRwebnmssnmpapimodule_CXP9031603 \
    net-snmp && \
    zypper clean -a

COPY --chown=jboss_user:root image_contents/jboss-as.conf /ericsson/3pp/jboss/jboss-as.conf
COPY --chown=jboss_user:root image_contents/post-start/mediationservice_cluster_join.sh /ericsson/3pp/jboss/bin/post-start/
COPY --chown=jboss_user:root image_contents/cli/scripts/* /ericsson/3pp/jboss/bin/cli/services/
COPY --chown=jboss_user:root image_contents/createCertificatesLinks.sh /ericsson/3pp/jboss/bin/pre-start/
COPY --chown=jboss_user:root image_contents/updateCertificatesLinks.sh /usr/lib/ocf/resource.d/updateCertificatesLinks.sh
COPY --chown=jboss_user:root image_contents/pre-start/fdresize.sh /ericsson/3pp/jboss/bin/pre-start/
COPY --chown=jboss_user:root image_contents/pre-start/jfrremove.sh /ericsson/3pp/jboss/bin/pre-start/
COPY --chown=jboss_user:root image_contents/pre-start/appname_change_for_service_capabilities.sh /ericsson/3pp/jboss/bin/pre-start/

RUN /bin/chmod ug+x /usr/lib/ocf/resource.d/updateCertificatesLinks.sh && \
	chmod ug+x /ericsson/3pp/jboss/bin/pre-start/appname_change_for_service_capabilities.sh && \
	chmod ug+x /ericsson/3pp/jboss/bin/pre-start/fdresize.sh && \
	chmod ug+x /ericsson/3pp/jboss/bin/pre-start/jfrremove.sh

# TODO: Hopw will DDP be integrated?
# COPY --chown=jboss_user:root image_contents/ddp-utils/SERVICE_GROUP_MAPPING /opt/ericsson/ddp-utils/

# TODO: Verify these can be here (and not in the fmsdk-templates Dockerfile) and are actually needed.
ENV ENM_JBOSS_BIND_ADDRESS="0.0.0.0" \
    GLOBAL_CONFIG="/gp/global.properties" \
    JBOSS_CONF="/ericsson/3pp/jboss/jboss-as.conf" \
    CLOUD_NATIVE_DEPLOYMENT="true"
