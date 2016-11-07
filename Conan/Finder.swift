//
//  Finder.swift
//  Conan
//
//  Created by 黄明 on 2016/11/5.
//  Copyright © 2016年 Danis. All rights reserved.
//

import Foundation

class Finder {
    
    private var inputURL: URL
    private var outputURL: URL
    
    /// 创建搜索Localized对象
    ///
    /// - Parameters:
    ///   - path: 导入路径，文件或路径
    ///   - output: 导出文件路径
    init?(path: String, output: String) throws {
        let fileManager = FileManager.default
        
        guard fileManager.fileExists(atPath: path) else {
            
            throw FinderError.InvalidInputPath
        }
        
        guard let inputURL = URL(string: path), let outputURL = URL(string: output) else {
            
            throw FinderError.InvalidOutputPath
        }
        self.inputURL = inputURL
        self.outputURL = outputURL
    }
    
    func start() {
        let files = FileManager.default.enumerator(atPath: inputURL.path)
        var preferedCount = 0
        var realCount = 0
        
        var localized = [String]()
        
        while let file: AnyObject = files?.nextObject() as AnyObject? {
            if let fileName = file as? String {
                if fileName.contains(".m") || fileName.contains(".mm") || fileName.contains(".swift") {
//                    print("\(fileName)")
                    do {
                        let codes = try String(contentsOfFile: inputURL.appendingPathComponent(fileName).absoluteString)
                        let localizedStrings = try find(inCodes: codes)
                        let count = try counts(inCodes: codes)
                        
                        preferedCount += count
                        realCount += localizedStrings.count
                        localized.append(contentsOf: localizedStrings)
                        
                        if count != localizedStrings.count {
                            print("\(fileName) - \(count) - \(localizedStrings.count)")
                        }
                        
//                        for string in localizedStrings {
//                            print(string)
//                        }
                    } catch {
                        
                    }
                }
            }
        }
        
        print("prefered --- \(preferedCount)")
        print("real ------- \(realCount)")
    }
    func counts(inCodes codes: String) throws -> Int {
        let regex = try NSRegularExpression(pattern: "NSLocalizedString\\(@\"|\\.localized\\b", options: .allowCommentsAndWhitespace)
        let matches = regex.matches(in: codes, options: [], range: NSMakeRange(0, (codes as NSString).length ))
        
        return matches.count
    }
    func find(inCodes codes: String) throws -> [String] {
        var localizedStrings = [String]()
        let regex = try NSRegularExpression(pattern: "((?<=NSLocalizedString\\(@)\"((?!NSLocalizedString).)*\"\\s*(?=,))|\"(((.*\\\\\".*)*)|[^\"]*)\"(?=.localized)", options: .allowCommentsAndWhitespace)
        let matches = regex.matches(in: codes, options: [], range: NSMakeRange(0, (codes as NSString).length ))
        for result in matches {
            let localized = (codes as NSString).substring(with: result.range)
            
            localizedStrings.append(localized)
        }
        
        return localizedStrings
    }
}
