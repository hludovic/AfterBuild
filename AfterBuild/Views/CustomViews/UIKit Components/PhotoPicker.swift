//
//  PhotoPicker.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 05/09/2023.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage
    @Environment(\.dismiss) var dismiss

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(photoPicker: self)
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPicker

        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                photoPicker.image = image
            }
            photoPicker.dismiss()
        }
    }
}
