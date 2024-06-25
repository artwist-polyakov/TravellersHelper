//
//  PathRouter.swift
//  Rzhd
//
//  Created by Александр Поляков on 25.06.2024.
//

import Foundation

final class PathRouter: ObservableObject {
    static let shared = PathRouter()
    @Published var path: [NavigationIdentifiers] = []
    
    
    func pushPath(_ identifier: NavigationIdentifiers) -> Void {
        path.append(identifier)
    }
    
    func popPath() -> Void {
        path.removeLast()
    }
    
    func removeAll() -> Void {
        path.removeAll()
    }
    
    func isEmpty() -> Bool {
        return path.isEmpty
    }
}
