#!/bin/bash
Misc=(
'zxingorg-core-3.5.3-SNAPSHOT'  'eventbus-3.1.1' 
'secretsmanager-2.20.93'  
'snappy-java-1.1.9.1' 'kerby' 'rocketMQ'

);

Bookkeeper=('bookkeeper-4-16.3/org.apache.bookkeeper-circe-checksum-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-stream-storage-service-api-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-statelib-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper.http-http-server-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper.stats-prometheus-metrics-provider-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-stream-storage-java-client-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-stream-storage-service-impl-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-common-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper.stats-bookkeeper-stats-api-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-slogger-slf4j-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-slogger-api-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-cpu-affinity-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper.http-vertx-http-server-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-stream-storage-cli-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-server-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-native-io-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-tools-framework-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-common-allocator-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-tools-ledger-4.16.3' 'bookkeeper-4-16.3/org.apache.bookkeeper-stream-storage-server-4.16.3'  'bookkeeper-4-16.3/org.apache.bookkeeper-bookkeeper-proto-4.16.3');


Keyloack=('keycloack/keycloak-core-22.0.1' 'keycloack/keycloak-server-spi-22.0.1' 'keycloack/keycloak-jetty-adapter-spi-22.0.1' 'keycloack/keycloak-server-spi-private-22.0.1' 'keycloack/keycloak-jetty94-adapter-22.0.1' 'keycloack/keycloak-common-22.0.1' 'keycloack/keycloak-jetty-core-22.0.1' 'keycloack/keycloak-adapter-spi-22.0.1' 'keycloack/keycloak-adapter-core-22.0.1' 'keycloack/keycloak-crypto-default-22.0.1');



run_collection(){
apps=("$@");
for appName in "${apps[@]}"; do
dir="7194/files/SyrsWorks/FSESupplementary Materials/Applications/${appName}";
syrsvers="$( syrs.opt  -V )";
if test -r "${dir}/results${variant}.syrs-version"; then oldvers="$(< "${dir}/results${variant}.syrs-version")"; else oldvers="none"; fi;
if test -r "${dir}/types.syrs-version"; then oldtypvers="$(< "${dir}/types.syrs-version")"; else oldtypvers="none"; fi;
for heapDomain in "${heapDomains[@]}"; do
  ts=$(date +%s%N)
  variant="_"$analysisType"_conf_-exceptions_"${heapDomain}"_"$methskipcond"_-dr_timeout=5m_cuddmem="$cuddmem"_";
  if test ! "${oldtypvers}" = "${syrsvers}" || test ! -f "${dir}/types.classes_bin" -o "${dir}/types.classes" -nt "${dir}/types.classes_bin"; then \
    OCAMLRUNPARAM="h=4G" 7194/files/syrs.opt  -ll w  -of secsum -tf -exceptions,"${analysis}"heapdom=${heapDomain} "${dir}/types.classes" -o "${dir}/types.classes_bin" -o "${dir}/types.class_stats" && \
    echo "${syrsvers}" > "${dir}/types.syrs-version"; \
  fi && \
  if test ! "${oldvers}" = "${syrsvers}"; then \
    OCAMLRUNPARAM="h=4G" 7194/files/syrs.opt  -ll w -of secsum   -tf -exceptions,${analysis},heapdom=${heapDomain} "${dir}/types.classes_bin" "${dir}/Meth/all.secstubs" "${dir}/Meth/all.meth_files" -of secsum -rf -dr -rf cuddmem=$cuddmem -pf timeout=$timeout --methskip-cond $methskipcond --safe-walk -o "${dir}/results${variant}.secsums" -o "${dir}/results${variant}.meth_stats" && \
    echo "${syrsvers}" > "${dir}/results${variant}.syrs-version"
    echo $((($(date +%s%N) - $ts)/1000000)) > "${dir}/results${variant}.elapsed-time"
  fi
done
done
}

implicit='-taints,levels=implicit,';
explicit='-taints,levels=explicit,';
methskipcond=300;
timeout='5m'
cuddmem='8GiB'

heapDomains=('dumb');
analysis=$implicit;
analysisType='implicit';

run_collection "${Misc[@]}" ;
run_collection "${Keyloack[@]}" ;
run_collection "${Bookkeeper[@]}" ;




