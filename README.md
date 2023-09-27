# aws-efs-datasync

AWS EFS migration using DataSync and KMS.

A few notes about EFS encryption:

- **KMS CMK** - Only KMS CMK keys are supported; you cannot use AWS managed keys.
- **EFS encryption** - It is not possible to encrypt an existing EFS. You have to migrate the data to a new encrypted EFS.

