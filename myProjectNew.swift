//
//  myProjectNew.swift
//  ButikkaNewApp
//
//  Created by PURPLE on 11/6/15.
//  Copyright (c) 2015 PURPLE. All rights reserved.
//

import Foundation

//@objc class Hello : NSObject
//{
//    func sayHello ()
//    {
//        println("Hi there!")
//}
//}

class TestClass
{
    
//        func printSomething()
//        {
//    
//        println("Hello World")
//    
//        }

    class func `new`() -> TestClass
    {
        return TestClass()
    }
    
    func testFunction(someArg:AnyObject)-> String
    {
        
   
        
        
        print("This function works")
        
        let returnVal = "You sent me \(socket)"
        
        NSLog("returnVal========= %@",returnVal)
        
        return returnVal
        
    }
}
