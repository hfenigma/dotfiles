# no space after comma
# no slash after source directory
rsync -ahv --delete --exclude={"MATLAB",".cache","projects/*/Data",".local/share/Trash",".thumbnails",".gvfs"} ~ /run/media/enigma/stash/backup/
rsync -ahv --delete /etc /run/media/enigma/stash/backup/
rsync -ahv --delete /usr/lib/modprobe.d /run/media/enigma/stash/backup/
rsync -ahv --delete /usr/lib/modules-load.d /run/media/enigma/stash/backup/

