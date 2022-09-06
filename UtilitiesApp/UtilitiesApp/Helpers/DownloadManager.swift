//
//  DownloadManager.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 23.06.2022.
//

import Foundation

struct DownloadManager {

    static func getObject<T>(ofType type: T.Type, fromURL url: URL?, completion: @escaping (_ success: Bool, _ object: T?) -> Void) where T: Codable {
        getData(fromURL: url) { success, data in
            if success, let data = data {
                var object: T?
                do {
                    object = try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print("failed to decode")
                }
                if let object = object {
                    completion(true, object)
                } else {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }
    }

    private static func getData(fromURL url: URL?, completion: @escaping (_ success: Bool, _ data: Data?) -> Void) {
        guard let url = url else { return }
        let task = task(withURL: url, completion: completion)
        task.resume()
    }

    private static func task(withURL url: URL, completion: @escaping (_ success: Bool, _ data: Data?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                completion(false, nil)
                return
            }
            completion(true, data)
        }
        return task
    }

}
