//
//  ViewController.swift
//  ImagePicker2Photos
//
//  Created by ShinokiRyosei on 2017/09/03.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit

import Photos

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

        // ここからPhotosにアクセス
        let url: URL? = info[UIImagePickerControllerReferenceURL] as? URL // 画像の保存場所を取得
        fetchAsset(from: url) // 画像の保存場所を取得して、fetchAssetに渡す


        dismiss(animated: true, completion: nil)
    }

    // 画像の保存場所をURL型でもらって、Photosにアクセスするメソッド
    func fetchAsset(from url: URL?) {

        // optional bingding
        guard let url: URL = url else {

            return
        }

        // Photosで画像にアクセス。Locationとかの情報の入ったPHAssetを取得
        let asset: PHAsset? = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject // ここからLocationとかを取得するとよい
        
    }
}

