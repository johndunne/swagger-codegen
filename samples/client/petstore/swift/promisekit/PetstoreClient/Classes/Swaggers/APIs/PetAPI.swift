//
// PetAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire
import PromiseKit



open class PetAPI: APIBase {
    /**
     Add a new pet to the store
     
     - parameter body: (body) Pet object that needs to be added to the store (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func addPet(body body: Pet? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        addPetWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Add a new pet to the store
     
     - parameter body: (body) Pet object that needs to be added to the store (optional)
     - returns: Promise<Void>
     */
    open class func addPet(body body: Pet? = nil) -> Promise<Void> {
        let deferred = Promise<Void>.pending()
        addPet(body: body) { error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill()
            }
        }
        return deferred.promise
    }

    /**
     Add a new pet to the store
     - POST /pet
     - 
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     
     - parameter body: (body) Pet object that needs to be added to the store (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func addPetWithRequestBuilder(body body: Pet? = nil) -> RequestBuilder<Void> {
        let path = "/pet"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body?.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**
     Deletes a pet
     
     - parameter petId: (path) Pet id to delete 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deletePet(petId petId: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        deletePetWithRequestBuilder(petId: petId).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Deletes a pet
     
     - parameter petId: (path) Pet id to delete 
     - returns: Promise<Void>
     */
    open class func deletePet(petId petId: Int64) -> Promise<Void> {
        let deferred = Promise<Void>.pending()
        deletePet(petId: petId) { error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill()
            }
        }
        return deferred.promise
    }

    /**
     Deletes a pet
     - DELETE /pet/{petId}
     - 
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     
     - parameter petId: (path) Pet id to delete 

     - returns: RequestBuilder<Void> 
     */
    open class func deletePetWithRequestBuilder(petId petId: Int64) -> RequestBuilder<Void> {
        var path = "/pet/{petId}"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)", options: .literal, range: nil)
        let URLString = PetstoreClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**
     Finds Pets by status
     
     - parameter status: (query) Status values that need to be considered for filter (optional, default to available)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findPetsByStatus(status status: [String]? = nil, completion: @escaping ((_ data: [Pet]?,_ error: Error?) -> Void)) {
        findPetsByStatusWithRequestBuilder(status: status).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Finds Pets by status
     
     - parameter status: (query) Status values that need to be considered for filter (optional, default to available)
     - returns: Promise<[Pet]>
     */
    open class func findPetsByStatus(status status: [String]? = nil) -> Promise<[Pet]> {
        let deferred = Promise<[Pet]>.pending()
        findPetsByStatus(status: status) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Finds Pets by status
     - GET /pet/findByStatus
     - Multiple status values can be provided with comma separated strings
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - examples: [{contentType=application/json, example={
  "name" : "Puma",
  "type" : "Dog",
  "color" : "Black",
  "gender" : "Female",
  "breed" : "Mixed"
}}]
     
     - parameter status: (query) Status values that need to be considered for filter (optional, default to available)

     - returns: RequestBuilder<[Pet]> 
     */
    open class func findPetsByStatusWithRequestBuilder(status status: [String]? = nil) -> RequestBuilder<[Pet]> {
        let path = "/pet/findByStatus"
        let URLString = PetstoreClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "status": status
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[Pet]>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Finds Pets by tags
     
     - parameter tags: (query) Tags to filter by (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findPetsByTags(tags tags: [String]? = nil, completion: @escaping ((_ data: [Pet]?,_ error: Error?) -> Void)) {
        findPetsByTagsWithRequestBuilder(tags: tags).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Finds Pets by tags
     
     - parameter tags: (query) Tags to filter by (optional)
     - returns: Promise<[Pet]>
     */
    open class func findPetsByTags(tags tags: [String]? = nil) -> Promise<[Pet]> {
        let deferred = Promise<[Pet]>.pending()
        findPetsByTags(tags: tags) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Finds Pets by tags
     - GET /pet/findByTags
     - Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - examples: [{contentType=application/json, example=[ {
  "photoUrls" : [ "aeiou" ],
  "name" : "doggie",
  "id" : 123456789,
  "category" : {
    "name" : "aeiou",
    "id" : 123456789
  },
  "tags" : [ {
    "name" : "aeiou",
    "id" : 123456789
  } ],
  "status" : "aeiou"
} ]}, {contentType=application/xml, example=<Pet>
  <id>123456</id>
  <name>doggie</name>
  <photoUrls>
    <photoUrls>string</photoUrls>
  </photoUrls>
  <tags>
  </tags>
  <status>string</status>
</Pet>}]
     - examples: [{contentType=application/json, example=[ {
  "photoUrls" : [ "aeiou" ],
  "name" : "doggie",
  "id" : 123456789,
  "category" : {
    "name" : "aeiou",
    "id" : 123456789
  },
  "tags" : [ {
    "name" : "aeiou",
    "id" : 123456789
  } ],
  "status" : "aeiou"
} ]}, {contentType=application/xml, example=<Pet>
  <id>123456</id>
  <name>doggie</name>
  <photoUrls>
    <photoUrls>string</photoUrls>
  </photoUrls>
  <tags>
  </tags>
  <status>string</status>
</Pet>}]
     
     - parameter tags: (query) Tags to filter by (optional)

     - returns: RequestBuilder<[Pet]> 
     */
    open class func findPetsByTagsWithRequestBuilder(tags tags: [String]? = nil) -> RequestBuilder<[Pet]> {
        let path = "/pet/findByTags"
        let URLString = PetstoreClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "tags": tags
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[Pet]>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Find pet by ID
     
     - parameter petId: (path) ID of pet that needs to be fetched 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPetById(petId petId: Int64, completion: @escaping ((_ data: Pet?,_ error: Error?) -> Void)) {
        getPetByIdWithRequestBuilder(petId: petId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Find pet by ID
     
     - parameter petId: (path) ID of pet that needs to be fetched 
     - returns: Promise<Pet>
     */
    open class func getPetById(petId petId: Int64) -> Promise<Pet> {
        let deferred = Promise<Pet>.pending()
        getPetById(petId: petId) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Find pet by ID
     - GET /pet/{petId}
     - Returns a pet when ID < 10.  ID > 10 or nonintegers will simulate API error conditions
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - API Key:
       - type: apiKey api_key 
       - name: api_key
     - examples: [{contentType=application/json, example={
  "photoUrls" : [ "aeiou" ],
  "name" : "doggie",
  "id" : 123456789,
  "category" : {
    "name" : "aeiou",
    "id" : 123456789
  },
  "tags" : [ {
    "name" : "aeiou",
    "id" : 123456789
  } ],
  "status" : "aeiou"
}}, {contentType=application/xml, example=<Pet>
  <id>123456</id>
  <name>doggie</name>
  <photoUrls>
    <photoUrls>string</photoUrls>
  </photoUrls>
  <tags>
  </tags>
  <status>string</status>
</Pet>}]
     - examples: [{contentType=application/json, example={
  "photoUrls" : [ "aeiou" ],
  "name" : "doggie",
  "id" : 123456789,
  "category" : {
    "name" : "aeiou",
    "id" : 123456789
  },
  "tags" : [ {
    "name" : "aeiou",
    "id" : 123456789
  } ],
  "status" : "aeiou"
}}, {contentType=application/xml, example=<Pet>
  <id>123456</id>
  <name>doggie</name>
  <photoUrls>
    <photoUrls>string</photoUrls>
  </photoUrls>
  <tags>
  </tags>
  <status>string</status>
</Pet>}]
     
     - parameter petId: (path) ID of pet that needs to be fetched 

     - returns: RequestBuilder<Pet> 
     */
    open class func getPetByIdWithRequestBuilder(petId petId: Int64) -> RequestBuilder<Pet> {
        var path = "/pet/{petId}"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)", options: .literal, range: nil)
        let URLString = PetstoreClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Pet>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**
     Update an existing pet
     
     - parameter body: (body) Pet object that needs to be added to the store (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updatePet(body body: Pet? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        updatePetWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update an existing pet
     
     - parameter body: (body) Pet object that needs to be added to the store (optional)
     - returns: Promise<Void>
     */
    open class func updatePet(body body: Pet? = nil) -> Promise<Void> {
        let deferred = Promise<Void>.pending()
        updatePet(body: body) { error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill()
            }
        }
        return deferred.promise
    }

    /**
     Update an existing pet
     - PUT /pet
     - 
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     
     - parameter body: (body) Pet object that needs to be added to the store (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func updatePetWithRequestBuilder(body body: Pet? = nil) -> RequestBuilder<Void> {
        let path = "/pet"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body?.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**
     Updates a pet in the store with form data
     
     - parameter petId: (path) ID of pet that needs to be updated 
     - parameter name: (form) Updated name of the pet (optional)
     - parameter status: (form) Updated status of the pet (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updatePetWithForm(petId petId: String, name: String? = nil, status: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        updatePetWithFormWithRequestBuilder(petId: petId, name: name, status: status).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Updates a pet in the store with form data
     
     - parameter petId: (path) ID of pet that needs to be updated 
     - parameter name: (form) Updated name of the pet (optional)
     - parameter status: (form) Updated status of the pet (optional)
     - returns: Promise<Void>
     */
    open class func updatePetWithForm(petId petId: String, name: String? = nil, status: String? = nil) -> Promise<Void> {
        let deferred = Promise<Void>.pending()
        updatePetWithForm(petId: petId, name: name, status: status) { error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill()
            }
        }
        return deferred.promise
    }

    /**
     Updates a pet in the store with form data
     - POST /pet/{petId}
     - 
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     
     - parameter petId: (path) ID of pet that needs to be updated 
     - parameter name: (form) Updated name of the pet (optional)
     - parameter status: (form) Updated status of the pet (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func updatePetWithFormWithRequestBuilder(petId petId: String, name: String? = nil, status: String? = nil) -> RequestBuilder<Void> {
        var path = "/pet/{petId}"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)", options: .literal, range: nil)
        let URLString = PetstoreClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "name": name,
            "status": status
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     uploads an image
     
     - parameter petId: (path) ID of pet to update 
     - parameter additionalMetadata: (form) Additional data to pass to server (optional)
     - parameter file: (form) file to upload (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func uploadFile(petId petId: Int64, additionalMetadata: String? = nil, file: URL? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        uploadFileWithRequestBuilder(petId: petId, additionalMetadata: additionalMetadata, file: file).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     uploads an image
     
     - parameter petId: (path) ID of pet to update 
     - parameter additionalMetadata: (form) Additional data to pass to server (optional)
     - parameter file: (form) file to upload (optional)
     - returns: Promise<Void>
     */
    open class func uploadFile(petId petId: Int64, additionalMetadata: String? = nil, file: URL? = nil) -> Promise<Void> {
        let deferred = Promise<Void>.pending()
        uploadFile(petId: petId, additionalMetadata: additionalMetadata, file: file) { error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill()
            }
        }
        return deferred.promise
    }

    /**
     uploads an image
     - POST /pet/{petId}/uploadImage
     - 
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     
     - parameter petId: (path) ID of pet to update 
     - parameter additionalMetadata: (form) Additional data to pass to server (optional)
     - parameter file: (form) file to upload (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func uploadFileWithRequestBuilder(petId petId: Int64, additionalMetadata: String? = nil, file: URL? = nil) -> RequestBuilder<Void> {
        var path = "/pet/{petId}/uploadImage"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)", options: .literal, range: nil)
        let URLString = PetstoreClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "additionalMetadata": additionalMetadata,
            "file": file
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

}
