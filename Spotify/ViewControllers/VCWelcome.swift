//
//  VCWelcome.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import UIKit

class VCWelcome: UIViewController {
    let appEnvironment: AppEnvironment
    
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Sign Into Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let description = UILabel()
        description.text = "This is a Gear"
        description.textColor = .red
        description.font = .boldSystemFont(ofSize: 26)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        view.addSubview(imageBackground)
        view.addSubview(imageView)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            signInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            imageBackground.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -100),
            imageBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imageBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            label.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 25),
            
            imageView.bottomAnchor.constraint(equalTo: imageBackground.bottomAnchor, constant: -50),
            imageView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -50),
            imageView.topAnchor.constraint(equalTo: label.topAnchor, constant: 50),
        ])
        
        
        signInButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        signInButton.frame = CGRect(x: 20, y: view.height - 100 - view.safeAreaInsets.bottom, width: view.width - 40, height: 50)
//    }
    @objc private func onClick() {
        let vc = VCAuth(appEnvironment: appEnvironment)
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        //Log user in or print error
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something went wrong when signing in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = VCTabBar(appEnvironment: appEnvironment)
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
}
