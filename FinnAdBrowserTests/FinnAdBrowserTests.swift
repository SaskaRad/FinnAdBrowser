//
//  FinnAdBrowserTests.swift
//  FinnAdBrowserTests
//
//  Created by Saska Radosavljevic on 29/01/2024.
//

import XCTest
@testable import FinnAdBrowser

final class FinnAdBrowserTests: XCTestCase {
    
    var mockService: MockNetworkService!
    var viewModel: AdsViewModel!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        viewModel = AdsViewModel(networkService: mockService)
    }
    
    func testFetchAdsListSuccess() async {
        mockService.mockData =  [
            AdItemsContainer(
                description: "Idyllisk sørlandshus til leie i skoleåret 2023/2024",
                id: "148834990",
                url: "/148834990",
                adType: "REALESTATE",
                location: "Grimstad",
                type: "AD",
                price: Price(value: 10000, total: 1200),
                image: AdImage(url: "2019/8/vertical-2/04/l/nul/l_1451344711.jpg",
                               height: 3024,
                               width: 4032,
                               type: "GENERAL",
                               scalable: true),
                score: 0.17876637,
                version: "mul-pop-thompzon",
                favourite: Favourite(itemId: "148834990", itemType: "Ad")
            )
        ]
        
        await viewModel.fetchAdsList()
   
        XCTAssertFalse(viewModel.ads.isEmpty, "Ads should be updated")
    }
    
    func testFetchAdsListFailure() async {
        mockService.mockError = NetworkingError.dataProcessingError
        
        await viewModel.fetchAdsList()
        
        XCTAssertNotNil(viewModel.errorMessage, "Error fetching ads list")
    }
}
