
#-------------------------------------------------------
# Aim：准备工作，建立好工作目录
# Author：zhangj
# update：2020-05-26
#-------------------------------------------------------

# 这一部分非常非常非常重要，拥有一个优秀的工作习惯比什么都重要

# 进入到个人目录
cd ~/

# 建立数据库目录
mkdir database
# 参考基因组，注意命名习惯！！！
# 数据库名字
# 物种名字
# 参考基因组版本信息
mkdir -p /home/jzhang/database/genome/Ensembl/Homo_sapiens/GRCh38_release95


# 建立软件安装目录
mkdir biosoft

# 建立项目分析目录
mkdir project
cd project
# 注意项目命名习惯：物种-样本数-疾病-分析流程
mkdir Human-16-Asthma-Trans


# 建立数据备份目录
mkdir project_backup
# 哪天备份就在那个日期文件夹，非常有利于项目溯源
mkdir 20200526
# 在project_backup下放一个所有备份数据路径的txt文件，方便快速查找项目
touch zhangj_project_backup_all_20200526_update.xls


# 示例如下
├── biosoft
│   ├── ibm-aspera-connect-3.9.1.171801-linux-g2.12-64.sh
│   ├── ibm-aspera-connect-3.9.1.171801-linux-g2.12-64.tar.gz
│   ├── miniconda3
│   └── Miniconda3-latest-Linux-x86_64.sh
├── database
│   ├── genome
│   └── GEO
├── project
│   └── Human-16-Asthma-Trans
└── project_backup
    ├── 20200528
    └── zhangj_project_backup_all_20200526_update.xls








