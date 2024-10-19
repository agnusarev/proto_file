FROM centos

# Set the working directory to /root/cextension
WORKDIR /root/cextension

# Copy the current directory contents into the container at /root/app
COPY . /root/cextension

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update -y
RUN yum -y install epel-release && yum clean all
RUN yum -y install make protobuf protobuf-c protobuf-c-compiler gcc mc \
		   protobuf-c-devel gdb zlib-devel
RUN yum -y install python39
RUN yum -y install python39-devel
RUN python3 -m pip install setuptools
RUN python3 -m pip install -r requirements.txt
ENTRYPOINT ["sh", "/root/cextension/start.sh"]