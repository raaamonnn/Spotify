//
//  SVCAuth.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import Foundation

final class SVCAuth {
    class Constants {
        static let clientID = "cd7091fbbc4240fc8f51fc01ead3859c"
        static let clientSecret = "3a5b9610487a4036b826819d77fd8c0e"
        static let scopes = "user-read-private%20user-read-email%20user-follow-modify%20user-follow-read%20user-library-modify%20user-library-read%20playlist-modify-private%20playlist-read-private%20playlist-modify-public"
        static let redirectURI = "https://darilearner.com/"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    
    public var signInURL: URL {
        let url = "https://accounts.spotify.com/authorize?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: url)!
    }
    
    public func exchangeCodeForToken(code: String, completionHandler: @escaping (Bool) -> Void) {
        guard let url = URL(string: Constants.tokenAPIURL) else {return}
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("[-] Failure to get base64")
            completionHandler(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completionHandler(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completionHandler(true)
            } catch {
                print("[-] Error JSONDecoder AuthResponse Exchanging Code for Token \(error.localizedDescription)")
                completionHandler(false)
            }
        }
        
        task.resume()
        
    }
    
    public func refreshAccessToken(refreshToken: String?, completionHandler: @escaping (Bool) -> Void) {
        guard let refreshToken = refreshToken else {
            completionHandler(false)
            return
        }
        
        guard let url = URL(string: Constants.tokenAPIURL) else {return}
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("[-] Failure to get base64")
            completionHandler(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completionHandler(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completionHandler(true)
            } catch {
                print("[-] Error JSONDecoder AuthResponse Refreshing Access Token\(error.localizedDescription)")
                completionHandler(false)
            }
        }
        
        task.resume()
    }
    
    public func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}
