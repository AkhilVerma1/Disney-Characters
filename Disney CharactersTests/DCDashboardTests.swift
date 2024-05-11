//
//  DCDashboardTests.swift
//  Disney CharactersTests
//
//  Created by Akhil Verma on 04/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import XCTest
@testable import Disney_Characters

final class DCDashboardTests: XCTestCase {
    
    private let viewModel = DCDashboardViewModel()
    
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testShouldReturnTheDisneyCharacters() async throws {
        await viewModel.setup()
        XCTAssertNotNil(viewModel.characters)
    }
}
