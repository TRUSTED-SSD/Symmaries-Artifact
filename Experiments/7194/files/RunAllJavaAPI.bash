#!/bin/bash



run_collection(){
apps=("$@");
for appName in "${apps[@]}"; do
dir="7194/files/SyrsWorks/JavaAPI-V3/${appName}";
syrsvers="$( syrs.opt  -V )"
if test -r "${dir}/${round}_res_${variant}.syrs-version"; then oldvers="$(< "${dir}/${round}_res2_${variant}.syrs-version")"; else oldvers="none"; fi
if test -r "${dir}/types.syrs-version"; then oldtypvers="$(< "${dir}/types.syrs-version")"; else oldtypvers="none"; fi
for heapDomain in "${heapDomains[@]}"; do
{
  ts=$(date +%s%N)
  variant="_impl_-except_${heapDomain}_${methskipcond}_-dr_t=${timeout}m_cudd=${cuddmem}GiB_"
  if test ! "${oldtypvers}" = "${syrsvers}" || test ! -f "${dir}/types.classes_bin" -o "${dir}/types.classes" -nt "${dir}/types.classes_bin"; then
    OCAMLRUNPARAM="h=4G" /home/lnk85/symmaries/7194/files/syrs.opt -ll w -tf -exceptions,-taints,levels=implicit,heapdom=${heapDomain} -of scfg "${dir}/types.classes" -o "${dir}/types.classes_bin" -o "${dir}/types.class_stats" && \
    echo "${syrsvers}" > "${dir}/types.syrs-version"
  fi
  if test ! "${oldvers}" = "${syrsvers}"; then
    OCAMLRUNPARAM="h=4G" /home/lnk85/symmaries/7194/files/syrs.opt -ll w -tf -exceptions,-taints,levels=implicit,heapdom=${heapDomain} "${dir}/types.classes_bin" "${dir}/Meth/all.secstubs" "${dir}/Meth/${round}_${heapDomain}_all.meth_files" -of scfg -rf -dr -rf cuddmem=${cuddmem} -pf timeout=$timeout --methskip-cond $methskipcond --safe-walk -o "${dir}/${round}_res2_${variant}.secsums" -o "${dir}/${round}_res2_${variant}.meth_stats" && \
    echo "${syrsvers}" > "${dir}/${round}_res2_${variant}.syrs-version"
    for f in ${dir}/Meth/*.secsum; do
       mv "$f" "${f%.secsum}.${variant}-secsum"
    done
    echo $((($(date +%s%N) - $ts)/1000000)) > "${dir}/${round}_res2_${variant}.elapsed-time"
  fi
} 2>&1 | tee "${dir}/${heapDomain}_${round}_syrsOutputWarnings.txt" 
done
done
}

implicit='-taints,levels=implicit,';
explicit='-taints,levels=explicit,';
methskipcond=300;
timeout='3m'
cuddmem='8GiB'

heapDomains=('dumb' 'ashare');
analysis=$implicit;
analysisType='implicit';

round='r1';
impl_apps=(  'JavaAPI-io' 'JavaAPI-util1' 'JavaAPI-util2' );
run_collection "${impl_apps[@]}" ;

