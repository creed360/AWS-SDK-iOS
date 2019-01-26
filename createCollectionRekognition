//The function creates Collection for AWS Rekognition
//The code is written in Swift 4.2
func createCollectionRekognition()
    {
        let group=DispatchGroup()
        group.enter()
        let myIdentityPoolId="Enter PoolID here"
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USWest, identityPoolId: myIdentityPoolId)
        let configuration = AWSServiceConfiguration(region: .USWest, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        rekognitionClient = AWSRekognition.default()
        guard let request = AWSRekognitionCreateCollectionRequest() else
        {
            puts("Unable to initialize AWSRekognitionCreateCollectionRequest.")
            return
        }
        request.collectionId = "Enter collectionID here"
        rekognitionClient.createCollection(request) { (response:AWSRekognitionCreateCollectionResponse?, error:Error?) in
            if error == nil
            {
                print("Create Collection")
            }
            group.leave()
        }
        group.wait()
    }
