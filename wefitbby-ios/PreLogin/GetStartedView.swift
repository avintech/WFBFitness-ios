//
//  GetStartedView.swift
//  wefitbby-ios
//
//  Created by avintech on 25/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct PagingView<Content>: View where Content: View {

    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content

    @State private var offset = CGFloat.zero
    @State private var dragging = false
    @State private var navigateToLogin = false

    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        self.content()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry), y: 0)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragging = true
                        self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                    }
                    .onEnded { value in
                        let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                        let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                        self.index = self.clampedIndex(from: predictedIndex)
                        withAnimation(.easeOut) {
                            self.dragging = false
                        }
                    }
                )
            }
            .clipped()
            VStack{
                PageControl(index: $index, maxIndex: maxIndex)
                
                HStack{
                    Spacer()
                    Button(action: {
                        navigateToLogin = true
                    }) {
                      LoginViewButton(btnText: "Get Started")
                    }
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.init(red: 64/255, green: 181/255, blue: 230/255), lineWidth: 1.5)
                )
                .padding()
                .padding(.bottom, 40)
                NavigationLink( destination: LoginView(loginRouter: loginRouter()), isActive: self.$navigateToLogin){EmptyView()}
                
            }
        }
    }

    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        } else {
            return -CGFloat(self.index) * geometry.size.width
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                if index == self.index{
                    Image("PageControlShape")
                        .frame(width: 8, height: 8)
                }
                else{
                    Circle()
                        .fill(Color.init(red: 188/255, green: 202/255, blue: 239/255))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(15)
    }
}

struct GetStartedView: View {
    @State var index = 0

    var images = ["getstartedview-1", "getstartedview-2", "getstartedview-3"]

    var body: some View {
        NavigationView{
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(self.images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                }
            }/*.navigationBarTitle("")
            .navigationBarHidden(true)*/
            .edgesIgnoringSafeArea(.all)
        }.accentColor(.white)
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
