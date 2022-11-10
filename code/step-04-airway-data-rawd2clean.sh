
#-------------------------------------------------------
# Aim：使用两款软件过滤fastq文件
# Author：zhangj
# update：2020-05-26
#-------------------------------------------------------


## 1.trim_galore过滤
# 单个样本
rawdata=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/fastq
cleandata=/home/jzhang/project/Human-16-Asthma-Trans/data/cleandata/trim_galore
trim_galore --phred33 -q 20 --length 36 --stringency 3 --fastqc --paired --max_n 3 -o $cleandata $rawdata/SRR1039510_1.fastq.gz $rawdata/SRR1039510_2.fastq.gz

# 多个
cat /home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/sra/sra.id | while read id
do
	echo "trim_galore --phred33 -q 20 --length 36 --stringency 3 --fastqc --paired --max_n 3 -o ${cleandata} ${rawdata}/${id}_1.fastq.gz ${rawdata}/${id}_2.fastq.gz"
done


nohup sh trim_galore.sh >trim_galore.log &

# 结果解读




## 2.fastp过滤
# 单个
rawdata=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/fastq
cleandata=/home/jzhang/project/Human-16-Asthma-Trans/data/cleandata/fastp
fastp  -l 36 -q 20 --compression=6 -R SRR1039508 -h SRR1039508.html -n 3 -i $rawdata/SRR1039508_1.fastq.gz -o $cleandata/SRR1039508_1_clean.fq.gz -I $rawdata/SRR1039508_2.fastq.gz -O $cleandata/SRR1039508_2.clean.fq.gz 

# 多个
cat /home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/sra/sra.id | while read id
do
	echo "fastp  -l 36 -q 20 --compression=6 -R ${id} -h ${id}.html -n 3 -i $rawdata/SRR1039508_1.fastq.gz -o $cleandata/${id}_1_clean.fq.gz -I $rawdata/${id}_2.fastq.gz -O $cleandata/${id}_2.clean.fq.gz"  
done

# 结果解读