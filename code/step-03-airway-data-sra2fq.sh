
#-------------------------------------------------------
# Aim：airway数据sra转换fastq，并质控
# Author：zhangj
# update：2020-05-26
#-------------------------------------------------------

## 使用SRA Toolkit:fastq-dump转换原始数据
# 使用fastq-dump命令将sra格式文件转换为fastq格式, （-X参数设置了解压出来多少read，这里为了授课，使用小数据量进行演示，实际过程不需要添加这个参数）
sradir=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/sra
fqdir=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/fastq
fastq-dump --gzip --split-e -X 25000 -O $fqdir $sradir/SRR1039508

# 批量转换
cat sra/SraAccList.txt |while read id
do
	echo "fastq-dump --gzip --split-e -X 25000 -O ${fqdir} ${sradir}/${id} "
done 

nohup sh sra2fqstq.sh >sra2fqstq.log &

# 数据完整性检验(非常重要)(可选，下载fq.gz)
sed -n '2~4p' filereport_read_run_PRJNA229998_tsv.txt |awk '{print $10"\t"$4}' >md5
md5sum -c md5



## 对原始数据做质控：使用fastqc对fastq文件进行质量评估

# ---------------------------------------------------------------------------------
FastQC的常用参数：
--help # 打印fastqc的帮助信息
-o / --outdir # 设置输出目录，此文件夹一定要存在，否则无法生成结果。默认将结果输出到输入. 
-j / --java # 指定java的路径，否则java命令存在于系统环境变量PATH中。
-f / --format # 指定输入格式，默认为fastq。可选格式为：bam/sam等。 
-t / --threads # 线程数
# ---------------------------------------------------------------------------------

# 使用FastQC软件对单个fastq文件进行质量评估，结果输出到qc/文件夹下
qcdir=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/qc
fqdir=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/fastq
fastqc -t 2 -o $qcdir $fqdir/SRR1039508_1.fastq.gz

# 多个
fastqc -t 2 -o . ../fastq/SRR*.fastq.gz


# 使用MultiQc整合FastQC结果
multiqc *.zip

# ----------------------------------------------------------
MultiQC的主要参数：
--help # 打印MultiQC的帮助信息
-o / --outdir # 指定输出文件夹。
# ----------------------------------------------------------

