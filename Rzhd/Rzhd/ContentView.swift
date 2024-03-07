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
            allStations()
//                    stations()
//                    thread()
//            settlement()
//            carrier()
                 }
    }
    
    func allStations() {
        
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )

        let service = AllStationsService(
            client: client,
            apikey: "3b033964-4652-469c-bcda-c5e26afbc1b4"
        )

        Task {
            do {
                let stations = try await service.get()
                print(stations)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func carrier() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )

        let service = CarrierSearchService(
            client: client,
            apikey: "3b033964-4652-469c-bcda-c5e26afbc1b4"
        )

        Task {
            do {
                let thread = try await service.search(code: "MS", system: .iata)
                print(thread)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    func thread() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )

        let service = ThreadSearchService(
            client: client,
            apikey: "3b033964-4652-469c-bcda-c5e26afbc1b4"
        )

        Task {
            do {
                let thread = try await service.search(uid: "176YE_7_2")
                print(thread)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    func stations() {
             let client = Client(
                 serverURL: try! Servers.server1(),
                 transport: URLSessionTransport()
             )

             let service = ScheduleSearchService(
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
                    let result = try await service.search(station: "s9600216", date: "2024-03-08")
                    print(result)
                } catch {
                    print("Error fetching stations: \(error)")
                }
            }
         }
    func settlement() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )

        let service = NearestSettlementService(
            client: client,
            apikey: "3b033964-4652-469c-bcda-c5e26afbc1b4"
        )

        Task {
            do {
                let result = try await service.getNearestSSettlement(lat:59.864177, lng: 30.319163)
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
