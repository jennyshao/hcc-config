#!/bin/bash
MODDIR=/etc/selinux/mymodules

CHKMOD=/usr/bin/checkmodule
MODPKG=/usr/bin/semodule_package
SEMOD=/usr/sbin/semodule
LS=/bin/ls

for i in $(${LS} -1 ${MODDIR}/*.te); do
j=${i/te/mod};
${CHKMOD} -M -m -o ${j} ${i};
k=${i/te/pp};
${MODPKG} -o ${k} -m ${j};
${SEMOD} -i ${k};
done 
