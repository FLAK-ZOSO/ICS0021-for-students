
shopt -s nullglob
host_keys=(/etc/ssh/ssh_host_*_key /etc/ssh/ssh_host_*_key.pub)
if (( ${#host_keys[@]} )); then
    shred -u "${host_keys[@]}"
fi
shopt -u nullglob
