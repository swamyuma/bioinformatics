ifndef ref_fasta
$(error ref_fasta not supplied)
endif

ifndef ref_name
$(error ref_name not supplied)
endif

ifndef input_fastq
$(error input_fastq not supplied)
endif

ifndef run_id
$(error run_id not supplied)
endif

ifndef output_dir
$(error output_dir not supplied)
endif

# define variables
MKDIR := mkdir -p
mapper := bwa
params := BwaC
output_file := $(output_dir)/$(run_id)_$(params)
make_sam := $(output_file).sam
make_bam := $(output_file).bam
sort_bam := $(output_file).sorted.bam
index_bam := $(sort_bam).bai

.DELETE_ON_ERROR:
.PHONY: index_bam
index_bam: $(index_bam)


# map fastq to reference genome
$(make_sam): $(input_fastq)
	$(MKDIR) $(output_dir)
	bwa mem -M -B 8 $(ref_fasta) $< > $@

# convert sam to map
$(make_bam): $(make_sam)
	samtools view -Sb $< > $@

# sort mapped bam
$(sort_bam): $(make_bam)
	samtools sort $< -o $@

# index sorted bam
$(index_bam): $(sort_bam)
	samtools index $<

# debugging
.PHONY: print
print:
	$(foreach v, $(.VARIABLES), $(info $(v) = $($(v))))
