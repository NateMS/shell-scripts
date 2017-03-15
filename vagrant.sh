#!/bin/bash

LOCKFILE=~/vagrant.lock
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "already running an instance of this script"

	for i in {5..1}
	do
		echo -ne "\rclosing terminal in $i seconds"
		sleep 1
	done
    exit
fi

trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

cd ~/code/ip_116vt_Lagerverwaltung1/homesteadConfig

if ! vagrant status | grep -q 'poweroff';
then
	echo "Vagrant box is currently online"
	vagrant halt
else
	echo "Vagrant box is currently offline"
	vagrant up
fi

rm -f ${LOCKFILE}
end
