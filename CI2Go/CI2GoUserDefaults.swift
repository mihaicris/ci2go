//
//  CI2GoUserDefaults.swift
//  CI2Go
//
//  Created by Atsushi Nagase on 10/27/14.
//  Copyright (c) 2014 LittleApps Inc. All rights reserved.
//

import Foundation

private var _standardUserDefaults: AnyObject? = nil

public let kCI2GoColorSchemeUserDefaultsKey = "CI2GoColorScheme"
public let kCI2GoCircleCIAPITokenDefaultsKey = "CI2GoColorCircleCIAPIToken"
public let kCI2GoLogRefreshIntervalDefaultsKey = "CI2GoLogRefreshInterval"
public let kCI2GoAPIRefreshIntervalDefaultsKey = "CI2GoAPIRefreshInterval"

public class CI2GoUserDefaults: NSObject {
  
  public func reset() {
    for k in [
      kCI2GoColorSchemeUserDefaultsKey,
      kCI2GoCircleCIAPITokenDefaultsKey,
      kCI2GoLogRefreshIntervalDefaultsKey,
      kCI2GoAPIRefreshIntervalDefaultsKey
      ] {
        userDefaults.removeObjectForKey(k)
    }
  }
  
  
  public class func standardUserDefaults() -> CI2GoUserDefaults {
    if nil == _standardUserDefaults {
      _standardUserDefaults = CI2GoUserDefaults()
    }
    return _standardUserDefaults! as CI2GoUserDefaults
  }

  private var _userDefaults: NSUserDefaults? = nil
  private var userDefaults: NSUserDefaults {
    if nil == _userDefaults {
      _userDefaults = NSUserDefaults(suiteName: kCI2GoAppGroupIdentifier)
      _userDefaults?.registerDefaults([
        kCI2GoColorSchemeUserDefaultsKey: "Github",
        kCI2GoLogRefreshIntervalDefaultsKey: 1.0,
        kCI2GoAPIRefreshIntervalDefaultsKey: 5.0
        ])
    }
    return _userDefaults!
  }
  
  public var colorSchemeName: NSString? {
    set(value) {
      if (value != nil && find(ColorScheme.names(), value!) != nil) {
        userDefaults.setValue(value, forKey: kCI2GoColorSchemeUserDefaultsKey)
      } else {
        userDefaults.removeObjectForKey(kCI2GoColorSchemeUserDefaultsKey)
      }
      userDefaults.synchronize()
    }
    get {
      return userDefaults.stringForKey(kCI2GoColorSchemeUserDefaultsKey)
    }
  }
  
  public var circleCIAPIToken: NSString? {
    set(value) {
      if (value != nil) {
        userDefaults.setValue(value, forKey: kCI2GoCircleCIAPITokenDefaultsKey)
      } else {
        userDefaults.removeObjectForKey(kCI2GoCircleCIAPITokenDefaultsKey)
      }
      userDefaults.synchronize()
    }
    get {
      return userDefaults.stringForKey(kCI2GoCircleCIAPITokenDefaultsKey)
    }
  }
  
  public var logRefreshInterval: Double {
    set(value) {
      userDefaults.setDouble(value, forKey: kCI2GoLogRefreshIntervalDefaultsKey)
      userDefaults.synchronize()
    }
    get {
      return userDefaults.doubleForKey(kCI2GoLogRefreshIntervalDefaultsKey)
    }
  }
  
  public var apiRefreshInterval: Double {
    set(value) {
      userDefaults.setDouble(value, forKey: kCI2GoAPIRefreshIntervalDefaultsKey)
      userDefaults.synchronize()
    }
    get {
      return userDefaults.doubleForKey(kCI2GoAPIRefreshIntervalDefaultsKey)
    }
  }
  
}