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

let cmd3 = "read"
let cmd4 = "fill"

let cmd5 = "parse" // parse = find + read

let arguments = ProcessInfo.processInfo.arguments

guard arguments.contains(cmd1) || arguments.contains(cmd2) || arguments.contains(cmd3) || arguments.contains(cmd4) || arguments.contains(cmd5) else {
    print("you must input find/check /path")
    
    exit(0)
}

if let findIndex = arguments.index(of: cmd1) {
    var outputPath = "conan_ouput/finder.strings"
    var inputPath = arguments[findIndex + 1]
    
    do {
        let finder = try Finder(input: inputPath, output: outputPath)
        try finder.start()
    } catch {
        print("❌  \(error)")
        
        exit(0)
    }
}

if let readIndex = arguments.index(of: cmd3) {
    var outputPath = "conan_ouput"
    var inputPath = arguments[readIndex + 1]

    do {
        let reader = try Reader(input: inputPath, output: outputPath)
        try reader.start()
    } catch {
        print("❌  \(error)")
        
        exit(0)
    }
}

if let parseIndex = arguments.index(of: cmd5) {
    var findOutput = "conan_output/finder.strings"
    var readOutput = "conan_output"
    var inputPath = arguments[parseIndex + 1]
    
    do {
        let finder = try Finder(input: inputPath, output: findOutput)
        try finder.start()
        
        let reader = try Reader(input: inputPath, output: readOutput)
        try reader.start()
    } catch {
        print("❌  \(error)")
        
    }
}


if let checkIndex = arguments.index(of: cmd2) {
    var outputPath = "conan_output/check.txt"
    var inputPath = arguments[checkIndex + 1]
    
    do {
        let checker = try Checker(input: inputPath, output: outputPath)
        try checker.start()
    } catch {
        print(error)
        
        exit(0)
    }
}


