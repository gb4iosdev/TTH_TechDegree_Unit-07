//
//  User.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct UserSelection {
    
    //User 1 selections
    static private var user1Genres = Set<Int>()
    static private var user1Certification: Certification?
    static private var user1Actors = Set<Int>()
    
    //User 2 selections
    static private var user2Genres = Set<Int>()
    static private var user2Certification: Certification?
    static private var user2Actors = Set<Int>()
    
    //Selection Status trackers
    static private var user1Done: Bool?
    static private var user2Done: Bool?
    
    //Assign entity ID’s to the corresponding stored property for the right user
    static func update(for user: User, genres: [Int]? = nil, certification: Certification? = nil, actors: [Int]? = nil) {
        switch user {
        case .user1:
            if let genres = genres { user1Genres = Set(genres) }
            if let certification = certification { user1Certification = certification }
            if let actors = actors { user1Actors = Set(actors) }
        case .user2:
            if let genres = genres { user2Genres = Set(genres) }
            if let certification = certification { user2Certification = certification }
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
    
    //Return true if user has completed their selection cycle.
    static func doneForUser(_ user: User) -> Bool {
        switch user {
        case .user1: return user1Done ?? false
        case .user2: return user2Done ?? false
        }
    }
    
    //Remove selections for both users & reset selection status
    static func emptySelections() {
        user1Genres.removeAll()
        user1Certification = nil
        user1Actors.removeAll()
        user2Genres.removeAll()
        user2Certification = nil
        user2Actors.removeAll()
        user1Done = false
        user2Done = false
    }
    
    static func combinedGenres() -> String? {
        //Return a string with comma separated genre ID’s (or nil if no selections) for use in the endpoint query item
        let combinedSet = user1Genres.union(user2Genres)
        if combinedSet.count == 0 {
            return nil
        } else {
            return combinedSet.map{ String($0) }.joined(separator: ",")
        }
    }
    
    static func combinedActors() -> String? {
        //Return a string with comma separated actor ID’s (or nil if no selections) for use in the endpoint query item
        let combinedSet = user1Actors.union(user2Actors)
        if combinedSet.count == 0 {
            return nil
        } else {
            return combinedSet.map{ String($0) }.joined(separator: ",")
        }
    }
    
    static func hightestCommonCertification() -> String? {
        //If both users selected use the minimum
        if user1Certification != nil && user2Certification != nil {
            return user1Certification!.order < user2Certification!.order ? user1Certification!.name : user2Certification!.name
        }
        //If only one user selected, use that one
        if user1Certification != nil { return user1Certification!.name }
        if user2Certification != nil { return user2Certification!.name }
        
        //If neither user selected, return nil
        return nil
    }

    
}
