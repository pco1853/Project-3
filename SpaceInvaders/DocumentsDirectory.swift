//
//  DocumentsDirectory.swift
//  SpaceInvaders
//
//  Created by Jason  on 5/18/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

func DocumentsDirectory() -> String{
    return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as String
}

func FilePathInDocumentsDirectory(fileName:String) -> String{
    return DocumentsDirectory().stringByAppendingPathComponent(fileName)
}