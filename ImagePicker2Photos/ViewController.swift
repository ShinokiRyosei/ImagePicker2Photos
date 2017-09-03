//
//  ViewController.swift
//  ImagePicker2Photos
//
//  Created by ShinokiRyosei on 2017/09/03.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    @IBAction func didSeletectedPresentImagePickerButton(_ sender: UIButton) {

        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}

