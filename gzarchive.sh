#!/usr/bin/env bash

  local dest_dir='.'
  which gzip &> /dev/null  || echo No gzip present.  Please install gzip.
  which gzip &> /dev/null  || exit
  time for u in "$@"
   do
    case ${u} in
      -h|--help)
       echo "gzarchive [--help] [ -d=path/to/archive/directory ] {directory_root}"
     ;;
      -d=*)
       dest_dir="${u#*=}"
     ;;
      *)
       echo "dest_dir=${dest_dir}"
       test -e ${dest_dir}/__${u}__ && echo ${dest_dir}/__${u}__ Exists. Skipping ${u}
       test -e ${dest_dir}/__${u}__ && continue
       test -d ${u} || echo ${u} Does NOT Exist.  Skipping ${u}
       test -d ${u} || continue
       cd ${u} ;
       echo "Remove .cache/ files [$(date)]" ;
       for cache in .cache/* ;
         do rm -rf ${cache} ;
       done ;
       test -e ${u}./.ssh/authorized_keys && mv -v ${u}./.ssh/authorized_keys ${u}./.ssh/authorized_keys-$(date '+%s')
       test -e ${u}.sha1 && mv -v ${u}.sha1 ${u}.sha1-$(date '+%s')
       echo "Building file hash table for ${u} [$(date)]"
       find -type f -exec sha1sum -b {} \; > ../${u}.sha1
       mv -v ../${u}.sha1 ./
       echo "Verifying file hash table for ${u} [$(date)]"
       sha1sum -c ${u}.sha1 | egrep -v 'OK$'
       cd ..
       echo "Creating archive for ${u} [$(date)]"
       tar czf ${dest_dir}/__${u}__ ${u}/
       echo "Hashing archive for __${u}__ [$(date)]"
       mv -v ${dest_dir}/__${u}__  ${dest_dir}/${u}_$(date "+%Y-%m-%d")_$(sha1sum -b ${dest_dir}/__${u}__ | awk '{ print $1}').tar.gz
     ;;
    esac
   done
