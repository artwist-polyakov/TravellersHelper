//
//  PathRouter.swift
//  Rzhd
//
//  Created by Александр Поляков on 25.06.2024.
//

import Foundation

final class PathRouter: ObservableObject, @unchecked Sendable {
    static let shared = PathRouter()
    @Published var path: [NavigationIdentifiers] = []
    private let lock = NSLock()
    
    
    func pushPath(_ identifier: NavigationIdentifiers) -> Void {
        lock.lock()
        defer { lock.unlock() }
        path.append(identifier)
    }
    
    func popPath() -> Void {
        lock.lock()
        defer { lock.unlock() }
        path.removeLast()
    }
    
    func removeAll() -> Void {
        lock.lock()
        defer { lock.unlock() }
        path.removeAll()
    }
    
    func isEmpty() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return path.isEmpty
    }
}
