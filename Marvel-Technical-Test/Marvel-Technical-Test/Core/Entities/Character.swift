//
//  Character.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 16/4/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: ItemType
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: ThumbnailExtension
    
    var urlStr: String {
        "\(path).\(thumbnailExtension.rawValue)"
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ThumbnailExtension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
