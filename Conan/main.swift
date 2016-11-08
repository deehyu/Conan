//
//  main.swift
//  Conan
//
//  Created by 黄明 on 2016/11/5.
//  Copyright © 2016年 Danis. All rights reserved.
//

import Foundation

let cmd1 = "find"
let cmd2 = "check"

let arguments = ProcessInfo.processInfo.arguments

guard arguments.contains(cmd1) || arguments.contains(cmd2) else {
    print("you must input find/check /path")
    
    exit(0)
}

if let findIndex = arguments.index(of: cmd1) {
    var inputPath = ""
    var outputPath = "conan_ouput/base.strings"
    
    if findIndex < arguments.count - 1 {
        inputPath = arguments[findIndex + 1]
    }
    
    do {
        let finder = try Finder(input: inputPath, output: outputPath)
        try finder.start()
        
        
    } catch {
        print(error)
        
        exit(0)
    }
}

if let checkIndex = arguments.index(of: cmd2) {
    var inputPath = ""
    var outputPath = "conan_output/check.txt"
    
    if checkIndex < arguments.count - 1 {
        inputPath = arguments[checkIndex + 1]
    }
    
    do {
        let checker = try Checker(input: inputPath, output: outputPath)
        try checker.start()
    } catch {
        print(error)
        
        exit(0)
    }
}
