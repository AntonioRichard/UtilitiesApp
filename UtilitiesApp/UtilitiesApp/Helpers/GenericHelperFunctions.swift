//
//  GenericHelperFunctions.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 22.06.2022.
//

import Foundation

//MARK: - UserDefaults

func loadObject<T>(fromUserDefaultsKey key: String) -> T? where T: Decodable {
    var object: T?
    if let objectData = UserDefaults.standard.value(forKey: key) as? Data {
        object = decodeObject(fromData: objectData)
    }
    return object
}

func loadObjects<T>(fromUserDefaultsKey key: String) -> [T] where T: Decodable {
    var objects = [T]()
    if let objectsData = UserDefaults.standard.value(forKey: key) as? Data {
        objects = decodeObjects(fromData: objectsData)
    }
    return objects
}

func saveObject<T>(_ object: T, atKey key: String) where T: Encodable {
    let data = encodeObject(object)
    UserDefaults.standard.set(data, forKey: key)
}

func saveObjects<T>(_ objects: [T], atKey key: String) where T: Encodable {
    let data = encodeObjects(objects)
    UserDefaults.standard.set(data, forKey: key)
}

//MARK: - Decodable

fileprivate func decodeObject<T>(fromData data: Data) -> T? where T: Decodable {
    var object: T?
    do {
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        object = decodedObject
    } catch {}
    return object
}

fileprivate func decodeObjects<T>(fromData data: Data) -> [T] where T: Decodable {
    var objects = [T]()
    do {
        let decodedObjects = try JSONDecoder().decode([T].self, from: data)
        objects = decodedObjects
    } catch {}
    return objects
}

//MARK: - Encodable

fileprivate func encodeObject<T>(_ object: T) -> Data? where T: Encodable {
    var data: Data?
    do {
        let encodedData = try JSONEncoder().encode(object)
        data = encodedData
    } catch {}
    return data
}

fileprivate func encodeObjects<T>(_ objects: [T]) -> Data? where T: Encodable {
    var data: Data?
    do {
        let encodedData = try JSONEncoder().encode(objects)
        data = encodedData
    } catch {}
    return data
}
