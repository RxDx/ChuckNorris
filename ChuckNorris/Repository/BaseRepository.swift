//
//  BaseRepository.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 11/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

import Foundation

class BaseRepository {

    typealias Then<T: Decodable> = (T?, Error?) -> ()

    let baseUrl = "https://api.chucknorris.io"
    var path = ""
    var fullUrl: String {
        return "\(baseUrl)/\(path)"
    }

    init(path: String = "") {
        self.path = path
    }

    func get<T: Decodable>(url: String? = nil, then: @escaping Then<T>) {
        guard let url = URL(string: url ?? fullUrl) else {
            return
        }

        debugPrint("URL REQUEST: \(url)")
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            debugPrint("URL RESPONSE: \(String(describing: urlResponse?.url?.absoluteString))")
            DispatchQueue.main.async {
                guard let data = data else {
                    then(nil, error)
                    debugPrint(error?.localizedDescription ?? "unknown error")
                    dump(error)
                    return
                }
                let object = try? JSONDecoder().decode(T.self, from: data)
                dump(object)
                then(object, error)
            }
        }.resume()
    }
}
