//
//  ViewController.swift
//  201811837
//
//  Created by D7703_13 on 2019. 12. 18..
//  Copyright © 2019년 Personal Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XMLParserDelegate{
    
    var dataclass = [data]()
    
    var dlat =   ""
    var dlng =   ""
    var dtitle = ""
    
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        if let path = Bundle.main.url(forResource: "data", withExtension: "xml") {
            // 파싱 시작
            if let myParser = XMLParser(contentsOf: path) {
                // delegate를 ViewController와 연결
                myParser.delegate = self
                
                if myParser.parse() {

                    
                    for i in 0 ..< dataclass.count {
                       
                        print(dataclass[i].lat)
                        print(dataclass[i].lng)
                        print(dataclass[i].title)
                        
                        let lat = String(dataclass[i].lat)
                        let lng = String(dataclass[i].lng)
                        let title = String(dataclass[i].title)
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
        
    
func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    currentElement = elementName
    }

//2. tag 다음에 문자열을 만날때 실행
func parser(_ parser: XMLParser, foundCharacters string: String) {
    // 공백 등 제거
    let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    
    if !data.isEmpty {
        switch currentElement {
        case "lat" : dlat = data
        case "lng" : dlng = data
        case "title" : dtitle = data
        default : break
            }
        }
    }

//3. tag가 끝날때 실행(/tag)
func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "item" {
        let myItem = data()
        myItem.lat = dlat
        myItem.lng = dlng
        myItem.title = dtitle
        dataclass.append(myItem)
    }
}
}

