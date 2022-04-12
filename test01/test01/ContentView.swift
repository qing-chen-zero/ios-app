//
//  ContentView.swift
//  test01
//
//  Created by Qingchen on 2022/4/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView { // 使用NavigationView 实现界面跳转
            //使用跳转链接实现点击跳转
            NavigationLink("Click me！", destination:NavigateTo())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
