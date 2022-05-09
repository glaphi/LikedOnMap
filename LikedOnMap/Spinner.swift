//
//  Spinner.swift
//  LikedOnMap
//
//  Created by Glafira on 8.5.2022.
//

import SwiftUI

struct Spinner: View {
    var body: some View {

        VStack {
            Spacer()

            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(tint: Color(.systemGray))
                )

            Spacer()

            Image(systemName: "map")
                .resizable()
                .padding()
                .aspectRatio(contentMode: .fit)

            Spacer()
        }
    }
}
