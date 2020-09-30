//
//  HomeTabView.swift
//  wefitbby-ios
//
//  Created by Avin Tech on 26/9/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView{
            HomeView().tabItem {
                //Image(systemName: "tv.fill")
                Text("Home Tab")}
            DiscoverView().tabItem {
                //Image(systemName: "tv.fill")
                Text("Discover Tab")}
            WorkoutView().tabItem {
                //Image(systemName: "tv.fill")
                Text("Workout Tab")}
            ProfileView().tabItem {
                //Image(systemName: "tv.fill")
                Text("Profile Tab")}
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
    }
}

struct DiscoverView: View {
    var body: some View {
        Text("Discover")
    }
}

struct WorkoutView: View {
    var body: some View {
        Text("Workout")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile")
    }
}


struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
