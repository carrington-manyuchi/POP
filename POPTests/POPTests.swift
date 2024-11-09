//
//  POPTests.swift
//  POPTests
//
//  Created by Manyuchi, Carrington C on 2024/11/09.
//
/// when tesing we always have 3 scenarios:
///  Given:
///  When:
///  Then:

import XCTest
@testable import POP

final class POPTests: XCTestCase {
    
    private var serviceUndertest: UserViewModel!
    private var userService: MockUserService!
    private var view: MockUserView!

    override func setUpWithError() throws {
        view = MockUserView()
        userService = MockUserService()
        serviceUndertest = UserViewModel(userService: userService)
        serviceUndertest.view = view
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        userService = nil
        serviceUndertest = nil
        try super.tearDownWithError()
    }

    func testThatWhenUpdatingViewOnAPISuccessShowsImageAndEmail() {
        //given
        let user = User(id: 1, email: "carrington@gmail.com", avatar: "https://www.picsum.com/2")
        userService.fetchUserMockResult = .success(user)
        //when
        serviceUndertest.fetchUser()
        // then
        XCTAssertEqual(view.updateViewArray.count, 1)
        XCTAssertEqual(view.updateViewArray[0].email, "carrington@gmail.com")
        XCTAssertEqual(view.updateViewArray[0].imageUrl, "https://www.picsum.com/2")
    }
    
    func testThatWhenUpdatingViewOnFailureShowsErrorImageAndDefaultNoUserFound() {
        // given
        userService.fetchUserMockResult = .failure(NSError())
        // when
        serviceUndertest.fetchUser()
        // then
        XCTAssertEqual(view.updateViewArray.count, 1)
        XCTAssertEqual(view.updateViewArray[0].email, "No User found")
        XCTAssertEqual(view.updateViewArray[0].imageUrl, "https://cdn1.iconfinder.com/data/icons/user-fill-icons-set/144/User003_Error-1024.jpg")
    }
}

class MockUserService: UserService {
    var fetchUserMockResult: Result<User, Error>?
    func fetchUser(completion: @escaping (Result<User, any Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
}

class MockUserView: UserView {
    var updateViewArray: [(imageUrl: String, email: String)] = []
    func updateView(imageUrl: String, email: String) {
        updateViewArray.append((imageUrl, email ))
    }
}
