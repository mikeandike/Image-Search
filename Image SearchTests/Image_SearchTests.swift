//
//  Image_SearchTests.swift
//  Image SearchTests
//
//  Created by Michael Sacks on 1/9/19.
//  Copyright © 2019 Michael Sacks. All rights reserved.
//

import XCTest
@testable import Image_Search

class Image_SearchTests: XCTestCase {

    func testImgurBasicItem() {
        guard let item = MovieItem(["poster_path" : "/9hE6vesQoSREyvJha9z0g5OryHH.jpg"]) else { XCTFail(); return }
        XCTAssertEqual(item.url.absoluteString,"https://image.tmdb.org/t/p/w500/9hE6vesQoSREyvJha9z0g5OryHH.jpg")
        XCTAssertNil(item.title)
    }
    
    func testImgurCompleteItem() {
        guard let item = MovieItem(["poster_path" : "/9hE6vesQoSREyvJha9z0g5OryHH.jpg", "title" : "image title"]) else { XCTFail(); return }
        XCTAssertEqual(item.url.absoluteString,"https://image.tmdb.org/t/p/w500/9hE6vesQoSREyvJha9z0g5OryHH.jpg")
        XCTAssertEqual(item.title, "image title")
    }
    
    func testImgurNils() {
        XCTAssertNil(MovieItem(["poster_path" : "no path"]))
        XCTAssertNil(MovieItem(["title" : "image title"]))
        XCTAssertNil(MovieItem([ : ]))
    }

}
