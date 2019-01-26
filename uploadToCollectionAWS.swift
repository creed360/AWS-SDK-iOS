//upload Image to AWS Collection for AWS Rekognition
//The code is written in Swift 4.2.
    func uploadToCollectioAWS(img: UIImage)
    {
        let group=DispatchGroup(img: UIImage)
        group.enter()
        let myIdentityPoolId="Enter your Pool Id here"
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USWest, identityPoolId: myIdentityPoolId)
        //store photo in s3()
        let configuration = AWSServiceConfiguration(region: .USWest, credentialsProvider: credentialsProvider)

        AWSServiceManager.default().defaultServiceConfiguration = configuration
        rekognitionClient = AWSRekognition.default()
        
        guard let request = AWSRekognitionIndexFacesRequest() else
        {
            puts("Unable to initialize AWSRekognitionindexFaceRequest.")
            return
        }
        request.collectionId = "Name for Collection here"
        request.detectionAttributes = ["ALL", "DEFAULT"]
        request.externalImageId = "Name/ID for image here"
        let sourceImage = img
        let image = AWSRekognitionImage()
        image!.bytes = sourceImage.jpegData(compressionQuality: 0.7)
        request.image = image
        self.rekognitionClient.indexFaces(request) { (response:AWSRekognitionIndexFacesResponse?, error:Error?) in
            if error == nil
            {
                print("Upload to Collection Complete")
            }
            group.leave()
            return
        }
        group.wait()
    }
