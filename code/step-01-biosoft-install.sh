
#-------------------------------------------------------
# Aim：conda软件安装和管理：
# conda管理生信软件一文就够
# https://mp.weixin.qq.com/s/vhSpEoIkYP5Hky0lnyGVvQ

# Author：zhangj
# update：2020-05-26
#-------------------------------------------------------

## ------------1.conda安装和管理
# 从官网下载最新版Miniconda3安装包，但速度较慢
wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 

# 从清华镜像下载最新版Miniconda3安装包，速度很快，国内用户推荐
# 这里要搞清楚miniconda和Anaconda的区别：后者包含python2，本身也包含miniconda，文件也比较大，一般使用后者就可以了
wget -c  https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh

# 为节约时间，直接拷贝提前下载好的文件
cp /home/jzhang/biosoft/Miniconda3-latest-Linux-x86_64.sh ./

# 安装Miniconda3：安装过程只需要输入 yes 或者按 Enter
bash Miniconda3-latest-Linux-x86_64.sh


# miniconda3安装成功，并成功配置好环境变量
source ~/.bashrc
conda --help



## -------------2.设置国内镜像源
# 添加bioconda channel，bioconda中包含了生物信息学相关的软件
# 安装一次，只配置一次，注意语句复制正确，
# 一行一行复制在命令行上按enter键运行，不会出现任何提示即为正确 
# 下面这三行配置官网的channel地址
conda config --add channels r 
conda config --add channels conda-forge 
conda config --add channels bioconda

# 下面这四行配置清华大学的bioconda的channel地址，国内用户推荐
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/

# 配置镜像成功
conda config --set show_channel_urls yes
conda config --set channel_priority flexible

# 查看配置结果
cat ~/.condarc




## ----------------3.conda管理环境
# 创建名为rna的软件环境来安装转录组学分析的生物信息学软件
# 创建小环境成功，并成功安装python3版本，每建立一个小环境，安装一个python=3的软件作为依赖
conda create -y -n Trans python=3

# 查看当前conda环境
conda info --e

# 每次运行前，激活创建的小环境rna，成功激活进入小环境，即可安装软件
conda activate Trans

# 退出小环境
conda deactivate




## -----------------4.conda管理软件
# 可以一次安装多个软件
conda install -y sra-tools
conda install -y sra-tools fastqc trim-galore hisat2 subread multiqc samtools salmon fastp

# 运行以下语句，不出现报错表示安装成功
prefetch --help
fastq-dump --help
which prefetch

fastqc --help

trim_galore --help

hisat2 -h

featureCounts
multiqc --help

samtools
which samtools

salmon -h

fastp --help

# 安装首先使用conda安装aspera
conda activate Trans
conda install -y -c hcc aspera-cli
conda install -y -c bioconda sra-tools

## 一定要搞清楚你的软件被conda安装在哪
which ascp 


## 小知识点
# 下载安装软件之前先搜索是否存在
http://bioconda.github.io/conda-recipe_index.html
网页搜索：conda ascp



#------------------------报错日志---------------------------
# 报错日志1
# fastp: /home/jzhang/biosoft/miniconda3/envs/Trans/bin/../lib/libstdc++.so.6: version `GLIBCXX_3.4.22' not found (required by fastp)
# 参考：https://blog.csdn.net/u010987458/article/details/71702938/
conda install libgcc
cd /home/jzhang/biosoft/miniconda3/lib
cp  libstdc++.so.6  ../envs/Trans/bin/../lib/


#------------------------conda上没有的软件安装---------------
# 不在conda中的软件：编译安装，下载二进制包。

# 有权限安装的目录：
# 1.配置
./configure --prefix='/home/jzhang/biosoft'
# 2.编译make
# 3.安装make install
# 添加环境变量
export PATH="/home/jzhang/biosoft/samtools/bin:$PATH$"

# 不适用conda安装
## 1.2 使用aspera下载：https://downloads.asperasoft.com/
wget wget https://d3gcli72yxqn2z.cloudfront.net/connect_3_9_1_171801_ga/bin/ibm-aspera-connect-3.9.1.171801-linux-g2.12-64.tar.gz

# 安装并添加环境变量
tar -xzf ibm-aspera-connect-3.8.1.161274-linux-g2.12-64.tar.gz  
bash ibm-aspera-connect-3.8.1.161274-linux-g2.12-64.sh
echo "export PATH=~/.aspera/connect/bin:\$PATH ">>~/.bashrc
source ~/.bashrc