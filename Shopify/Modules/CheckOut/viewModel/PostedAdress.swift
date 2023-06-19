import Foundation


struct AllAdresses : Codable{
    
    var addresses : [PostedAdress]?
}

struct UploadAdress:Codable{
    var address : PostedAdress?
    
    init(address:PostedAdress){
        self.address = address
    }
}
struct UpdatedAdressRequest:Codable{
    
    var address : PostedAdress?
    
    init(address: PostedAdress){
        self.address = address
    }
}


struct PostedAdress:Codable ,Equatable{
    
    
    var id           : Int?    = nil
    var customerId   : Int?    = nil
    var firstName    : String? = nil
    var lastName     : String? = nil
    var company      : String? = nil
    var address1     : String? = nil
    var address2     : String? = nil
    var city         : String? = nil
    var province     : String? = nil
    var country      : String? = nil
    var zip          : String? = nil
    var phone        : String? = nil
    var name         : String? = nil
    var provinceCode : String? = nil
    var countryCode  : String? = nil
    var countryName  : String? = nil
    var `default`      : Bool?   = nil

    enum CodingKeys: String, CodingKey {

      case id           = "id"
      case customerId   = "customer_id"
      case firstName    = "first_name"
      case lastName     = "last_name"
      case company      = "company"
      case address1     = "address1"
      case address2     = "address2"
      case city         = "city"
      case province     = "province"
      case country      = "country"
      case zip          = "zip"
      case phone        = "phone"
      case name         = "name"
      case provinceCode = "province_code"
      case countryCode  = "country_code"
      case countryName  = "country_name"
      case `default`      = "default"
    
    }


init(id:Int,name:String,city:String,region:String,countryName:String,phone:String,zip:String){
    self.id = id
    self.zip = zip
    self.name = name
    self.countryName = countryName
    self.phone = phone
    self.city = city
}

    init(name:String,city:String,region:String){
     
      self.city = city
      self.address1 = region
      self.name = name
  }

    init() {

    }

  }

struct AdressResponse : Codable{
    
    var customer_address : PostedAdress?
}



