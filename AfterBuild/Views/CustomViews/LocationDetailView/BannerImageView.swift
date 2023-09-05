//
//  BannerImageView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import SwiftUI


struct BannerImageView: View {
    var image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct BannerImageView_Previews: PreviewProvider {
    static var previews: some View {
        BannerImageView(image: PlaceholderImage.banner)
    }
}
