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

    @IBOutlet weak var imageView: UIImageView! // 画像を表示するImageView

    @IBOutlet weak var locationLabel: UILabel! // PHAssetを使って、画像の位置情報を表示するラベル

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    // UIImagePickerControllerを起動するボタンのメソッド
    @IBAction func didSeletectedPresentImagePickerButton(_ sender: UIButton) {

        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        // imageViewに取得した画像を表示
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image

        // ここからPhotosにアクセス
        let url: URL? = info[UIImagePickerControllerReferenceURL] as? URL // 画像の保存場所を取得
        // 画像の保存場所を取得して、fetchAssetに渡して、PHAssetを取得、optional binding
        if let asset: PHAsset = fetchAsset(from: url), let location = asset.location {

            // locationLabelに緯度経度を表示
            locationLabel.text = "Location: \nlatitude...\(location.coordinate.latitude), \nlongtitude: \(location.coordinate.longitude)"
        }


        dismiss(animated: true, completion: nil)
    }

    // 画像の保存場所をURL型でもらって、Photosにアクセスするメソッド
    func fetchAsset(from url: URL?) -> PHAsset? {

        // optional binding
        guard let url: URL = url else {

            return nil
        }

        // Photosで画像にアクセス。Locationとかの情報の入ったPHAssetを取得
        let asset: PHAsset? = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject // ここからLocationとかを取得するとよい
        return asset
    }
}

