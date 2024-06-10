//
//  TimerConfiguration+Calculations.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

extension TimerConfiguration {
    func progress(for storyIndex: Int) -> CGFloat {
        if storiesCount <= 0 {
            return 1 // переход в след сторипак
        }
        return min(CGFloat(storyIndex) / CGFloat(storiesCount), 1)
    }

    func index(for progress: CGFloat) -> Int {
        return min(Int(progress * CGFloat(storiesCount)), storiesCount - 1)
    }

    func nextProgress(progress: CGFloat) -> CGFloat {
        return min(progress + progressPerTick, 1)
    }
}
