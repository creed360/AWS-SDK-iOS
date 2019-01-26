    
//The function lists all Collections in AWS Rekognition
//The code is written in Swift 4.2
    func listCollectionRekognition() {
        let group=DispatchGroup()
        group.enter()
        let myIdentityPoolId="Enter PoolID here"
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USWest, identityPoolId: myIdentityPoolId)
        let configuration = AWSServiceConfiguration(region: .USWest, credentialsProvider: credentialsProvider)
        
        var results:[String]=[]
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        rekognitionClient = AWSRekognition.default()
        let limit: NSNumber=10
        let listreq=AWSRekognitionListCollectionsRequest()
        let res=AWSRekognitionListCollectionsResponse()
        let response=rekognitionClient.listCollections(listreq!).continueOnSuccessWith { (task: AWSTask<AWSRekognitionListCollectionsResponse>) -> Any? in
            
            if (task.result==nil)
            {
                print(task.error)
                print("Error")
                
            }
            else
            {
                results=(task.result?.collectionIds)!
            }
            group.leave()
            return nil

        }
        group.wait()
        print(results) //prints all collections in Rekognition
    }
