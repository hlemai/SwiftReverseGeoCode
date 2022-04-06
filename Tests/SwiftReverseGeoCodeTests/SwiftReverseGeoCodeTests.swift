import XCTest
    @testable import SwiftReverseGeoCode

    final class SwiftReverseGeoCodeTests: XCTestCase {
        func testWrongDatabase() throws {
            let reverseService = ReverseGeoCodeService(database: "wrongPathTo/db.sqlite")
            XCTAssertNil(try? reverseService.reverseGeoCode(latitude: 10, longitude: 10))
        }

        func testOkValue() throws {
            let packageRootPath = URL(fileURLWithPath: #file).deletingLastPathComponent()
            print("DigitalPicturesModelsTests: PackagePath : \(packageRootPath.path)")
            let folder = packageRootPath
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Data/geocitydb.sqlite")

            let reverseService = ReverseGeoCodeService(database: folder.path)

            let location = try reverseService.reverseGeoCode(latitude: 51.07786, longitude: 2.51673)

            XCTAssert(location.countryCode == "FR")
            XCTAssert(location.name == "Bray-Dunes")

        }

        func testOkValueWest() throws {
            let packageRootPath = URL(fileURLWithPath: #file).deletingLastPathComponent()
            print("DigitalPicturesModelsTests: PackagePath : \(packageRootPath.path)")
            let folder = packageRootPath
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Data/geocitydb.sqlite")

            let reverseService = ReverseGeoCodeService(database: folder.path)

            let location = try reverseService.reverseGeoCode(
                latitude: 37.78772166666667,
                longitude: -122.40679166666666)

            XCTAssert(location.countryCode == "US")
            XCTAssert(location.name == "Chinatown")

        }

        func testOkValueSouth() throws {
            let packageRootPath = URL(fileURLWithPath: #file).deletingLastPathComponent()
            print("DigitalPicturesModelsTests: PackagePath : \(packageRootPath.path)")
            let folder = packageRootPath
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Data/geocitydb.sqlite")

            let reverseService = ReverseGeoCodeService(database: folder.path)

            let location = try reverseService.reverseGeoCode(latitude: -54.795404, longitude: -68.476)
            print(location)
            XCTAssert(location.name == "Ushuaia")

        }

        func testNowhere() throws {
            let packageRootPath = URL(fileURLWithPath: #file).deletingLastPathComponent()
            print("DigitalPicturesModelsTests: PackagePath : \(packageRootPath.path)")
            let folder = packageRootPath
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Data/geocitydb.sqlite")

            let reverseService = ReverseGeoCodeService(database: folder.path)

            let location = try? reverseService.reverseGeoCode(latitude: 43.107671, longitude: -143.688369)

            XCTAssertNil(location)

        }
        func testUseBundledBase() throws {
            
            let dataURL = Bundle.module.url(forResource: "geocitydb", withExtension:"sqlite", subdirectory: "")
            print (dataURL)
            XCTAssert(dataURL?.path != nil)
        }

    }
