/* DO NOT EDIT | Generated by gyro */

import RealmSwift

final class Dog: Object {

  enum Attributes: String {
    case age = "age"
    case name = "name"
  }

  dynamic var age: Int16 = 0
  dynamic var name: String = ""
	
  let owners = LinkingObjects(fromType: Person.self, property: "dogs")
  var owner: Person? { return owners.first }

}
