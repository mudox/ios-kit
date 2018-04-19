//
//  Time.swift
//  iOSKit
//
//  Created by Mudox on 2018/4/4.
//

import Foundation

extension Int {

 var minute: TimeInterval {
  return TimeInterval(60 * self)
 }

 var hour: TimeInterval {
  return TimeInterval(60.minute)
 }

 var day: TimeInterval {
  return TimeInterval(24 * hour)
 }

 var week: TimeInterval {
  return TimeInterval(7 * day)
 }

}

extension Int {
  var kb: Int {
    return self * 1024
  }
  
  var mb: Int {
    return self * 1024.kb
  }
  
  var gb: Int {
    return self * 1024.mb
  }
  
  
  var tb: Int {
    return self * 1024.gb
  }
}
