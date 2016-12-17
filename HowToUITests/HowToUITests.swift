//
//  HowToUITests.swift
//  HowToUITests
//
//  Created by iossenac on 19/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import XCTest

class HowToUITests: XCTestCase {
    
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        XCUIApplication().launch()
        
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app2 = XCUIApplication()
        let app = app2
        app.tables["Empty list"].swipeDown()
        app.navigationBars["Tutoriais"].buttons["Search"].tap()
        app2.keys["P"].tap()
        
        let pesquisePorTutoriaisSearchField = app.searchFields["Pesquise por tutoriais"]
        pesquisePorTutoriaisSearchField.typeText("Pao")
        
        let deleteKey = app2.keys["delete"]
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        
        let tablesQuery = app2.tables
        tablesQuery.staticTexts["Como fazer pão de queijo"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .table).element.tap()
        
        let vAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZafStaticText = tablesQuery.staticTexts["Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaffari Vá até o Zaf"]
        vAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZafStaticText.swipeUp()
        vAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZaffariVAtOZafStaticText.tap()
        
        let element3 = element.children(matching: .other).element
        let element2 = element3.children(matching: .other).element(boundBy: 1)
        let button = element2.children(matching: .button).element(boundBy: 1)
        button.tap()
        
        let button2 = element3.children(matching: .button).element
        button2.tap()
        button2.tap()
        button.tap()
        app.navigationBars["Passo 3/3"].buttons[" "].tap()
        tablesQuery.staticTexts["Siga os passos do pacote :P"].tap()
        element2.children(matching: .button).element(boundBy: 0).tap()
        app.navigationBars["Passo 2/3"].buttons[" "].tap()
        
        let button3 = app.navigationBars["Tutorial"].buttons[" "]
        button3.tap()
        pesquisePorTutoriaisSearchField.buttons["Clear text"].tap()
        tablesQuery.staticTexts["Como fazer download de um livro na internet"].tap()
        button3.tap()
        
    }
    
    func testSearch() {
        
        if(XCUIApplication().tables.cells.count > 0) {
            let app = XCUIApplication()
            let comoFazerPODeQueijoStaticText = app.tables.staticTexts["Como fazer pão de queijo"]
            comoFazerPODeQueijoStaticText.tap()
            app.navigationBars["Tutoriais"].buttons["Search"].tap()
            app.searchFields["Pesquise por tutoriais"].typeText("P")
            comoFazerPODeQueijoStaticText.tap()
            
            let table = app.tables.element(at: 0)
            let expectedNumberOfElements: UInt = 1
            XCTAssertEqual(table.cells.count, expectedNumberOfElements)
        } else {
            let app = XCUIApplication()
            let table = app.tables.element(at: 0)
            XCTAssertEqual(table.cells.count, 0)
        }
       
        
        
    }
    
//    func testSearch() {
//        
//        let app = XCUIApplication()
//        let tablesQuery = app.tables
//        let comoFazerDownloadDeUmLivroNaInternetStaticText = tablesQuery.staticTexts["Como fazer download de um livro na internet"]
//        comoFazerDownloadDeUmLivroNaInternetStaticText.tap()
//        
//        let comoFazerPODeQueijoStaticText = tablesQuery.staticTexts["Como fazer pão de queijo"]
//        comoFazerPODeQueijoStaticText.swipeDown()
//        comoFazerDownloadDeUmLivroNaInternetStaticText.swipeLeft()
//        app.navigationBars["Tutoriais"].buttons["Search"].tap()
//        app.searchFields["Pesquise por tutoriais"].typeText("P")
//        comoFazerPODeQueijoStaticText.tap()
//        
//    }
    
//    func testOpenTutorial() {
//        
//        let app = XCUIApplication()
//        let tablesQuery = app.tables
//        tablesQuery.staticTexts["Como fazer pão de queijo"].tap()
//        tablesQuery.staticTexts["Passo 2"].tap()
//        app.navigationBars["Passo 2/3"].buttons[" "].tap()
//        
//        
//    }
    
    
    
}
