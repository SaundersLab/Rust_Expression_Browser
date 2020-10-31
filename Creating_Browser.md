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
rake load_data:de_novo_genes[PST-130,../data/PST130_transcripts.fan]

rake load_data:de_novo_genes[PST-104E,../data/Pucstr1_GeneCatalog_CDS_20170922.fasta]

rake load_data:gff_produced_genes["IWGSC v1.1",../data/IWGSC_v1.1_20170706_cds.fasta]
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

## Start the mongodb service
This requires sudo rights

```bash
sudo service mongod start
```

## Load in expression values
This adds the expression data to the mongodb, a log file is removed periodically due to storage limitations

```bash
# Adams et al., in press

rake load_data:values_mongo["Adams\ et\ al.\,\ in\ press",PST130,tpm,../PST130_expression/merged_Adams_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Adams\ et\ al.\,\ in\ press",PST130,count,../PST130_expression/merged_Adams_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Adams\ et\ al.\,\ in\ press",PST_104E,tpm,../PST_104E_expression/merged_Adams_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Adams\ et\ al.\,\ in\ press",PST_104E,count,../PST_104E_expression/merged_Adams_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Adams\ et\ al.\,\ in\ press",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Adams_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Adams\ et\ al.\,\ in\ press",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Adams_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Boshoff et al., 2020

rake load_data:values_mongo["Boshoff\ et\ al.\,\ 2020",PST130,tpm,../PST130_expression/merged_Boshoff_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Boshoff\ et\ al.\,\ 2020",PST130,count,../PST130_expression/merged_Boshoff_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Boshoff\ et\ al.\,\ 2020",PST_104E,tpm,../PST_104E_expression/merged_Boshoff_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Boshoff\ et\ al.\,\ 2020",PST_104E,count,../PST_104E_expression/merged_Boshoff_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Boshoff\ et\ al.\,\ 2020",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Boshoff_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Boshoff\ et\ al.\,\ 2020",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Boshoff_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Bueno-Sancho et al., 2017

rake load_data:values_mongo["Bueno-Sancho\ et\ al.\,\ 2017",PST130,tpm,../PST130_expression/merged_Bueno-Sancho_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Bueno-Sancho\ et\ al.\,\ 2017",PST130,count,../PST130_expression/merged_Bueno-Sancho_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Bueno-Sancho\ et\ al.\,\ 2017",PST_104E,tpm,../PST_104E_expression/merged_Bueno-Sancho_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Bueno-Sancho\ et\ al.\,\ 2017",PST_104E,count,../PST_104E_expression/merged_Bueno-Sancho_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Bueno-Sancho\ et\ al.\,\ 2017",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Bueno-Sancho_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Bueno-Sancho\ et\ al.\,\ 2017",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Bueno-Sancho_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Cantu et al., 2013

rake load_data:values_mongo["Cantu\ et\ al.\,\ 2013",PST130,tpm,../PST130_expression/merged_Cantu_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Cantu\ et\ al.\,\ 2013",PST130,count,../PST130_expression/merged_Cantu_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Cantu\ et\ al.\,\ 2013",PST_104E,tpm,../PST_104E_expression/merged_Cantu_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Cantu\ et\ al.\,\ 2013",PST_104E,count,../PST_104E_expression/merged_Cantu_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Cantu\ et\ al.\,\ 2013",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Cantu_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Cantu\ et\ al.\,\ 2013",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Cantu_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Corredor-Moreno et al., in press

rake load_data:values_mongo["Corredor-Moreno\ et\ al.\,\ in\ press",PST130,tpm,../PST130_expression/merged_Corredor-Moreno_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Corredor-Moreno\ et\ al.\,\ in\ press",PST130,count,../PST130_expression/merged_Corredor-Moreno_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Corredor-Moreno\ et\ al.\,\ in\ press",PST_104E,tpm,../PST_104E_expression/merged_Corredor-Moreno_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Corredor-Moreno\ et\ al.\,\ in\ press",PST_104E,count,../PST_104E_expression/merged_Corredor-Moreno_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Corredor-Moreno\ et\ al.\,\ in\ press",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Corredor-Moreno_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Corredor-Moreno\ et\ al.\,\ in\ press",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Corredor-Moreno_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Dobon et al., 2016

rake load_data:values_mongo["Dobon\ et\ al.\,\ 2016",PST130,tpm,../PST130_expression/merged_Dobon_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Dobon\ et\ al.\,\ 2016",PST130,count,../PST130_expression/merged_Dobon_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Dobon\ et\ al.\,\ 2016",PST_104E,tpm,../PST_104E_expression/merged_Dobon_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Dobon\ et\ al.\,\ 2016",PST_104E,count,../PST_104E_expression/merged_Dobon_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Dobon\ et\ al.\,\ 2016",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Dobon_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Dobon\ et\ al.\,\ 2016",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Dobon_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Garnica et al., 2013

rake load_data:values_mongo["Garnica\ et\ al.\,\ 2013",PST130,tpm,../PST130_expression/merged_Garnica_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Garnica\ et\ al.\,\ 2013",PST130,count,../PST130_expression/merged_Garnica_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Garnica\ et\ al.\,\ 2013",PST_104E,tpm,../PST_104E_expression/merged_Garnica_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Garnica\ et\ al.\,\ 2013",PST_104E,count,../PST_104E_expression/merged_Garnica_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Garnica\ et\ al.\,\ 2013",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Garnica_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Garnica\ et\ al.\,\ 2013",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Garnica_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Hubbard et al., 2015

rake load_data:values_mongo["Hubbard\ et\ al.\,\ 2015",PST130,tpm,../PST130_expression/merged_Hubbard_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Hubbard\ et\ al.\,\ 2015",PST130,count,../PST130_expression/merged_Hubbard_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Hubbard\ et\ al.\,\ 2015",PST_104E,tpm,../PST_104E_expression/merged_Hubbard_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Hubbard\ et\ al.\,\ 2015",PST_104E,count,../PST_104E_expression/merged_Hubbard_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Hubbard\ et\ al.\,\ 2015",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Hubbard_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Hubbard\ et\ al.\,\ 2015",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Hubbard_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Radhakrishnan et al., 2013

rake load_data:values_mongo["Radhakrishnan\ et\ al.\,\ 2019",PST130,tpm,../PST130_expression/merged_Radhakrishnan_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Radhakrishnan\ et\ al.\,\ 2019",PST130,count,../PST130_expression/merged_Radhakrishnan_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Radhakrishnan\ et\ al.\,\ 2019",PST_104E,tpm,../PST_104E_expression/merged_Radhakrishnan_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Radhakrishnan\ et\ al.\,\ 2019",PST_104E,count,../PST_104E_expression/merged_Radhakrishnan_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Radhakrishnan\ et\ al.\,\ 2019",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Radhakrishnan_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Radhakrishnan\ et\ al.\,\ 2019",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Radhakrishnan_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# Schwessinger et al., 2018

rake load_data:values_mongo["Schwessinger\ et\ al.\,\ 2018",PST130,tpm,../PST130_expression/merged_Schwessinger_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["Schwessinger\ et\ al.\,\ 2018",PST130,count,../PST130_expression/merged_Schwessinger_exp_PST130_count_0.tsv]

rake load_data:values_mongo["Schwessinger\ et\ al.\,\ 2018",PST_104E,tpm,../PST_104E_expression/merged_Schwessinger_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["Schwessinger\ et\ al.\,\ 2018",PST_104E,count,../PST_104E_expression/merged_Schwessinger_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["Schwessinger\ et\ al.\,\ 2018",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_Schwessinger_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["Schwessinger\ et\ al.\,\ 2018",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_Schwessinger_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log

# van Schalwyk et al., in press

rake load_data:values_mongo["van\ Schalwyk\ et\ al.\,\ in\ press",PST130,tpm,../PST130_expression/merged_van_Schalwyk_exp_PST130_tpm_0.tsv]
rake load_data:values_mongo["van\ Schalwyk\ et\ al.\,\ in\ press",PST130,count,../PST130_expression/merged_van_Schalwyk_exp_PST130_count_0.tsv]

rake load_data:values_mongo["van\ Schalwyk\ et\ al.\,\ in\ press",PST_104E,tpm,../PST_104E_expression/merged_van_Schalwyk_exp_PST_104E_tpm_0.tsv]
rake load_data:values_mongo["van\ Schalwyk\ et\ al.\,\ in\ press",PST_104E,count,../PST_104E_expression/merged_van_Schalwyk_exp_PST_104E_count_0.tsv]

rake load_data:values_mongo["van\ Schalwyk\ et\ al.\,\ in\ press",IWGSC_v1.1,tpm,../IWGSC_v1_1_expression/merged_van_Schalwyk_exp_IWGSC_v1_1_tpm_0.tsv]
rake load_data:values_mongo["van\ Schalwyk\ et\ al.\,\ in\ press",IWGSC_v1.1,count,../IWGSC_v1_1_expression/merged_van_Schalwyk_exp_IWGSC_v1_1_count_0.tsv]

rm /home/expvip/expvip_web/log/development.log
```
