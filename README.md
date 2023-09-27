# aws-efs-datasync

AWS EFS migration using DataSync and KMS.

A few notes about EFS encryption:

- **KMS CMK** - Only KMS CMK keys are supported; you cannot use AWS managed keys.
- **EFS encryption** - It is not possible to encrypt an existing EFS. You have to migrate the data to a new encrypted EFS.


```sh
terraform init
terraform apply -auto-approve
```

After the infrastructure is provisioned, [mount the NFS][1] for the unencrypted EFS:

```sh
# Make a directory ("efs-mount-point")
mkdir ~/efs-mount-point

# Make a directory ("efs-mount-point"). Replace "mount-target-DNS"
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport mount-target-DNS:/   ~/efs-mount-point
```

[1]: https://docs.aws.amazon.com/efs/latest/ug/wt1-test.html
