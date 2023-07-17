//
//  UIViewControllerExtension.swift
//  TrainingApp
//
//  Created by Grigore on 19.06.2023.
//

import UIKit

extension UIViewController {
    //
    func presentSimpleAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    //
    func presentAlertForFinishButton(title: String, message: String?, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completionHandler()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    //
    func alertPhotoOrCamera(completionHandler: @escaping (UIImagePickerController.SourceType) -> Void) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            let camera = UIImagePickerController.SourceType.camera
            completionHandler(camera)
        }
        
        let photoGallery = UIAlertAction(title: "Library", style: .default) { _ in
            let photoGallery = UIImagePickerController.SourceType.photoLibrary
            completionHandler(photoGallery)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(camera)
        alertController.addAction(photoGallery)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}
