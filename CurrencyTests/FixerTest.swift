//
//  FixerTest.swift
//  CurrencyTests
//
//  Created by Thành Đỗ Long on 24/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Swinject

@testable import Currency

class FixerTest: QuickSpec {

    override func spec() {
        var container: Container!
        var fixerResponse: FixerLatestRatesResponse!

        beforeEach {
            container = Container()
            container.register(Networking.self) { _ in NetworkingImpl()}
            container.register(CurrencyService.self) { resolver in
                CurrencyServiceImpl(networking: resolver.resolve(Networking.self)!)
            }

            fixerResponse = nil
        }

        describe("Currecy service") {
            context("when request current weather from Fixer service") {
                it("should correctly parse data") {
                    guard let fileUrl = Bundle(for: type(of: self)).path(forResource: "fixerResponse", ofType: "json") else {
                        return fail("fixerResponse.json.json not found")
                    }

                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: fileUrl), options: .alwaysMapped)
                        let decoder: JSONDecoder = JSONDecoder()
                        let response = try decoder.decode(FixerLatestRatesResponse.self, from: data)
                        expect(response.rates).toNot(beNil())
                        expect(response.rates.count).to(equal(168))
                        expect(response.timestamp).to(beAKindOf(Date.self))
                    } catch {
                        fail("Cannot parsing JSON file")
                    }

                }

                it("should return data") {
                    let fetcher = container.resolve(CurrencyService.self)!

                    waitUntil(timeout: 10) { done in
                        fetcher.getRates { (result) in
                            switch result {
                            case .success(let result):
                                fixerResponse = result
                                done()
                            case .failure:
                                fail("The network was unavailable or a parsing error occurred.")
                            }
                        }
                    }

                    expect(fixerResponse).toEventuallyNot(beNil())
                    expect(fixerResponse.base).toEventually(be("EUR"))
                    expect(fixerResponse.rates.count).toEventuallyNot(equal(0))
                }

            }
        }

    }
}
