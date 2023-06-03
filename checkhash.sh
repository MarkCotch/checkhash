#!/usr/bin/env bash
 for f in "$@"
  do
   test -f $f || continue
   export HASH=$(echo ${f}| grep -o  '[0-9a-fA-F]\{32,128\}' )
   case $(echo -n ${HASH} | wc -c) in
    32)
       which md5sum &> /dev/null || echo md5sum Not Installed. Skipping ${F} .
       which md5sum &> /dev/null || continue
       echo "${HASH} *${f}" | md5sum -c -
    ;;
    40)
       which sha1sum &> /dev/null || echo sha1sum Not Installed. Skipping ${F} .
       which sha1sum &> /dev/null || continue
       echo "${HASH} *${f}" | sha1sum -c -
    ;;
    56)
       which sha224sum &> /dev/null || echo sha224sum Not Installed. Skipping ${F} .
       which sha224sum &> /dev/null || continue
       echo "${HASH} *${f}" | sha224sum -c -
    ;;
    64)
       which sha256sum &> /dev/null || echo sha256sum Not Installed. Skipping ${F} .
       which sha256sum &> /dev/null || continue
       echo "${HASH} *${f}" | sha256sum -c -
    ;;
    96)
       which sha384sum &> /dev/null || echo sha384sum Not Installed. Skipping ${F} .
       which sha384sum &> /dev/null || continue
       echo "${HASH} *${f}" | sha384sum -c -
    ;;
    128)
       which sha512sum &> /dev/null || echo sha512sum Not Installed. Skipping ${F} .
       which sha512sum &> /dev/null || continue
       echo "${HASH} *${f}" | sha512sum -c -
    ;;
    *)
       echo "No Identified HASH found in filename: ${f}"
        continue
    ;;
   esac
 done
