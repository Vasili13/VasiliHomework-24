//
//  ApiConstants.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 27.12.22.
//

import Foundation

class ApiConstants {
    
    // Local server
    static let serverPath = "http://localhost:3000/"
    
    // posts
    static let postsPath = serverPath + "posts"
    static let postsPathURL = URL(string: postsPath)
    
    // comments
    static let commentsPath = serverPath + "comments"
    static let commentsPathURL = URL(string: commentsPath)
    
    // albums
    static let albumsPath = serverPath + "albums"
    static let albumsPathURL = URL(string: albumsPath)
    
    // photos
    static let photosPath = serverPath + "photos"
    static let photosPathURL = URL(string: photosPath)
}
