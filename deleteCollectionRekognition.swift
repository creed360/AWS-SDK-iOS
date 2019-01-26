
//The function deletes Collection from Collections in AWS Rekognition
//The code is written in Swift 4.2
func deleteCollectionRekognition()
    {
        let group=DispatchGroup()
        group.enter()
        let myIdentityPoolId="Enter PoolID here"   
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USWest, identityPoolId: myIdentityPoolId)
        let configuration = AWSServiceConfiguration(region: .USWest, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        rekognitionClient = AWSRekognition.default()
        guard let request = AWSRekognitionDeleteCollectionRequest() else
        {
            puts("Unable to initialize AWSRekognitionCreateCollectionRequest.")
            return
        }
        request.collectionId = "ID of Collection to be deleted"
        rekognitionClient.deleteCollection(request) { (response:AWSRekognitionDeleteCollectionResponse?, error:Error?) in
            if error == nil
            {
                print("Delete Collection Successful")
            }
            group.leave()
        }
        group.wait()
    }
