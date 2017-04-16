/* DO NOT EDIT | Generated by gyro */

import RealmSwift

final class Shop: Object {

  enum Attributes: String {
    case name = "name"
  }

  enum Relationships: String {
    case owner = "owner"
    case products = "products"
  }

  dynamic var ignored: String = ""
  dynamic var name: String = ""
  dynamic var owner: Owner?
  let products = List<Product>()

  // Specify properties to ignore (Realm won't persist these)
  override static func ignoredProperties() -> [String] {
    return ["ignored"]
  }

}
