//
//  DCLocalStorageTests.swift
//  Disney CharactersTests
//
//  Created by Akhil Verma on 11/06/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Testing
@testable import Disney_Characters

struct DCLocalStorageTests {

    @Test
    func testSwiftDataLocally() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let viewModel = DCDashboardViewModel()
        #expect(viewModel.getBookmarkedCharacters().count == 0)
    }
}
