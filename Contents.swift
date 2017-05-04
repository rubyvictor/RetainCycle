//: Playground - noun: a place where people can play

import UIKit

class Person {
    let name: String
    var apartment: Apartment?
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }

}


class Apartment {
    let number: Int
    weak var tenant: Person?
    
    init(number: Int) {
        self.number = number
    }
    
    deinit {
        print("Apartment \(number) is being deinitialized")
    }
}

//Earlier version did not have retain cycle as the variable tenant was made 'weak' and name variable was deinitialized from line 11 above
//var bob: Person? = Person(name: "Bob")
//
//let apt = Apartment(number: 123)
//apt.tenant = bob
//
//bob = nil

var bob: Person? = Person(name: "Bob")
var apt: Apartment? = Apartment(number: 234)
apt?.tenant = bob
bob?.apartment = apt

// Now Bob does not print out the deinitialized.  Because Apartment is holding on to a STRONG reference to bob.
bob = nil
apt = nil

// Then these 2 steps
// First, add deinit into Apartment as well
// Next, apt = nil
// At this point still NO retain cycle

// Introduce retain cycle by:
// Add new property apartment in Person
// Then set bob.apartment = apt
// But setting both bob and apt properties to NIL does not correctly deinitalize these two references. because kept in memory and can't reclaim memory. apartment is currently holding a reference of bob and bob is holding reference of apartment. Hence a retain cycle.

// Now break the retain cycle by using 'weak' variable in apartment. This means we are not increasing the reference count on the property