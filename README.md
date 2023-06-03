# checkhash
Archive and Validation tools.

The utilities "gzarchive" and "xzarchive" take user directory root, remove certain "cached" elements (.cache/),
checksum and validate all "files", and save into a compressed archive file (e.i. tarball).

The compressed archive is further hashed (e.i. sha1) and the hash is integrated into the file name along with the archive date.

