//
//  UIImageColorsTests.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 24.10.21.
//

import XCTest
@testable import UIImageColors
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

final class UIImageColorsTests: XCTestCase {
    
    private var examplePath: String {
        var url = URL(fileURLWithPath: #filePath)
        url.deleteLastPathComponent()
        url.deleteLastPathComponent()
        url.deleteLastPathComponent()
        url.appendPathComponent("Example")
        url.appendPathComponent("Shared")
        url.appendPathComponent("Assets.xcassets")
        url.appendPathComponent("Calvin Klein - Kaws.imageset/Calvin Klein - Kaws.jpg")
        return url.path
    }
    
    #if canImport(UIKit)
    var image: UIImage!
    #elseif canImport(AppKit)
    var image: NSImage!
    #endif
    
    override func setUp() {
        super.setUp()
        
        #if canImport(UIKit)
        image = UIImage(contentsOfFile: examplePath)
        #elseif canImport(AppKit)
        image = NSImage(contentsOfFile: examplePath)
        #endif
        
        if image == nil {
            fatalError("Test-Image could not be loaded")
        }
    }
    
    func testSynchronousResults() throws {
        let colors = try XCTUnwrap(image.getColors(quality: .full))
        let primary = try XCTUnwrap(colors.primary)
        let secondary = try XCTUnwrap(colors.secondary)
        let detail = try XCTUnwrap(colors.detail)
        
        XCTAssertTrue(colors.background.rgb == (231, 231, 231))
        XCTAssertTrue(primary.rgb == (0, 0, 0))
        XCTAssertTrue(secondary.rgb == (255, 84, 126))
        XCTAssertTrue(detail.rgb == (115, 110, 106) || detail.rgb == (127, 120, 114)) // detail value is not consistent
    }
    
    func testAsynchronousResults() throws {
        let expectation = XCTestExpectation(description: "Test asynchronous results")
        
        image.getColors(quality: .full) { colors in
            
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
    
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testAsyncAwaitResults() async throws {
        let optionalColors = await image.colors(quality: .full)
        let colors = try XCTUnwrap(optionalColors)
        let primary = try XCTUnwrap(colors.primary)
        let secondary = try XCTUnwrap(colors.secondary)
        let detail = try XCTUnwrap(colors.detail)
        
        XCTAssertTrue(colors.background.rgb == (231, 231, 231))
        XCTAssertTrue(primary.rgb == (0, 0, 0))
        XCTAssertTrue(secondary.rgb == (255, 84, 126))
        XCTAssertTrue(detail.rgb == (115, 110, 106) || detail.rgb == (127, 120, 114)) // detail value is not consistent
    }
    
    func testScaling() throws {
        let colors = try XCTUnwrap(image.getColors(quality: .low))
        let primary = try XCTUnwrap(colors.primary)
        let secondary = try XCTUnwrap(colors.secondary)
        let detail = try XCTUnwrap(colors.detail)
        
        #if canImport(UIKit)
        XCTAssertTrue(colors.background.rgb == (232, 232, 232))
        XCTAssertTrue(primary.rgb == (0, 0, 0))
        XCTAssertFalse(secondary.rgb == (0, 0, 0)) // secondary value is not consistent
        XCTAssertFalse(detail.rgb == (0, 0, 0)) // detail value is not consistent
        #elseif canImport(AppKit)
        XCTAssertTrue(colors.background.rgb == (228, 228, 228))
        XCTAssertTrue(primary.rgb == (0, 0, 0))
        XCTAssertFalse(secondary.rgb == (0, 0, 0)) // secondary value is not consistent
        XCTAssertFalse(detail.rgb == (0, 0, 0)) // detail value is not consistent
        #endif
    }
    
    func testCustomScaling() throws {
        let colors = try XCTUnwrap(image.getColors(quality: .custom(123)))
        let primary = try XCTUnwrap(colors.primary)
        let secondary = try XCTUnwrap(colors.secondary)
        let detail = try XCTUnwrap(colors.detail)
        
        #if canImport(UIKit)
        XCTAssertTrue(colors.background.rgb == (232, 232, 232))
        XCTAssertTrue(primary.rgb == (0, 0, 0))
        XCTAssertTrue(secondary.rgb == (254, 82, 127) || secondary.rgb == (255, 85, 127)) // secondary value is not consisten
        XCTAssertFalse(detail.rgb == (0, 0, 0)) // detail value is not consistent
        #elseif canImport(AppKit)
        XCTAssertTrue(colors.background.rgb == (228, 228, 228) || colors.background.rgb == (226, 226, 226)) // background value is not consisten
        XCTAssertTrue(primary.rgb == (0, 0, 0))
        XCTAssertFalse(secondary.rgb == (0, 0, 0)) // secondary value is not consistent
        XCTAssertFalse(detail.rgb == (0, 0, 0)) // detail value is not consistent
        #endif
    }
}
