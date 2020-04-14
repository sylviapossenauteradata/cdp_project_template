USER_NAME="$(klist | sed -n 's/.*principal://p' | cut -d/ -f1)"
echo "Your user name is: $USER_NAME"

REALM=$(klist | sed -n 's/.*principal://p' | cut -d@ -f2)
echo "Your KDC realm is: $REALM"

#provide rest of hdfs master url
ENV_HDFSMASTER_PREFIX="tst-env-public-lake-master1"

REMOTE_HDFS_MASTER="${ENV_HDFSMASTER_PREFIX}.${REALM,,}"
echo "The HDFS remote master is: $REMOTE_HDFS_MASTER"

#create dir to store hadoop conf setting files
mkdir -p ~/conf

scp -o "StrictHostKeyChecking no" -T $USER_NAME@$REMOTE_HDFS_MASTER:"/etc/hadoop/conf/core-site.xml /etc/hadoop/conf/hdfs-site.xml" ~/conf

#copy to hadoop conf
cp ~/conf/*site.xml /etc/hadoop/conf