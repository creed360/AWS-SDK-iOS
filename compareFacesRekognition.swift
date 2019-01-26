//The following function compares face using AWS Rekognition
//The code is written in Swift 4.2.
func compareFacesRekognition(img: UIImage) -> String
    {
        let group=DispatchGroup()
        group.enter()

        let myIdentityPoolId="Enter PoolId here"    
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast, identityPoolId: myIdentityPoolId)
        let configuration = AWSServiceConfiguration(region: .USEast, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        rekognitionClient = AWSRekognition.default()
        
        guard let request = AWSRekognitionSearchFacesByImageRequest() else
        {
            
            puts("Unable to initialize AWSRekognitionSearchfacerequest.")
            return  ("")
        }
        request.collectionId = "Enter Collection Name here"
        request.faceMatchThreshold = 80 //Minimum FaceMatch Threshold
        request.maxFaces = 2    //Max Faces to Identify
        let sourceImage = img
        let image = AWSRekognitionImage()
        var toReturn:String=""
        var s:String=""
        image!.bytes = sourceImage.jpegData(compressionQuality: 0.7)
        request.image = image
        
        var result: AWSRekognitionSearchFacesByImageResponse?
        rekognitionClient.searchFaces(byImage:request) { (response:AWSRekognitionSearchFacesByImageResponse?, error:Error?) in
            if error == nil
            {
                print("No Error in Facematch Request")
                print(response!)
                result=response
                group.leave()
            }
            else
            {
                print("ERROR IN COMPARE FACE")
                print(error!)
                result=response
                toReturn="error"
                group.leave()
                
            }
            
        }
      
        group.wait()
        if(toReturn=="error")
        {
            return toReturn
        }
        if(!(toReturn.contains("error")))
        {
            if((result!.faceMatches?.count)! < 1){
                toReturn=""
            }
            else
            {
                let matches=result!.faceMatches
                toReturn=(matches![0].face?.externalImageId)! //Returns Image Name of the matched image
            }
        }
        return toReturn   
    }
