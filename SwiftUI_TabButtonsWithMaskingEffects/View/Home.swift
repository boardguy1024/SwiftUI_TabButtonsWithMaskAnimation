//
//  Home.swift
//  SwiftUI_TabButtonsWithMaskingEffects
//
//  Created by paku on 2023/12/10.
//

import SwiftUI

struct Home: View {
    
    @State var offset: CGFloat = 0
    @State var currentTab: Tab = tabs.first!
    var body: some View {
        
        GeometryReader { proxy in
            let screenSize = proxy.size
            
            
            ZStack(alignment: .top) {
                TabView(selection: $currentTab) {
                    ForEach(tabs) { tab in
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            Image(tab.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipped()
                        }
                        .tag(tab)
                        .ignoresSafeArea()
                        .offsetX(changed: { value in
                            
                            // index0 : 0~393 * 0
                            // index1 : 0~393 * 1
                            // index2 : 0~393 * 2
                            if currentTab == tab {
                                let offset = screenSize.width * CGFloat(indexOf(tab: tab))
                                self.offset = value - offset
                            }
                        })
                    }
                }
                .ignoresSafeArea()
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Header(size: screenSize)
            }
            .frame(width: screenSize.width, height: screenSize.height)
        }
        
        
       
    }
    
    @ViewBuilder
    func Header(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 22) {
            Text("Dynamic Tabs")
                .font(.title.bold())
                .foregroundStyle(.white)
            
            HStack(spacing: 0) {
                ForEach(tabs) { tab in
                    Text(tab.name)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
            }
            .background(alignment: .bottomLeading) {
                Capsule()
                    .fill(.white)
                    .frame(width: size.width / CGFloat(tabs.count), height: 4)
                    .offset(y: 14)
                    .offset(x: tabOffset(size: size))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .ignoresSafeArea()
        }
    }
    
    func tabOffset(size: CGSize) -> CGFloat {
        
        print("offset: \(offset / size.width)")
        
        // first: 0
        // center: 0.333
        // last: 1
        
        // 12: padding
        
        let tabsCount = CGFloat(tabs.count)
        let padding = tabsCount * 15
        
        let underlineWidth = (size.width - padding) / tabsCount
        
        return (-offset / size.width) * underlineWidth
    }
    
    func indexOf(tab: Tab) -> Int {
        tabs.firstIndex(where: { $0 == tab}) ?? 0
    }
}

#Preview {
    ContentView()
}
