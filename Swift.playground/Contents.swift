//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

typealias Payload = [String: AnyObject]

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in

DataManager.getTopAppsDataFromItunesWithSuccess { (data) -> Void in
    
    var json: Payload!
    
    // 1
    do {
        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Payload
    } catch {
        print(error)
        XCPlaygroundPage.currentPage.finishExecution()
    }
    
    // 2
    guard let feed = json["feed"] as? Payload,
        let apps = feed["entry"] as? [AnyObject],
        let app = apps.first as? Payload
        else { XCPlaygroundPage.currentPage.finishExecution() }
    
    guard let container = app["im:name"] as? Payload,
        let name = container["label"] as? String
        else { XCPlaygroundPage.currentPage.finishExecution() }
    
    guard let id = app["id"] as? Payload,
        let link = id["label"] as? String
        else { XCPlaygroundPage.currentPage.finishExecution() }
    
    // 3
    let entry = App(name: name, link: link)
    print(entry)
    
    XCPlaygroundPage.currentPage.finishExecution()
    
}
