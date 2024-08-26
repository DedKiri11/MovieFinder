//
//  LiquidSwipeView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 08.08.2024.
//

import SwiftUI

struct NavigationSwipeView: View {
    @State var rightData = SliderData(side: .right)
    @State var isShare = false
    @State var topSlider = SliderSide.right
    @State var sliderOffset: CGFloat = 0
    var color = Color.blue
    var movie: Movie

    var body: some View {
        ZStack {
            slider(data: $rightData)
        }
    }

    func slider(data: Binding<SliderData>) -> some View {
        let value = data.wrappedValue
        return ZStack {
            wave(data: data)
            button(data: value)
        }
        .zIndex(topSlider == value.side ? 1 : 0)
        .offset(x: value.side == .left ? -sliderOffset : sliderOffset)
    }

    func button(data: SliderData) -> some View {
        return ZStack {
            ShareButtonView(movie: movie, isActive: $isShare)
                .frame(width: 100, height: 100)
                .position(.zero)
        }
        .offset(data.buttonOffset)
        .opacity(data.buttonOpacity)
    }

    func wave(data: Binding<SliderData>) -> some View {
        let gesture = DragGesture().onChanged {
            self.topSlider = data.wrappedValue.side
            data.wrappedValue = data.wrappedValue.drag(value: $0)
        }
            .onEnded {
                if data.wrappedValue.isCancelled(value: $0) {
                    withAnimation(.spring(dampingFraction: 0.5)) {
                        data.wrappedValue = data.wrappedValue.initial()
                    }
                } else {

                    self.swipe(data: data)
                    isShare = true
                }
            }
            .simultaneously(with: TapGesture().onEnded {
                self.topSlider = data.wrappedValue.side
                self.swipe(data: data)
                isShare = true
            })
        return WaveView(data: data.wrappedValue).gesture(gesture)
            .foregroundColor(color)
    }

    private func swipe(data: Binding<SliderData>) {
        withAnimation {
            data.wrappedValue = data.wrappedValue.final()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.rightData = self.rightData.initial()

            self.sliderOffset = 100
            withAnimation(.spring(dampingFraction: 0.5)) {
                self.sliderOffset = 0
            }
        }
    }

}

#Preview {
    NavigationSwipeView(movie: Movie.default)
}
