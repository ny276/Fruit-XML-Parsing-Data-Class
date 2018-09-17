//
//  ViewController.swift
//  Fruit Parsing 03
//
//  Created by 김종현 on 2018. 9. 17..
//  Copyright © 2018년 김종현. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    // 데이터 클래스 객체 배열
    var myFruitData = [FruitData]()
    
    var dName = ""
    var dColor = ""
    var dCost = ""

    // 현재의 tag를 저장
    var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Fruit.xml 화일을 가져 오기
        // optional binding nil check
        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
            // 파싱 시작
            if let myParser = XMLParser(contentsOf: path) {
                // delegate를 ViewController와 연결
                myParser.delegate = self
                
                if myParser.parse() {
                    print("파싱 성공")
//                    print(myFruitData[0].name)
//                    print(myFruitData[0].color)
//                    print(myFruitData[0].cost)
                    
                    for i in 0 ..< myFruitData.count {
                        print(myFruitData[i].name)
                    }
                } else {
                    print("파싱 실패")
                }
            
            } else {
                print("파싱 오류 발생")
            }
            
        } else {
            print("xml file not found")
        }
    }
    
    // XML Parser delegate 메소드
    // 1. tag(element)를 만나면 실행
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    //2. tag 다음에 문자열을 만날때 실행
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // 공백 등 제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            switch currentElement {
            case "name" : dName = data
            case "color" : dColor = data
            case "cost" : dCost = data
            default : break
            }
        }
    }
    
    //3. tag가 끝날때 실행(/tag)
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let myItem = FruitData()
            myItem.name = dName
            myItem.color = dColor
            myItem.cost = dCost
            myFruitData.append(myItem)
        }
    }
}

