//
//  Background.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 20.01.2025.
//

import SwiftUI

struct Background: View {
    var isLoadingBG = true
    var body: some View {
        Image(isLoadingBG ? "bgLoading" : "bgGame")
            .resizable()
            .ignoresSafeArea()
    }
}

#Preview {
    Background()
}
