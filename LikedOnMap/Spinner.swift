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

            HStack {
                Spacer()

                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .aspectRatio(contentMode: .fit)

                Spacer()
            }

            Spacer()
        }
    }
}
