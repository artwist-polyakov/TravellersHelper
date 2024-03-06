//
//  ContentView.swift
//  Rzhd
//
//  Created by Александр Поляков on 01.03.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        
        .onAppear {
                     stations()
                 }
    }
    
    func stations() {
             let client = Client(
                 serverURL: try! Servers.server1(),
                 transport: URLSessionTransport()
             )

             let service = RoutesSearchService(
                 client: client,
                 apikey: "3b033964-4652-469c-bcda-c5e26afbc1b4"
             )

//             Task {
//                 do {
//                     let stations = try await service.getNearestStations(lat:
//     59.864177, lng: 30.319163, distance: 50)
//                     print(stations)
//                 } catch {
//                     print("Error fetching stations: \(error)")
//                 }
//             }
        
            Task {
                do {
                    let result = try await service.search(from:"c213", to: "c239", date: "2024-03-08")
                    print(result)
                } catch {
                    print("Error fetching stations: \(error)")
                }
            }
         }
    
}

#Preview {
    ContentView()
}
