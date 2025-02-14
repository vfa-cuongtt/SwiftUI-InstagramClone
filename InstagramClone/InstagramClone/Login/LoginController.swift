//
//  LoginController.swift
//  InstagramClone
//
//  Created by vfa on 6/17/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

class LoginController: BaseViewController {
    
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFit
        //        logoImageView.backgroundColor = .red
        
        
        view.addSubview(logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        UIView.anchor(uiv: logoImageView, top: nil, bottom: nil, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 200, height: 50)
        
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextFieldInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextFieldInputChange), for: .editingChanged)
        return tf
    }()
    
    let loginButton: UIButton = {
        
        let btn = UIButton(type: .system ) // (type: .system) => can tap button
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 255)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.isEnabled = false
        
        // Add action
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return btn
    }()
    
    
    let dontHaveAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        let attributtedTile = NSMutableAttributedString(string: "Don't have an account?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributtedTile.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        
        btn.setAttributedTitle(attributtedTile, for: .normal)
        btn.setTitle("Don't have an account? Sign Up.", for: .normal)
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.hidenNavigationBar()
        self.setTextColorForNavigationBar()
        
        view.addSubview(dontHaveAccountButton)
        view.addSubview(logoContainerView)
        
        UIView.anchor(uiv: dontHaveAccountButton, top: nil, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        UIView.anchor(uiv: logoContainerView, top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 150)
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        // phan chia cac  field
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        UIView.anchor(uiv: stackView, top: logoContainerView .bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingBottom: 0, paddingLeft: 40, paddingRight: 40, width: 0, height: 140)
    }
    
    @objc func handleShowSignUp()  {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
        
    }
    
    @objc func handleTextFieldInputChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            
            loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 255)
            loginButton.isEnabled = false
            return
        }
        
        loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        loginButton.isEnabled = true
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print("Failed to login with email:", err)
                return
            }
            print("success ", user)
            AppRouter.shared.openHome()
            self.dismiss(animated: true, completion: nil)
        }
    }
}


