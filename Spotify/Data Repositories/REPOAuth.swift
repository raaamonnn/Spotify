//
//  REPOAuth.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import Foundation

final class REPOAuth {
    private let svcAuth: SVCAuth
    init(svcAuth: SVCAuth) {
        self.svcAuth = svcAuth
        refresh()
    }
    public func exchangeCodeForToken(code: String, completionHandler: @escaping (Bool) -> Void) {
        svcAuth.exchangeCodeForToken(code: code) { success in
            if success {
                print("[+] Successfully exchanged Code for Token")
                completionHandler(true)
                
            } else {
                print("[-] Unable exchanged Code for Token")
                completionHandler(false)
            }
        }
    }
    private var refreshingToken = false
    private var onRefreshBlocks = [((String) -> Void)]()
    public func withValidToken(completionHandler: @escaping (String) -> Void) {
        //make sure we arent already refreshint
        guard !refreshingToken else {
            //Append the completion
            onRefreshBlocks.append(completionHandler)
            return
        }

        if shouldRefreshToken {
            refreshingToken = true
            svcAuth.refreshAccessToken(refreshToken: refreshToken) { [weak self] success in
                self?.refreshingToken = false
                if let token = self?.accessToken, success {
                    print("[+] Successfully refreshed Access Token")
                    self?.onRefreshBlocks.forEach { $0(token) }
                    self?.onRefreshBlocks.removeAll()
                    completionHandler(token)
                } else {
                    print("[-] Unable to refreshed Access Token")
                }
            }
        } else if let token = accessToken {
            completionHandler(token)
        }
    }
    
    var signInUrl: URL {
        return svcAuth.signInURL
    }
    
    var isAuthenticated: Bool {
        return accessToken != nil
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        return currentDate.addingTimeInterval(300) >= expirationDate
    }
    
    public func refresh() {
        if shouldRefreshToken {
            svcAuth.refreshAccessToken(refreshToken: refreshToken) { success in
                if success {
                    print("[+] Successfully refreshed Access Token")
                } else {
                    print("[-] Unable to refreshed Access Token")
                }
            }
        }
        
        return
    }
}
