//
//  NetworkService.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func login(username: String, password: String, completion: @escaping (Result<Data, Error>) -> Void)
    func fetchDashboard(completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func login(username: String, password: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let loginString = "\(username):\(password)"
        let loginData = loginString.data(using: .utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let parameters = [
            "service[0][name]": "login",
            "service[0][attributes][login]": username,
            "service[0][attributes][password]": password,
            "service[1][name]": "customer_navbar"
        ]
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = ""
        for (key, value) in parameters {
            body += "--\(boundary)\r\n"
            body += "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
            body += "\(value)\r\n"
        }
        body += "--\(boundary)--\r\n"
        request.httpBody = body.data(using: .utf8)
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
    
    func fetchDashboard(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters = [
            "service[0][name]": "customer_dashboard",
            "service[1][name]": "my_profile",
            "service[2][name]": "my_new_notifications",
            "service[2][attributes][mode]": "private"
        ]
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = ""
        for (key, value) in parameters {
            body += "--\(boundary)\r\n"
            body += "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
            body += "\(value)\r\n"
        }
        body += "--\(boundary)--\r\n"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
