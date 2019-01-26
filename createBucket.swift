
//The following function creates a bucket in AWS S3 using AWS SDK for iOS.
//The following code is written in Swift 4.2

 func createBucket(bucketName: String) -> Bool{
        var toReturn=false
        let group=DispatchGroup()
        group.enter()
        let request=AWSS3CreateBucketRequest()
        let s3=AWSS3.default()
        let config=AWSS3CreateBucketConfiguration()
        
        config?.locationConstraint = .usEast2
        request?.createBucketConfiguration=config
        request?.bucket=bucketName
        
        s3.createBucket(request!) { (out: AWSS3CreateBucketOutput?,error: Error?) in
            if(error==nil){
                toReturn=true
                
            }
            group.leave()
        }
        group.wait()
        return toReturn
    }
