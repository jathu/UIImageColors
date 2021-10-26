//
//  UIImageColorsObjcTests.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 24.10.21.
//

import XCTest
@testable import UIImageColorsObjc
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

final class UIImageColorsObjcTests: XCTestCase {
    
    #if canImport(UIKit)
    var image: UIImage!
    #elseif canImport(AppKit)
    var image: NSImage!
    #endif
    
    override func setUp() {
        super.setUp()
        
        #if canImport(UIKit)
        image = UIImage(contentsOfFile: examplePath())
        #elseif canImport(AppKit)
        image = NSImage(contentsOfFile: examplePath())
        #endif
        
        if image == nil {
            fatalError("Test-Image could not be loaded")
        }
    }
    
    func testSynchronousResults() throws {
        let colors = try XCTUnwrap(image.getColorsObjc(quality: .full))
        let primary = try XCTUnwrap(colors.primary)
        let secondary = try XCTUnwrap(colors.secondary)
        let detail = try XCTUnwrap(colors.detail)
        
        XCTAssertTrue(colors.background.rgb == (231, 231, 231))
        XCTAssertTrue(primary.rgb == (0, 0, 0))
        XCTAssertTrue(secondary.rgb == (255, 84, 126))
        XCTAssertTrue(detail.rgb == (115, 110, 106) || detail.rgb == (127, 120, 114)) // detail value is not consistent
    }
    
    func testAsynchronousResults() throws {
        let expectation = XCTestExpectation(description: "Test asynchronous Objective-C results")
        
        image.getColorsObjc(quality: .full) { colors in
            
            do {
                let colors = try XCTUnwrap(colors)
                let primary = try XCTUnwrap(colors.primary)
                let secondary = try XCTUnwrap(colors.secondary)
                let detail = try XCTUnwrap(colors.detail)
                
                XCTAssertTrue(colors.background.rgb == (231, 231, 231))
                XCTAssertTrue(primary.rgb == (0, 0, 0))
                XCTAssertTrue(secondary.rgb == (255, 84, 126))
                XCTAssertTrue(detail.rgb == (115, 110, 106) || detail.rgb == (127, 120, 114)) // detail value is not consistent
            } catch {
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
