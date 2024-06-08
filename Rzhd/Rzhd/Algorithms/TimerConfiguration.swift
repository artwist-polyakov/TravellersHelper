//
//  TimerConfiguration.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import Foundation

struct TimerConfiguration {
    let storiesCount: Int
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    let onFinishCallback: () -> Void

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25,
        onFinishCallback: @escaping () -> Void
    ) {
        self.storiesCount = storiesCount
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
        self.onFinishCallback = onFinishCallback
    }
}
