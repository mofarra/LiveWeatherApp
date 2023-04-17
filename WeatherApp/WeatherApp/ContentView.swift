//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mohamad Alfarra on 2/6/23.
//

//import SwiftUI
import SwiftUI

struct WeatherResponse: Codable {
    let main: Main
}

struct Main: Codable {
    let temp: Double
}

struct ContentView: View {
    @State var temperature: Int = 0
    
    func getWeather() {
        let apiKey = "652dd3633130457ebf48f7145e3e81e3"
        let latitude = 30.627977
        let longitude = -96.33440680000001
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    let temperatureInFahrenheit = Int((weatherResponse.main.temp - 273.15) * 9/5 + 32)
                    self.temperature = temperatureInFahrenheit
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Image("clearday")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                HStack {
                    Text("Weather in C-Stat")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                        .padding()
                    
                    Text("\(temperature)ºF")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                        .padding()
                }
                
                Spacer()
                
                Text("Maybe: have lunch with Sebastian")
                    .font(.largeTitle)
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
                    .padding()
                    .italic()
                
                Spacer()
            }
        }
        .onAppear {
            self.getWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


