//
//  ProfileViewModelTests.swift
//  SwiftWithMVVMTests
//
//  Created by QDSG on 2019/4/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import XCTest
@testable import SwiftWithMVVM

class ProfileViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitialization() {
        let profile = Profile()
        
        let profileVm = ProfileViewModel(withProfile: profile)
        
        XCTAssertNotNil(profileVm, "The profile view model should not be nil.")
        XCTAssertTrue(profileVm.profile === profile, "The profile should be equal to the profile that was passed in.")
    }
    
    func testTimeForProfile() {
        let profile = Profile()
        profile.duration = 645.0
        
        let profileVm = ProfileViewModel(withProfile: profile)
        
        let timeForProfile = profileVm.timeForProfile()
        
        XCTAssertEqual(timeForProfile, "10:45", "The formatted time should be equal to 10:45.")
    }
}
