//
//  NetworkManager.swift
//  insultApp
//
//  Created by Roman on 15.11.23.
//

import Foundation

let insultURL = URL(string: "https://evilinsult.com/generate_insult.php?lang=en&type=json")!

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // метод с использованием Result дженерик перечисление кооторе помогает обрабатывать ошибки
    //Общий совет - использовать Result в функциях с возможностью возврата ошибок, чтобы код был более понятным и безопасным.
    //, предоставляет более гибкий и информативный способ обработки ошибок. Он использует тип Result, который позволяет вам передавать как успешные результаты, так и ошибки внутри одного объекта. Это улучшает читаемость и обработку ошибок в вашем коде.
    // Перечисление Дата и мой enum NetworkError (удовлетворяет условию тк подписан под пр Error
    // Result дженерик и мы в его case можем положить любой тип данных
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData)) // можем захватить ошибку
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    // классический метод для фетча изображения
    //  @escaping значит дата прийдет с задержкой
    // в замыкании дата захватывается которую можно дальше куданибудь пихнуть
    // в фоновом потоке загружаем дату
    // в основном потоке пихаем ее в Ui
    // Отпускать дату уже в применении метода
    func fetchImage(from url: URL, completion: @escaping(Data) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
    
    // Классический метод достать дату на примере оскорбления
    func fetchInsult() {
        let insultUrl = URL(string: "https://evilinsult.com/generate_insult.php?lang=en&type=json")!
        
        URLSession.shared.dataTask(with: insultUrl) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? " No error description")
                return
            }
            let decoder = JSONDecoder()
            do {
                let insult = try decoder.decode(Insult.self, from: data)
                print(insult)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    //Дженерик метод достать дату
    // Подписываю под кодэбл прям тут
    //
    
    func fetch<T: Codable>(type: T.Type, request: URLRequest, completion: @escaping(Result<T, NetworkError>)-> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
                
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
     
    
    
    
    
    
}
