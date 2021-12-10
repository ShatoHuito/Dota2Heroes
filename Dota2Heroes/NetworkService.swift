//
//  NetworkService.swift
//  Dota2Heroes
//
//  Created by Golduck Brittany on 12/10/21.
//  Copyright © 2021 Ilnur Mustafin. All rights reserved.
//

import Foundation

typealias DataClosure = (Data) -> Void
typealias HeroListClosure = ([HeroStats]) -> Void

final class NetworkService {
    
    // MARK: - Singletone
    
    private init (){}
    static let shared = NetworkService()
    
    // MARK: - Constants
    
    private enum Constants {
        static let baseUrl = "https://api.opendota.com"
        static let urlHeroStats = "/api/heroStats"
        static let imagePrefix = "image"
        static let successCode = 200
    }
    
    // MARK: - Internal methods
    
    func downloadHeroList(completed: HeroListClosure?) {
        guard let url = URL(string: Constants.baseUrl + Constants.urlHeroStats) else {
            return
        }
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    do {
                        guard let data = data else {
                            return
                        }
                        let heroList = try JSONDecoder().decode([HeroStats].self, from: data)
                        DispatchQueue.main.async {
                            completed?(heroList)
                        }
                    } catch {
                        print("Error")
                    }
                }
            }.resume()
        }
    }
    
    func downloadImage(url: String, completion: DataClosure?) {
        guard let url = URL(string: Constants.baseUrl + url) else {
            return
        }
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse,
                    httpURLResponse.statusCode == Constants.successCode,
                    let mimeType = response?.mimeType,
                    mimeType.hasPrefix(Constants.imagePrefix),
                    let data = data,
                    error == nil
                else {
                    return
                }
                DispatchQueue.main.async {
                    completion?(data)
                }
            }.resume()
        }
    }
}
