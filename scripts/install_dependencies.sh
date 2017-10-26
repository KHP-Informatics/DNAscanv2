#!/bin/bash

#Usage: bash set_up_DNAscan.sh $1
#Example: bash set_up_DNASCAN.sh /home/local/ 

INSTALL_DIR = $1


apt-get -y update

apt-get -y vim

sudo apt-get -y python3

apt-get install -y wget bzip2

mkdir $INSTALL_DIR

cd $INSTALL_DIR

wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh

chmod +x Miniconda2-latest-Linux-x86_64.sh

./Miniconda2-latest-Linux-x86_64.sh -b -p $INSTALL_DIR/Miniconda2/

export PATH=$INSTALL_DIR/Miniconda2/bin:$PATH

echo export PATH=$INSTALL_DIR/Miniconda2/bin:$PATH >> ~/.bashrc

conda config --add channels conda-forge

conda config --add channels defaults

conda config --add channels r

conda config --add channels bioconda

conda install -y samtools

conda install -y freebayes

conda install -y bedtools

conda install -y vcftools

conda install -y  bcftools

conda install -y gatk

wget https://software.broadinstitute.org/gatk/download/auth?package=GATK

mv auth\?package\=GATK GenomeAnalysisTK-3.8.tar.bz2

gatk-register GenomeAnalysisTK-3.8.tar.bz2 ($INSTALL_DIR/Miniconda2/opt/gatk-3.8/GenomeAnalysisTK.jar)

conda install -y hisat2

conda install -y bwa

conda install -y rtg-tools

conda install -y multiqc

conda install -y fastqc

conda install -y expansionhunter


mkdir dnasca

cd dnascan

mkdir hg19

cd hg19

tar -zxvf chromFa.tar.gz

for i in chr1.fa chr2.fa chr3.fa chr4.fa chr5.fa chr6.fa chr7.fa chr8.fa chr9.fa chr10.fa chr11.fa chr12.fa chr13.fa chr14.fa chr15.fa chr16.fa chr17.fa chr18.fa chr19.fa chr20.fa chr21.fa chr22.fa chrY.fa chrX.fa chrM.fa; do cat $i >> hg19.fa ; rm $i ; done

rm chr*

samtools faidx hg19.fa

apt-get update -qq

apt-get install -y -qq bzip2 gcc g++ make python zlib1g-dev

cd $INSTALL_DIR

mkdir manta

cd manta

wget https://github.com/Illumina/manta/releases/download/v1.2.1/manta-1.2.1.release_src.tar.bz2

tar -xjf manta-1.2.1.release_src.tar.bz2

mkdir build && cd build

../manta-1.2.1.release_src/configure --jobs=4 --prefix=$INSTALL_DIR/manta/

make -j4 install

export PATH:$INSTALL_DIR/manta/bin:$PATH

echo export PATH:$INSTALL_DIR/manta/bin:$PATH >> ~/.bashrc
