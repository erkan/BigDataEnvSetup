#!/bin/bash
user=data
HADOOP_VERSION=3.1.0
SPARK_VERSION=2.3.0
ZOOKEEPER_VERSION=3.4.12
KAFKA_VERSION=1.1.0
SCALA_VERSION=2.12
AMBARI_VERSION=2.6.1.5
RSTUDIO_VERSION=1.1.447
ANACONDA2_VERSION=5.1.0
ANACONDA3_VERSION=5.1.0
TENSORFLOW_VERSION=1.8.0
wget http://ftp.itu.edu.tr/Mirror/Apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
sleep 2
wget http://ftp.itu.edu.tr/Mirror/Apache/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz
sleep 2
wget http://ftp.itu.edu.tr/Mirror/Apache/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz
sleep 2
wget http://ftp.itu.edu.tr/Mirror/Apache/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz
sleep 2
wget -O /etc/apt/sources.list.d/ambari.list http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/$AMBARI_VERSION/ambari.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
apt-get update
apt-cache showpkg ambari-server
apt-cache showpkg ambari-agent
apt-cache showpkg ambari-metrics-assembly
apt-get install -y ambari-server
tar -xzvf hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/
tar -xzvf spark-$SPARK_VERSION-bin-hadoop2.7.tgz -C /usr/local/
tar -xzvf zookeeper-$ZOOKEEPER_VERSION.tar.gz -C /usr/local/
tar -xzvf kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz -C /usr/local/

sleep 2

# Install R + RStudio on Ubuntu 16.04

sudo apt-key adv –keyserver keyserver.ubuntu.com –recv-keys E084DAB9

# Ubuntu 16.04: xenial
# Basic format of next line deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu <enter your ubuntu version>/
sudo add-apt-repository 'deb http://cran.ncc.metu.edu.tr/bin/linux/ubuntu xenial/'
sudo apt-get update
sudo apt-get install -y --allow-unauthenticated r-base
sudo apt-get install -y --allow-unauthenticated r-base-dev

# Download and Install RStudio
sudo apt-get install -y gdebi-core
wget https://download1.rstudio.org/rstudio-$RSTUDIO_VERSION-amd64.deb
yes | sudo gdebi rstudio-$RSTUDIO_VERSION-amd64.deb
rm rstudio-$RSTUDIO_VERSION-amd64.deb

#Optional:
#Set Default Python to 3.5:

#sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

#if [[ $(sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1) ]]; then
#    echo "Python2.7 set edilemedi!"
#fi
#sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.5 2
#if [[ $(sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.5 2) ]]; then
#    echo "Python3.5 set edilemedi!!"
#else
#    echo "Default Python versiyonu 3.5 olarak set edildi."
#fi

#Python ML Packages:

sudo apt-get -y install python3-apport
sudo apt-get -f -y install build-essential libssl-dev libffi-dev python-dev
sudo apt-get -f -y install python-pip
sudo pip install --upgrade pip
sudo apt-get -y install python3-pip
sudo pip3 install --upgrade pip
sudo pip install --upgrade jupyter matplotlib numpy pandas scipy scikit-learn
sudo pip3 install --upgrade jupyter matplotlib numpy pandas scipy scikit-learn 

#Anaconda and Tensorflow Installation:

wget https://repo.anaconda.com/archive/Anaconda2-$ANACONDA2_VERSION-Linux-x86_64.sh
bash Anaconda2-$ANACONDA2_VERSION-Linux-x86_64.sh
wget https://repo.anaconda.com/archive/Anaconda3-$ANACONDA3_VERSION-Linux-x86_64.sh
bash Anaconda3-$ANACONDA3_VERSION-Linux-x86_64.sh
export PATH="/home/$user/anaconda2/bin:$PATH"
conda create -n tensorflow pip python=2.7
source activate tensorflow
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-$TENSORFLOW_VERSION-cp27-none-linux_x86_64.whl
export PATH="/home/$user/anaconda3/bin:$PATH"
conda create -n tensorflow3 pip python=3.6
source activate tensorflow3
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-$TENSORFLOW_VERSION-cp36-cp36m-linux_x86_64.whl
