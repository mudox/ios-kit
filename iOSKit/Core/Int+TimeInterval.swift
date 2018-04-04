//
//  Time.swift
//  iOSKit
//
//  Created by Mudox on 2018/4/4.
//

import Foundation

extension Int {

 var minuteInSecond: TimeInterval {
  return TimeInterval(60 * self)
 }

 var hourInSecond: TimeInterval {
  return TimeInterval(60.minuteInSecond)
 }

 var dayInSecond: TimeInterval {
  return TimeInterval(24 * hourInSecond)
 }

 var weekInSecond: TimeInterval {
  return TimeInterval(7 * dayInSecond)
 }

}
