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

let cmd6 = "trim"

let arguments = ProcessInfo.processInfo.arguments

var cmds = [cmd1, cmd2, cmd3, cmd4, cmd5, cmd6]

var valid = false
for cmd in cmds {
    if let index = arguments.index(of: cmd) {
        if arguments.count > index + 1 {
            valid = true
        }
    }
}

guard valid else {
    print("\n")
    print("😂  - [find] PROJECT_DIR             -> 遍历项目文件，提取所有国际化文本")
    print("😂  - [read] PROJECT_DIR             -> 提取国际化文件列表")
    print("😂  - [parse] PROJECT_DIR            -> find 和 read 同时进行")
    print("😂  - [check] SOURCE_DIR             -> 对比国际化文件，输出缺失的文本")
    print("😂  - [fill] SOURCE_DIR PROJECT_DIR  -> 将新的文件内容写入PROJECT")
    print("😂  - [trim] BASE_FILE TO_TRIM_FILE  -> 将文件按照给出的base进行瘦身")
    print("\n")
    
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
    }
}

if let fillIndex = arguments.index(of: cmd4) {
    var inputPath = arguments[fillIndex + 1]
    var projectPath = arguments[fillIndex + 2]
    
    do {
        let filler = try Filler(input: inputPath, project: projectPath)
        try filler.start()
    } catch {
        print(error)
    }
}

if let trimIndex = arguments.index(of: cmd6) {
    var baseInput = arguments[trimIndex + 1]
    var toTrimInput = arguments[trimIndex + 2]
    
    do {
        let trimmer = try Trimmer(input1: baseInput, input2: toTrimInput)
        try trimmer.start()
    } catch {
        print(error)
    }
}


