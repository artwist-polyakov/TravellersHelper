//
//  StoriesProgressBar.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI
import Combine

struct StoriesProgressBar: View {
    let storiesCount: Int
    @Binding var timerConfiguration: TimerConfiguration
    @Binding var currentProgress: CGFloat
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?

    init(storiesCount: Int, timerConfiguration: Binding<TimerConfiguration>, currentProgress: Binding<CGFloat>) {
        self.storiesCount = storiesCount
        self._timerConfiguration = timerConfiguration
        self._currentProgress = currentProgress
        self.timer = Self.makeTimer(configuration: timerConfiguration.wrappedValue)
    }

    var body: some View {
        ProgressBar(numberOfSections: storiesCount, progress: currentProgress)
            .padding(.init(top: 7, leading: 12, bottom: 12, trailing: 12))
            .onAppear {
                timer = Self.makeTimer(configuration: timerConfiguration)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
    }

    private func timerTick() {
        withAnimation {
            currentProgress = timerConfiguration.nextProgress(progress: currentProgress)
        }
    }
}

extension StoriesProgressBar {
    private static func makeTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

extension StoriesProgressBar {
    func resetTimer() {
        cancellable?.cancel()
        timer = Self.makeTimer(configuration: timerConfiguration)
        cancellable = timer.connect()
    }
}

