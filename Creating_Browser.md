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
