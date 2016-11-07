//
//  main.swift
//  Conan
//
//  Created by 黄明 on 2016/11/5.
//  Copyright © 2016年 Danis. All rights reserved.
//

import Foundation

print("Hello, World!")

let cmd1 = "find"
let cmd2 = "check"
let cmd3 = "checkall"

let arguments = ProcessInfo.processInfo.arguments

guard arguments.contains(cmd1) || arguments.contains(cmd2) else {
    print("you must input find/check /path")
    
    exit(0)
}

if let findIndex = arguments.index(of: cmd1) {
    var inputPath = ""
    var outputPath = "conan_ouput/find.strings"
    
    if findIndex < arguments.count - 1 {
        inputPath = arguments[findIndex + 1]
    }
    
    do {
        if let finder = try Finder(path: inputPath, output: outputPath) {
            finder.start()
        }
        
        
    } catch {
        print(error)
        
        exit(0)
    }
}
