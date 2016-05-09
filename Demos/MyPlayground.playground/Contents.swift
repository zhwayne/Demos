//: Playground - noun: a place where people can play

import UIKit

let str: NSString = ""


var res: NSString?

if str.length == 1 {
    res = str;
} else if str.length >= 2 {
    res = str.substringToIndex(str.length - 1)
}




