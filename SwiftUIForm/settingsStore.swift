//
//  settingsStore.swift
//  SwiftUIForm
//
//  Created by Jesus on 15/4/24.
//

import Foundation
enum DisplayOrderType: Int, CaseIterable {
    case alphabetical = 0
    case favoriteFirst = 1
    case checkInFirst = 2
    init(type: Int) {
        switch type {
        case 0: self = .alphabetical
        case 1: self = .favoriteFirst
        case 2: self = .checkInFirst
        default: self = .alphabetical
        }
}
    var text: String {
        switch self {
        case .alphabetical: return "Alphabetical"
        case .favoriteFirst: return "Show Favorite First"
        case .checkInFirst: return "Show Check-in First"
            
        }
    }
    }


final class SettingStore: ObservableObject {
    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.showCheckInOnly" : false,
            "view.preferences.displayOrder" : 0,
            "view.preferences.maxPriceLevel" : 5

        ])
        
    }
    
    //ACCESO A DATOS BOOLEANOS
    //ACCESO A DASTOS COMPLEJOS
    //ACCESO A ENTEROS
    //ACCESO A STRING
    
    // esto es un booleano
    var showCheckInOnly: Bool = UserDefaults.standard.bool(forKey: "view.preferenc es.showCheckInOnly") {
                didSet {
                    // lo azul es lo que hay en la mini bases de datos y lo que queremos es que lo guarde en lo rojo
                    // para la llave esta guarda el valor que hay en lo azul ( esto es como un mapa clave valor
                    UserDefaults.standard.set(showCheckInOnly, forKey: "view.preferences.showCheckInOnly")
        }
    }
    
    // para ver que orden a elegido el usuario que es de tipo displayordertyoe
    // aqui accede al enum por lo que es un objeto complejo y se necesitara el .rawvalue para no coger su hascode
    var displayOrder: DisplayOrderType = DisplayOrderType(type: UserDefaults.standard.integer(forKey: "view.preferences.displayOrder")) {
        
            didSet {
    
    // ponemos el rawvalue porque sino cogeria el hascode
UserDefaults.standard.set(displayOrder.rawValue, forKey: "view.preferences.displayOrder")
        }
}
    
    // crea la variable si lo has encontrado es un entero es distinto a lo de arriba
    // si fuera un string seria string y luego el userdefaults.standard.string
    var maxPriceLevel: Int = UserDefaults.standard.integer(forKey: "view.preferenc es.maxPriceLevel") {
    
    // aqui no ponemos el .rawvalue porque es un entero
    
            didSet {
            UserDefaults.standard.set(maxPriceLevel, forKey: "view.preferences.maxPriceLevel")
            }
} }
