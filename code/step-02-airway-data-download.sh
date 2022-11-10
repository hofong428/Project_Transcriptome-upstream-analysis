
#-------------------------------------------------------
# Aim：airway数据下载
# Author：zhangj
# update：2020-05-26
#-------------------------------------------------------

# ------------------------------------------------------
# GEO accession：GSE52778
# BioProject：PRJNA229998
# SRA：SRP033351
# ------------------------------------------------------

### 1.下载数据
# 进入目录
cd ~/project/Human-16-Asthma-Trans/data/rawdata/sra

# 每次使用生信软件分析前，都必须要激活创建的小环境Trans
conda activate Trans


## 1.1 使用sra-tools工具包的prefetch命令
# 使用prefetch命令下载单个文件：如SRR1039511
prefetch SRR1039511

# 批量下载：建立循环，并查看
# 为什么使用绝对路径（重点）,=号两边没有空格
outputdir=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/sra
cat SraAccList.txt | while read id
do
	echo "prefetch ${id} -O ${outputdir} "
done

# 运行脚本，由于服务器资源有限，运行不报错就好了，ctrl+C强制退出
bash downlaod.sh


## 1.2 使用aspera下载：https://downloads.asperasoft.com/

# ---------------------------------------------------------------------------------------------------------------------
Aspera的常用参数：
-T # 不进行加密。若不添加此参数，可能会下载不了。
-i string # 输入私钥，安装后有在目录 ~/.aspera/connect/etc/下有几个私钥，使用服务器用asperaweb_id_dsa.openssh文件作为私钥。
--host=string # ftp的host名，NCBI的为ftp-private.ncbi.nlm.nih.gov；EBI的为fasp.sra.ebi.ac.uk。
--user=string # 用户名，NCBI的为anonftp，EBI的为era-fasp。
--mode=string # 选择模式，上传为 send，下载为 recv。 
-l string # 设置最大传输速度，比如设置为 200M 则表示最大传输速度为 200m/s。若不设置该参数，则一般可达到10m/s的速度
# ---------------------------------------------------------------------------------------------------------------------

# EBI（https://www.ebi.ac.uk/ena/browser/home）
# 下载单个文件
# sra格式
ascp -QT -l 300m -P33001 -i ~/biosoft/miniconda3/envs/Trans/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/srr/SRR103/001/SRR1039511 .
# gz格式
ascp -QT -l 300m -P33001 -i ~/biosoft/miniconda3/envs/Trans/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR103/008/SRR1039508/SRR1039508_1.fastq.gz .

# 批量下载
outputdir=/home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/sra

less filereport_read_run_PRJNA229998_tsv.txt |awk 'NR>1{print $NF}' >sra.list
cat  sra.list |while read id
do
	echo "ascp -QT -l 300m -P33001 -i ~/biosoft/miniconda3/envs/Trans/etc/asperaweb_id_dsa.openssh era-fasp@${id} ${outputdir}"
done

# 提交后台
nohup bash step1-aspera.sh >step1-aspera.log &



## 1.3 数据完整性检验(非常重要！！！)
# 得到md5值
awk 'NR>1{print $11"\t"$4}' filereport_read_run_PRJNA229998_tsv.txt

# md5值检验
md5sum -c md5









