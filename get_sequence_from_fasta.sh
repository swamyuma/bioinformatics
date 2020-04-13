awk -v start=2 -v end=10 -v chr=chr1 '$0~chr{getline seq; print substr(seq,start,end-start+1)}' sequence
