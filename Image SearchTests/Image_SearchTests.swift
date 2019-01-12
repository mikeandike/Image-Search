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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImgurBasicItem() {
        guard let item = ImgurItem(["images" : [["type" : "image/jpeg", "link" : "https://i.imgur.com/5zztrK3.jpg"]]]) else { XCTFail(); return }
        XCTAssertEqual(item.url.absoluteString,"https://i.imgur.com/5zztrK3.jpg")
        XCTAssertNil(item.title)
    }
    
    func testImgurCompleteItem() {
        guard let item = ImgurItem(["images" : [["type" : "image/jpeg", "link" : "https://i.imgur.com/5zztrK3.jpg"]], "title" : "image title"]) else { XCTFail(); return }
        XCTAssertEqual(item.url.absoluteString,"https://i.imgur.com/5zztrK3.jpg")
        XCTAssertEqual(item.title, "image title")
    }
    
    func testImgurEdgeCases() {
        XCTAssertNil(ImgurItem(["images" : [["type" : "image/jpeg", "link" : " "]]]))
        XCTAssertNil(ImgurItem(["images" : [["type" : "image/gif", "link" : "https://i.imgur.com/5zztrK3.jpg"]]]))
        XCTAssertNil(ImgurItem(["images" : ["type" : "image/png", "link" : "https://i.imgur.com/5zztrK3.jpg"]]))
        XCTAssertNil(ImgurItem(["images" : [[ : ]]]))
        XCTAssertNil(ImgurItem([ : ]))
        
        guard let item = ImgurItem(["images" : [["type" : "image/png", "link" : "https://i.imgur.com/oHcBq.png"],
                                                ["type" : "image/jpeg", "link" : "https://i.imgur.com/5zztrK3.jpg"],
                                                ["type" : "image/png", "link" : "https://i.imgur.com/FssYN.png"]], "title" : "some title"]) else { XCTFail(); return }
        XCTAssertEqual(item.url.absoluteString,"https://i.imgur.com/oHcBq.png")
        XCTAssertEqual(item.title, "some title")
    }

}
