# get coordinates of known variants


com_get_known_variants() {
    local file_path="${1?know variants file path not given}"
    local positions=$(cut -d"," -f1,2 ${file_path})
    echo "${positions}"
}
