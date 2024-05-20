//
//  LogoNavBarView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/19/24.
//

import SwiftUI

struct LogoNavBarView: View {
    var body: some View {
        HStack {
            Image(ImageResource.mozzartLogo)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text("MOZZART")
                .foregroundStyle(Color.mozzartYellow)
                .font(Constants.CustomFont.Linotte.heavy32)
        }
        .padding([.top, .bottom], 10)
    }
}

#Preview {
    LogoNavBarView()
}
