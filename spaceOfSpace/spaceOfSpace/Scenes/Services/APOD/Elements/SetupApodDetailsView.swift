//
//  SetupApodDetailsView.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 17.04.2021.
//

import UIKit
import Toaster

extension ApodViewController{
    func setupViewElem(){
        buttonSaveTopConstraint    = buttonSave.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 53)
        buttonInfoTopConstraint    = buttonInfo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 53)
        buttonRefreshTopConstraint = buttonRefresh.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 53)
        buttonBackTopConstraint    = buttonBack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 53)
        labelTitleBottomConstraint = labelTitle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        setupInfoButton()
        setupBackButton()
        setupRefreshButton()
        setupSaveButton()
        setupTitleLabel(title: "")
    }
    
    func setupSaveButton(){
        view.addSubview(buttonSave)
        buttonSave.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonSave.layer.cornerRadius=15
        buttonSave.alpha=0.6
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "square.and.arrow.down", withConfiguration: imageConfig)
        buttonSave.imageView?.tintColor = .white

        buttonSave.setImage(img, for: .normal)
        buttonSave.setTitleColor(UIColor.white, for: .normal)
        buttonSave.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            buttonSave.widthAnchor.constraint(equalToConstant: 50),
            buttonSave.heightAnchor.constraint(equalToConstant: 50),
            buttonSaveTopConstraint!,
            buttonSave.trailingAnchor.constraint(equalTo: buttonInfo.leadingAnchor, constant: -20)
        ])
        buttonSave.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    func setupRefreshButton(){
        view.addSubview(buttonRefresh)
        buttonRefresh.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonRefresh.layer.cornerRadius=15
        buttonRefresh.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "arrow.clockwise", withConfiguration: imageConfig)
        buttonRefresh.imageView?.tintColor = .white
        buttonRefresh.setImage(img, for: .normal)
        buttonRefresh.setTitleColor(UIColor.white, for: .normal)
        buttonRefresh.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            buttonRefresh.widthAnchor.constraint(equalToConstant: 50),
            buttonRefresh.heightAnchor.constraint(equalToConstant: 50),
            buttonRefreshTopConstraint!,
            buttonRefresh.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: 20)
        ])
        buttonRefresh.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        
        buttonRefresh.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        buttonRefresh.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupTitleLabel(title:String){
        view.addSubview(labelTitle)
        labelTitle.backgroundColor = .clear
        labelTitle.text=title
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines=0
        labelTitle.textColor=UIColor.white
        labelTitle.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitleBottomConstraint!,
            labelTitle.heightAnchor.constraint(equalToConstant: 50),
            labelTitle.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func setupInfoButton(){
        view.addSubview(buttonInfo)
        
        buttonInfo.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonInfo.layer.cornerRadius=15
        buttonInfo.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "info.circle", withConfiguration: imageConfig)
        buttonInfo.imageView?.tintColor = .white
        
        buttonInfo.setImage(img, for: .normal)
        buttonInfo.imageView?.contentMode = .scaleToFill
        buttonInfo.isUserInteractionEnabled=true
        buttonInfo.setTitleColor(UIColor.white, for: .normal)
        buttonInfo.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            buttonInfo.widthAnchor.constraint(equalToConstant: 50),
            buttonInfo.heightAnchor.constraint(equalToConstant: 50),
            buttonInfoTopConstraint!,
            buttonInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        buttonInfo.addTarget(self, action: #selector(setupDescriptionView), for: .touchUpInside)
    }
    
    func setupBackButton(){
        view.addSubview(buttonBack)
        buttonBack.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonBack.layer.cornerRadius=15
        buttonBack.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "arrow.uturn.backward", withConfiguration: imageConfig)
        buttonBack.imageView?.tintColor = .white
        
//        let buttonTopConstraint=
        
        buttonBack.setImage(img, for: .normal)
        buttonBack.setTitleColor(UIColor.white, for: .normal)
        buttonBack.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            buttonBack.widthAnchor.constraint(equalToConstant: 50),
            buttonBack.heightAnchor.constraint(equalToConstant: 50),
            buttonBackTopConstraint!,
            buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        buttonBack.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
    }
    
    @objc func goBack(_ button: UIButton){
        tabBarController?.tabBar.isHidden=false
        
        self.navigationController?.viewWillDisappear(true)
        self.dismiss(animated: true, completion: nil)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func setupDescriptionView(){
        viewDescription.view.backgroundColor=UIColor.clear
        viewDescription.view.layer.cornerRadius=15
        
        
        viewDescription.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewDescription.view)
        
        NSLayoutConstraint.activate([
            viewDescription.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            viewDescription.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewDescription.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewDescription.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        isHidden=2
    }
    
    @objc func refresh(){
        let request = Apod.GetImgUrl.Request()
        loader.startAnimating()
        interactor?.loadImg(request: request)
    }
    
    @objc func save(){
        guard let imgView=myScrollView!.viewForZooming as? UIImageView else {return}
        guard let inputImage = imgView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        let t=Toast(text: "Saved", duration: Delay.long)
        t.view.backgroundColor=UIColor.systemGray
        t.show()
        
    }
}

extension ApodViewController{
    func hide(){
//        buttonBack.isHidden=true
//        buttonInfo.isHidden=true
//        //labelTitle.isHidden=true
//        buttonRefresh.isHidden=true
//        buttonSave.isHidden=true
        UIView.animate(withDuration: 0.5, animations:{ [self] () -> Void in
            buttonBack   .alpha=0
            buttonInfo   .alpha=0
            labelTitle   .alpha=0
            buttonRefresh.alpha=0
            buttonSave   .alpha=0
            buttonSaveTopConstraint?.constant    -= 100
            buttonInfoTopConstraint?.constant    -= 100
            buttonRefreshTopConstraint?.constant -= 100
            buttonBackTopConstraint?.constant    -= 100
            
            labelTitleBottomConstraint?.constant += 100
            
            self.view.layoutIfNeeded()
        })
        
        
        isHidden=0
    }
    
    func show(){
//        buttonBack.isHidden=false
//        buttonInfo.isHidden=false
//        labelTitle.isHidden=false
//        buttonRefresh.isHidden=false
//        buttonSave.isHidden=false
        
        UIView.animate(withDuration: 0.3, animations:{ [self] () -> Void in
            buttonBack   .alpha=1
            buttonInfo   .alpha=1
            labelTitle   .alpha=1
            buttonRefresh.alpha=1
            buttonSave   .alpha=1
            buttonSaveTopConstraint?.constant    += 100
            buttonInfoTopConstraint?.constant    += 100
            buttonRefreshTopConstraint?.constant += 100
            buttonBackTopConstraint?.constant    += 100
            
            labelTitleBottomConstraint?.constant += -100
            
            self.view.layoutIfNeeded()
        })
        isHidden=1
    }
}
