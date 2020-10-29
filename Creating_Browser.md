# Comands used to build the Rust Expression Browser

These commands follow from those described for initial set up at <https://github.com/JIC-CSB/expvip-ansible>, particularly ensure that activate.sh has been sourced
Commands are all run from the expvip_web directory

## Set up BLAST server that is on the homepage of the browser

```bash
sequenceserver -p 3000 -m -d /home/expvip/data
sequenceserver -p 3000 -d /home/expvip/data # Quit this after the message appears saying sequenceserver has started
```

## Set up MySQL databases
These contain information on the samples

```bash
rake db:setup
rake db:migrate
```

## Initial provision of databases
This adds information on used fields and which are shown by default

```bash
rake load_data:factor[../custom_config/FactorOrder.tsv]
rake load_data:default_factor_order[../custom_config/default_factor_order.txt]
```

## Load the metadata files

```bash
for file in $(ls ../metadata_files/*metadata.txt)
do
    rake load_data:metadata["$file"]
done
```

## Load gene sets
This adds the transcripts to the MySQL databases

```bash
rake load_data:de_novo_genes[PST130,../data/PST130_transcripts.fan]

rake load_data:de_novo_genes[PST_E104,../data/Pucstr1_GeneCatalog_CDS_20170922.fasta]

rake load_data:gff_produced_genes[IWGSC_v1.1,../data/IWGSC_v1.1_20170706_cds.fasta]
```

## Load in homology data for wheat genes
This allows the visualtion of gene homoeologues and the creation of ternary plots

```bash
rake load_data:homology_pairs[IWGSC_v1.1,../custom_config/homologies_ta_compara_plants_41_94.txt]
```

## Load default genes
This controls what genes are suggested to users as examples

```bash
rake load_data:sample_genes[../custom_config/default_genes.csv]
```
