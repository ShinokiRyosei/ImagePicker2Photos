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
        // 画像の保存場所を取得して、fetchAssetに渡して、PHAssetを取得
        if let asset: PHAsset = fetchAsset(from: url), let location = asset.location {

            locationLabel.text = "Location: latitude...\(location.coordinate.latitude), longtitude: \(location.coordinate.longitude)"
        }


        dismiss(animated: true, completion: nil)
    }

    // 画像の保存場所をURL型でもらって、Photosにアクセスするメソッド
    func fetchAsset(from url: URL?) -> PHAsset? {

        // optional bingding
        guard let url: URL = url else {

            return nil
        }

        // Photosで画像にアクセス。Locationとかの情報の入ったPHAssetを取得
        let asset: PHAsset? = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject // ここからLocationとかを取得するとよい
        return asset
    }
}

