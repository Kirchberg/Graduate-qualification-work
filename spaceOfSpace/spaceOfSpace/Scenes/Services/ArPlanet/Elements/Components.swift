import UIKit
import SceneKit
import SceneKit.ModelIO

extension ServicesArPlanetViewController{
    func setupButtons(){
        setupBackButton()
        setupInfoButton()
        setupClearButton()
        setupAddButton()
        setupAutoSpinButton()
        setupRemoveButton()
        setupPhotoButton()
        setupSetObjButton()
    }
    
    func setupSetObjButton(){
        view.addSubview(buttonSetObject)
        buttonSetObject.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonSetObject.layer.cornerRadius=15
        buttonSetObject.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        let img=UIImage(systemName: "checkmark", withConfiguration: imageConfig)
        buttonSetObject.imageView?.tintColor = .white
        
        buttonSetObject.setImage(img, for: .normal)
        buttonSetObject.setTitleColor(UIColor.white, for: .normal)
        buttonSetObject.translatesAutoresizingMaskIntoConstraints=false
        setObjBottomConst=buttonSetObject.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(hidingDistance))
        NSLayoutConstraint.activate([
            buttonSetObject.widthAnchor.constraint(equalToConstant: 50),
            buttonSetObject.heightAnchor.constraint(equalToConstant: 50),
            setObjBottomConst!,
            buttonSetObject.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        buttonSetObject.addTarget(self, action: #selector(setObject), for: .touchUpInside)
    }
    
    @objc func setObject(){
        guard let cameraTransform = sceneView.sceneView.session.currentFrame?.camera.transform,
              let focusSquarePosition = focusSquare.lastPosition else { return }
        sceneView.setObject(focusSquarePosition, relativeTo: cameraTransform)
        hideSetObjectButton()
    }
    func hideSetObjectButton(){
        if buttonAdd.alpha == 0{
            UIView.animate(withDuration: 0.3, animations:  { [self] () -> Void in
                buttonAdd.alpha=0.6
                addBottomConst?.constant += -CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.3, animations: { [self] () -> Void in
                buttonSetObject.alpha=0
                setObjBottomConst?.constant += CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
            })
            focusSquare.hide()
            isObjectVisible=true
        }
    }
    
    func showSetObjButton(){
            UIView.animate(withDuration: 0.3, animations:  { [self] () -> Void in
                buttonAdd.alpha=0
                addBottomConst?.constant += CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.3, animations: { [self] () -> Void in
                buttonSetObject.alpha=0.6
                setObjBottomConst?.constant += -CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
            })
        focusSquare.unhide()
        isObjectVisible=false
    }
    
    func setupPhotoButton(){
        view.addSubview(photoButton)
        photoButton.backgroundColor=UIColor(rgb: 0x1C1C1E)
        photoButton.layer.cornerRadius=15
        photoButton.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        let img=UIImage(systemName: "camera", withConfiguration: imageConfig)
        photoButton.imageView?.tintColor = .white
        
        photoButton.setImage(img, for: .normal)
        photoButton.setTitleColor(UIColor.white, for: .normal)
        photoButton.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            photoButton.widthAnchor.constraint(equalToConstant: 70),
            photoButton.heightAnchor.constraint(equalToConstant: 70),
            photoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            photoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
        photoButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        
    }
    
    func setupAutoSpinButton(){
        view.addSubview(buttonAutoSpin)
        buttonAutoSpin.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonAutoSpin.layer.cornerRadius=15
        buttonAutoSpin.alpha=0.6

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "play", withConfiguration: imageConfig)
        buttonAutoSpin.imageView?.tintColor = .white
        buttonAutoSpin.setImage(img, for: .normal)
        buttonAutoSpin.setTitleColor(UIColor.white, for: .normal)
        buttonAutoSpin.translatesAutoresizingMaskIntoConstraints=false
        spinAutoBottomConst=buttonAutoSpin.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(hidingDistance))
        guard let constr=spinAutoBottomConst else{return}
        NSLayoutConstraint.activate([
            buttonAutoSpin.widthAnchor.constraint(equalToConstant: 50),
            buttonAutoSpin.heightAnchor.constraint(equalToConstant: 50),
            constr,
            buttonAutoSpin.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40)
        ])
        
        buttonAutoSpin.addTarget(self, action: #selector(autoSpin(_:)), for: .touchUpInside)
        self.buttonAutoSpin.frame.origin.y+=CGFloat(hidingDistance)
        
    }
    
    @objc func autoSpin(_ button:UIButton){
        if let obj=self.sceneView.manager.ChoosenObject{
            if (obj.isSpinning) {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
                let img=UIImage(systemName: "play", withConfiguration: imageConfig)
                buttonAutoSpin.imageView?.tintColor = .white
                buttonAutoSpin.setImage(img, for: .normal)
                    obj.pauseAnimation()
            } else {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
                let img=UIImage(systemName: "pause", withConfiguration: imageConfig)
                buttonAutoSpin.imageView?.tintColor = .white
                buttonAutoSpin.setImage(img, for: .normal)
                obj.animate()
            }
        }
    }
    
    func setupRemoveButton(){
        view.addSubview(buttonRemove)
        buttonRemove.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonRemove.layer.cornerRadius=15
        buttonRemove.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "xmark.bin", withConfiguration: imageConfig)
        buttonRemove.setImage(img, for: .normal)
        buttonRemove.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        buttonRemove.imageView?.tintColor = .white
        buttonRemove.setTitleColor(UIColor.white, for: .normal)
        buttonRemove.translatesAutoresizingMaskIntoConstraints=false
        removeBottomConst=buttonRemove.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(hidingDistance))
        guard let constr=removeBottomConst else{return}
        NSLayoutConstraint.activate([
            buttonRemove.widthAnchor.constraint(equalToConstant: 50),
            buttonRemove.heightAnchor.constraint(equalToConstant: 50),
           constr,
            buttonRemove.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40)
        ])
        buttonRemove.addTarget(self, action: #selector(removeItem(_:)), for: .touchUpInside)
        self.buttonRemove.frame.origin.y+=CGFloat(hidingDistance)
    }
    
    @objc func removeItem(_ button:UIButton){
        var i:Int=0
        self.sceneView.manager.Objects.forEach({
            if $0 === self.sceneView.manager.ChoosenObject{
                self.sceneView.manager.Objects.remove(at: i)
                self.sceneView.manager.ChoosenObject?.object.removeFromParentNode()
                self.sceneView.manager.ChoosenObject?.orbitView.removeFromParentNode()
                self.sceneView.manager.ChoosenObject?.root.removeFromParentNode()
                self.sceneView.isChoosen=false
                self.loseObject()
                return
            }
            i+=1
        })
        self.sceneView.manager.ChoosenObject?.object.removeFromParentNode()
        self.sceneView.manager.ChoosenObject?.orbitView.removeFromParentNode()
        self.sceneView.manager.ChoosenObject?.root.removeFromParentNode()
        
    }
    
    func setupBackButton(){
        view.addSubview(buttonBack)
        buttonBack.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonBack.layer.cornerRadius=15
        buttonBack.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "arrow.uturn.backward", withConfiguration: imageConfig)
        buttonBack.imageView?.tintColor = .white

        buttonBack.setImage(img, for: .normal)
        buttonBack.setTitleColor(UIColor.white, for: .normal)
        buttonBack.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            buttonBack.widthAnchor.constraint(equalToConstant: 50),
            buttonBack.heightAnchor.constraint(equalToConstant: 50),
            buttonBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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
    
    func setupInfoButton(){
        view.addSubview(buttonInfo)
        buttonInfo.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonInfo.layer.cornerRadius=15
        buttonInfo.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "info.circle", withConfiguration: imageConfig)
        buttonInfo.imageView?.tintColor = .white
        buttonInfo.setImage(img, for: .normal)
        buttonInfo.setTitleColor(UIColor.white, for: .normal)
        buttonInfo.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            buttonInfo.widthAnchor.constraint(equalToConstant: 50),
            buttonInfo.heightAnchor.constraint(equalToConstant: 50),
            buttonInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupClearButton(){
        view.addSubview(buttonClear)
        buttonClear.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonClear.layer.cornerRadius=15
        buttonClear.alpha=0.6
        buttonClear.setTitle("Clear", for: .normal)
        buttonClear.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        buttonClear.setTitleColor(UIColor.white, for: .normal)
        
        buttonClear.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            buttonClear.widthAnchor.constraint(equalToConstant: 90.91),
            buttonClear.heightAnchor.constraint(equalToConstant: 50),
            buttonClear.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonClear.trailingAnchor.constraint(equalTo: buttonInfo.leadingAnchor, constant: -9)
        ])
        buttonClear.addTarget(self, action: #selector(restartSession), for: .touchUpInside)
    }
    
    func setupAddButton(){
        view.addSubview(buttonAdd)
        buttonAdd.backgroundColor=UIColor(rgb: 0x1C1C1E)
        buttonAdd.layer.cornerRadius=15
        buttonAdd.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img=UIImage(systemName: "plus", withConfiguration: imageConfig)
        buttonAdd.imageView?.tintColor = .white
        buttonAdd.setImage(img, for: .normal)
        
        buttonAdd.translatesAutoresizingMaskIntoConstraints=false
        addBottomConst=buttonAdd.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            buttonAdd.widthAnchor.constraint(equalToConstant: 50),
            buttonAdd.heightAnchor.constraint(equalToConstant: 50),
            addBottomConst!,
            buttonAdd.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        buttonAdd.addTarget(self, action: #selector(arCollection(_:)), for: .touchUpInside)
    }
    
    @objc func arCollection(_ button:UIButton){
        if !isSystem {
            sheetVc.view.backgroundColor=UIColor.clear
            sheetVc.view.layer.cornerRadius=15
            sheetVc.view.alpha=1
            
            sheetVc.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(sheetVc.view)
            
            NSLayoutConstraint.activate([
                sheetVc.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                sheetVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                sheetVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                sheetVc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        }
    }
    
    @objc func restartSession(){
        if !isSystem{
            self.sceneView.sceneView.session.pause()
            self.sceneView.sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
                node.removeFromParentNode()
            }
            self.sceneView.sceneView.session.run(self.sceneView.configuration, options: [.resetTracking, .removeExistingAnchors])
            self.sceneView.manager.Objects.removeAll()
            self.sceneView.manager.ChoosenObject=nil
        } else {
//            self.sceneSystem.sceneView.session.pause()
//            self.sceneSystem.sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
//                node.removeFromParentNode()
//            }
//            self.sceneSystem.sceneView.session.run(self.sceneSystem.configuration, options: [.resetTracking, .removeExistingAnchors])
//            self.sceneSystem.sys.Solar.removeAll()
        }
        
    }
    
    @objc func takePhoto(){
        
       
        let image=self.sceneView.sceneView.snapshot()
        UIImageWriteToSavedPhotosAlbum(image, self,
                #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)

        
//        if !isSystem{
//            takeScreenshot(view: self.scenePlanet)
//            takeScreenshot(view: self.sceneSystem)
//        } else {
//            takeScreenshot(view: self.scenePlanet)
//            takeScreenshot(view: self.sceneSystem)
//        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                // we got back an error!
                let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
}


