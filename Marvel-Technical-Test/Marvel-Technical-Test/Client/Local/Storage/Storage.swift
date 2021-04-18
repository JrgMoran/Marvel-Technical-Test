//
//  Storage.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 17/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation

enum StorageFolder: String, CaseIterable {
    case root = ""
    case images = "images"
}

protocol Storage {
    associatedtype T
    var folder: StorageFolder { get }
    var maxDays: Double { get }
    var maxSecondsInCache: Double { get }
    var downloader: Downloader { get }
    
    init(downloader: Downloader)
    
    func load(from url: String,  completion: @escaping (_ response: Result<T,AppError>) -> Void, ignoreCache: Bool)
    
    func load(from request: URLRequest,  completion: @escaping (_ response: Result<T,AppError>) -> Void, ignoreCache: Bool)
    
    func deleteAll()
}

extension Storage {
    var maxSecondsInCache: Double { return maxDays * 24 * 60 * 60 }
    
    func load(from request: URLRequest,  completion: @escaping (_ response: Result<Data,AppError>) -> Bool, ignoreCache: Bool) {
        if let data = getSavedData(url: request.url), !ignoreCache {
            if !completion(Result.success(data)){
                delete(url: request.url)
            }
        } else {
            downloader.execute(with: request) { (result) in
                if let data = try? result.get() {
                    save(data: data, url: request.url)
                }
                
                if !completion(result){
                    delete(url: request.url)
                }
            }
        }
    }
    
    //MARK: - Save methods
    @discardableResult
    private func save(data: Data, url: URL?) -> Bool {
        guard let path = createPath(from: url), let directory = self.directory else {
            return false
        }
        
        let dirPath = directory.appendingPathComponent(folder.rawValue)
        do {
            try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch { }
        
        do {
            let urlpath = directory.appendingPathComponent(path)
            try data.write(to: urlpath)
            print("💾 element saved: \(urlpath)")
            return true
        } catch {
            print("💾 error in element saved: \(error.localizedDescription)")
            return false
        }
    }
    
    //MARK: - load methods
    private func getSavedData(url: URL?) -> Data? {
        if let named = createPath(from: url), let directory = self.directory {
            let url = URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(named)
            
            if let dateFile = fileModificationDate(url: url), dateFile.addingTimeInterval(TimeInterval(maxSecondsInCache)) > Date(){
                let data = try? Data(contentsOf: url)
                print("💾 element loaded: \(url.path)")
                return data
            } else {
                delete(local: url)
            }
            
        }
        return nil
    }
    
    //MARK: - Delete methods
    func deleteAll() {
        
    }
    
    func delete(url: URL?) {
        if let named = createPath(from: url), let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            let url = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named)
            delete(local: url)
        }
    }
    
    private func delete(local url: URL){
        do {
            try FileManager.default.removeItem(at: url)
            print("💾 delete: \(url.path)")
        } catch let error as NSError {
            print("💾 Error: \(error.domain)")
        }
    }
    
    
    //MARK: - helpers methods
    private func createPath(from url: URL?) -> String?{
        guard let url = url else { return nil }
        var urlString: String? = url.absoluteString
        urlString = urlString?.replacingOccurrences(of: "/", with: "")
        urlString = urlString?.replacingOccurrences(of: ":", with: "")
        if var urlSplit = urlString?.split(separator: ".").map({String($0)}), urlSplit.count > 2 {
            let ext = urlSplit.removeLast()
            let name = urlSplit.joined().replacingOccurrences(of: ".", with: "")
            return "\(folder)/\(name).\(ext)"
        }
        return nil
    }
    
    private var directory: URL? {
        return try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    private func fileModificationDate(url: URL) -> Date? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            return attr[FileAttributeKey.modificationDate] as? Date ?? attr[FileAttributeKey.creationDate] as? Date
        } catch {
            return nil
        }
    }
}
