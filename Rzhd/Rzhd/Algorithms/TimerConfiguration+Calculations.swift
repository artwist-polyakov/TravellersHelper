//
//  TimerConfiguration+Calculations.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

extension TimerConfiguration {
    func progress(for storyIndex: Int) -> CGFloat {
        return min(CGFloat(storyIndex) / CGFloat(storiesCount), 1)
    }

    func index(for progress: CGFloat) -> Int {
        print("progress: \(progress), index: \(min(Int(progress * CGFloat(storiesCount)), storiesCount - 1))")
        return min(Int(progress * CGFloat(storiesCount)), storiesCount - 1)
    }

    func nextProgress(progress: CGFloat) -> CGFloat {
        return min(progress + progressPerTick, 1)
    }
}
