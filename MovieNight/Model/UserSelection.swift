//
//  User.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct UserSelection {
    
    static private var user1Genres: Set<Int>?
    static private var user1Certifications: [CertificationEntity]?
    static private var user1Actors: Set<Int>?
    
    static private var user2Genres: Set<Int>?
    static private var user2Certifications: [CertificationEntity]?
    static private var user2Actors: Set<Int>?
    
    static private var user1Done: Bool?
    static private var user2Done: Bool?
    
    static func update(for user: User, genres: [Int]? = nil, certifications: [CertificationEntity]? = nil, actors: [Int]? = nil) {
        switch user {
        case .user1:
            if let genres = genres { user1Genres = Set(genres) }
            if let certifications = certifications { user1Certifications = certifications }
            if let actors = actors { user1Actors = Set(actors) }
        case .user2:
            if let genres = genres { user2Genres = Set(genres) }
            if let certifications = certifications { user2Certifications = certifications }
            if let actors = actors { user2Actors = Set(actors) }
        }
    }
    
    //Set to true when user has completed their cycle
    static func setUserDone(_ user: User) {
        switch user {
        case .user1: user1Done = true
        case .user2: user2Done = true
        }
    }
    
    
    static func doneForUser(_ user: User) -> Bool {
        switch user {
        case .user1: return user1Done ?? false
        case .user2: return user2Done ?? false
        }
    }
    
    static func emptySelections() {
        user1Genres = nil
        user1Certifications = nil
        user1Actors = nil
        user2Genres = nil
        user2Certifications = nil
        user2Actors = nil
        user1Done = false
        user2Done = false
    }
    
    static func combinedGenres() -> String? {
        guard let user1Genres = self.user1Genres, let user2Genres = self.user2Genres else { return nil }
        
        let combinedSet = user1Genres.union(user2Genres)
        return combinedSet.map{ String($0) }.joined(separator: ",")
    }
    
    static func hightestCommonCertification() -> String? {
        //Guard statement here checking if there are any selections...
        
        //Determine max and min heights
        let user1SortedCertifications = user1Certifications?.sorted(by: { $0.order < $1.order })
        
        return ""
    }
    
}
