#!/bin/bash -ex

echo "##############################################################################"
echo "## $0 "
echo "##############################################################################"

echo "# PWD=$PWD"
echo "# BASE_DIR=$BASE_DIR"


## Move modifiable data to /data and make the output tar
## before removing the local content
TARGET_RO_DIR="${BASE_DIR}/target_ro"

TMP_DIR=$(mktemp -d)
TMP_DATA="${TMP_DIR}/data"
DATA_ETC="${TMP_DATA}/etc"
DATA_VAR="${TMP_DATA}/var"
DATA_ROOT="${TMP_DATA}/root"

echo "# TARGET_RO_DIR=${TARGET_RO_DIR}"

rm -rf "${TARGET_RO_DIR}"
cp -al "${TARGET_DIR}" "${TARGET_RO_DIR}"
mkdir -p "${TARGET_RO_DIR}/data"

mkdir -p "${DATA_ETC}/docker"
mkdir -p "${DATA_ROOT}"

rm -rf "${TARGET_RO_DIR}/etc/supervisor.d"
mkdir -p "${DATA_ETC}/supervisor.d"

echo "%sudo ALL=(ALL) ALL" >> "${TARGET_RO_DIR}/etc/sudoers"

pushd "${TARGET_RO_DIR}/usr"
mkdir -p "${TMP_DATA}/local"
ln -sf ../data/local local
echo 'export PATH=${PATH}:/usr/local/bin' >> ${TARGET_RO_DIR}/etc/profile.d/path.sh
popd

pushd "${TARGET_RO_DIR}/etc"
#groupadd -f -r -R ${TARGET_RO_DIR} supervisor || true
#groupadd -f -r -R ${TARGET_RO_DIR} www-data || true
#groupadd -f -r -R ${TARGET_RO_DIR} i2c || true
#useradd -R ${TARGET_RO_DIR} -s /bin/true -G www-data supervisor
#useradd -R ${TARGET_RO_DIR} -s /bin/true -G www-data audio
#useradd -R ${TARGET_RO_DIR} -s /bin/true -G www-data i2c
#usermod -R ${TARGET_RO_DIR} -a -G i2c www-data
#usermod -R ${TARGET_RO_DIR} -a -G supervisor www-data
sed -i 's/dialout:x:18:$/dialout:x:18:chip/g' group
sed -i 's/audio:x:29:$/audio:x:29:chip/g' group
sed -i 's/netdev:x:82:$/netdev:x:82:chip/g' group
echo "supervisor:x:998:chip" >> group
popd

mkdir -p "${TMP_DATA}/src"
chmod a+rwx "${TMP_DATA}/src"

pushd "${TARGET_RO_DIR}/etc"
mv cron.d "${DATA_ETC}/cron.d"
ln -sf ../data/etc/cron.d cron.d
mv ssh "${DATA_ETC}/ssh"
ln -sf ../data/etc/ssh ssh
mv dnsmasq.conf "${DATA_ETC}/"
ln -sf ../data/etc/dnsmasq.conf dnsmasq.conf
mv direwolf.conf "${DATA_ETC}/"
ln -sf ../data/etc/direwolf.conf direwolf.conf
mv supervisord.conf "${DATA_ETC}/"
ln -sf ../data/etc/docker docker
ln -sf ../data/etc/supervisor.d supervisor.d
ln -sf ../data/etc/supervisord.conf supervisord.conf
mv lighttpd "${DATA_ETC}/lighttpd"
ln -sf ../data/etc/lighttpd lighttpd
popd

pushd "${TARGET_RO_DIR}/"

mv var "${TMP_DATA}/"

INJECT_ARCHIVE="${BINARIES_DIR}/inject.tar"
mkdir -p "${TMP_DATA}"
if [[ -f "${INJECT_ARCHIVE}" ]]; then
echo "## found gadget project to inject..."
pushd "${TMP_DATA}"
tar xf "${INJECT_ARCHIVE}"
popd
fi

ln -sf data/var var
mkdir -p "${DATA_VAR}/lib/gadget"
mkdir -p "${DATA_VAR}/lib/docker"
mkdir -p "${DATA_VAR}/empty"


pushd "${TMP_DATA}/"
ln -sf ../tmp tmp
ln -sf ../run run
popd

ls -lsah "${TARGET_RO_DIR}/root/.ssh"
mv ${TARGET_RO_DIR}/root/.ssh ${DATA_ROOT}/
ls -lsah ${DATA_ROOT}/.ssh/authorized_keys
chmod 0600 ${DATA_ROOT}/.ssh/authorized_keys
pushd ${TARGET_RO_DIR}/root
ln -sf ../data/root/.ssh .ssh
popd

popd

pushd "${TARGET_RO_DIR}/etc/init.d"
mkdir -p "${DATA_ETC}/init.d"
echo "#!/bin/sh" > "${DATA_ETC}/init.d/S51direwolf"
echo "killall gpsd" >> "${DATA_ETC}/init.d/S51direwolf"
echo "stty 9600 < /dev/ttyS1" >> "${DATA_ETC}/init.d/S51direwolf"
echo "/usr/sbin/gpsd -n /dev/ttyS1 &" >> "${DATA_ETC}/init.d/S51direwolf"
echo "/data/src/ChipTNC-config/config-tnc.sh" >> "${DATA_ETC}/init.d/S51direwolf"
echo "/bin/mkdir /tmp/supervisor" >> "${DATA_ETC}/init.d/S51direwolf"
echo "/bin/chmod a+wrx /tmp/supervisor" >> "${DATA_ETC}/init.d/S51direwolf"
echo "/bin/chmod a+wr /dev/i2c*" >> "${DATA_ETC}/init.d/S51direwolf"
echo "/usr/bin/direwolf -t 0 -a 15 -c /data/etc/direwolf.conf > /tmp/supervisor/direwolf-stdout.log 2>&1 &" >> "${DATA_ETC}/init.d/S51direwolf"

chmod +x "${DATA_ETC}/init.d/S51direwolf"
ln -sf ../../data/etc/init.d/S51direwolf S51direwolf
popd

# Create tar ball for ro rootfs
echo "# generating '${BINARIES_DIR}/rootfs_ro.tar'..."
tar -C "${TARGET_RO_DIR}" -c -f "${BINARIES_DIR}/rootfs_ro.tar" .

# Create tar ball for writable partition
echo "# generating '${BINARIES_DIR}/data.tar'..."
tar -C "${TMP_DATA}" -c -f "${BINARIES_DIR}/data.tar" .

# Cleanup
rm -rf "${TMP_DIR}"
